#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
# deploy.sh — One-command deploy to Firebase Hosting + Cloud Run
#
# First-time setup (run once):
#   brew install firebase-cli
#   # Install gcloud from: https://cloud.google.com/sdk/docs/install
#   gcloud auth login
#   gcloud config set project YOUR_PROJECT_ID
#   firebase login
#   gcloud services enable run.googleapis.com cloudbuild.googleapis.com \
#     containerregistry.googleapis.com
#
# Required env vars (MUST be set in your shell when you deploy — Cloud Run
# stores whatever values gcloud sends; empty export = broken API in prod):
#   export GEMINI_API_KEY="your-gemini-key"
#   export GITHUB_TOKEN="your-github-token"
#
# Daily usage:
#   GCP_PROJECT=your-project-id ./deploy.sh
# ─────────────────────────────────────────────────────────────────────────────
set -euo pipefail

# Locate gcloud — works in interactive shells, CI, and non-login shells
GCLOUD=$(command -v gcloud 2>/dev/null \
  || ls ~/Downloads/google-cloud-sdk/bin/gcloud 2>/dev/null \
  || ls ~/google-cloud-sdk/bin/gcloud 2>/dev/null \
  || ls /usr/local/google-cloud-sdk/bin/gcloud 2>/dev/null \
  || echo "")

if [[ -z "$GCLOUD" ]]; then
  echo "ERROR: gcloud not found. Install: https://cloud.google.com/sdk/docs/install"
  exit 1
fi

GCP_PROJECT=${GCP_PROJECT:-$("$GCLOUD" config get-value project 2>/dev/null)}
REGION=${REGION:-us-central1}

if [[ -z "$GCP_PROJECT" ]]; then
  echo "ERROR: set GCP_PROJECT env var or run: gcloud config set project YOUR_ID"
  exit 1
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Kit-Gen deploy → Firebase + Cloud Run"
echo "  Project : $GCP_PROJECT"
echo "  Region  : $REGION"
echo "  gcloud  : $GCLOUD"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

FIREBASE=$(command -v firebase 2>/dev/null \
  || ls /opt/homebrew/bin/firebase 2>/dev/null \
  || ls /usr/local/bin/firebase 2>/dev/null \
  || echo "")

if [[ -z "$FIREBASE" ]]; then
  echo "ERROR: firebase CLI not found. Install: npm install -g firebase-tools"
  exit 1
fi

GIT_SHA=$(git rev-parse --short HEAD 2>/dev/null || echo "latest")
TAG="${GIT_SHA}"
IMAGE="gcr.io/${GCP_PROJECT}/kit-gen-server"

# Cloud Build tarball must contain these paths or preview fails in Cloud Run.
if [[ ! -f fonts/outfit/Outfit-Regular.ttf ]] || [[ ! -d assets/svg ]]; then
  echo "ERROR: UI kit assets missing (fonts/outfit/Outfit-Regular.ttf or assets/svg)."
  echo "  Run from repo root with a full checkout (git pull / LFS pull)."
  exit 1
fi

# ── 1. Build Jaspr UI locally (for Firebase Hosting static files) ─────────────
echo "▶ 1/4  Building Jaspr UI..."
cd kit-gen-web/ui
dart pub get
export PATH="$PATH:$HOME/.pub-cache/bin"
jaspr build
# dart2js still emits //# sourceMappingURL=… even when .map is absent — Hosting
# then serves index.html for the .map URL and DevTools shows a JSON parse error.
python3 <<'PY'
import pathlib, re
p = pathlib.Path("build/jaspr/main.client.dart.js")
if p.exists():
    s = p.read_text(encoding="utf-8", errors="replace")
    p.write_text(re.sub(r"\n?//# sourceMappingURL=.*", "", s), encoding="utf-8")
PY
cd ../..

# ── 2. Cloud Build: build + push Docker image (linux/amd64 remote build) ──────
echo ""
echo "▶ 2/4  Building Docker image via Cloud Build..."
"$GCLOUD" builds submit \
  --project "$GCP_PROJECT" \
  --config cloudbuild.yaml \
  --substitutions="_TAG=$TAG" \
  .

# ── 3. Deploy to Cloud Run (local gcloud — no IAM setup needed) ───────────────
if [[ -z "${GEMINI_API_KEY:-}" ]]; then
  echo ""
  echo "ERROR: GEMINI_API_KEY is not set. Cloud Run will return 400 on /api/generate."
  echo "  export GEMINI_API_KEY='…'   # then re-run ./deploy.sh"
  echo "Or patch the live service (no redeploy):"
  echo "  gcloud run services update kit-gen-server --region=$REGION --project=$GCP_PROJECT \\"
  echo "    --update-env-vars=GEMINI_API_KEY=YOUR_KEY_HERE"
  exit 1
fi

echo ""
echo "▶ 3/4  Deploying to Cloud Run..."
"$GCLOUD" run deploy kit-gen-server \
  --image "${IMAGE}:${TAG}" \
  --platform managed \
  --region "$REGION" \
  --port 8080 \
  --memory 1Gi \
  --cpu 1 \
  --min-instances 1 \
  --max-instances 3 \
  --allow-unauthenticated \
  --project "$GCP_PROJECT" \
  --set-env-vars "AI_PROVIDER=gemini,GEMINI_API_KEY=${GEMINI_API_KEY:-},GITHUB_TOKEN=${GITHUB_TOKEN:-}"

# --allow-unauthenticated only works if the deployer can set IAM. If that silently
# fails, browsers get 403 "not authenticated" on the *.run.app URL.
echo ""
echo "▶ Ensuring anyone can invoke Cloud Run (allUsers → run.invoker)…"
if "$GCLOUD" run services add-iam-policy-binding kit-gen-server \
    --region="$REGION" \
    --project="$GCP_PROJECT" \
    --member="allUsers" \
    --role="roles/run.invoker" \
    --quiet 2>/dev/null; then
  echo "  ✓ Public API: unauthenticated POSTs allowed"
else
  echo "  ! FAILED — a project Owner / Cloud Run Admin must run:"
  echo "    gcloud run services add-iam-policy-binding kit-gen-server \\"
  echo "      --region=$REGION --project=$GCP_PROJECT \\"
  echo "      --member=allUsers --role=roles/run.invoker"
  echo "  (Without this, https://…run.app/api/* returns 403 from the browser.)"
fi

# Firebase Hosting rewrites /api/* → Cloud Run (same as direct run.app for CORS).
echo ""
echo "▶ Granting Firebase Hosting → Cloud Run (run.invoker)…"
PNUM=$("$GCLOUD" projects describe "$GCP_PROJECT" --format='value(projectNumber)' 2>/dev/null || true)
if [[ -n "$PNUM" ]]; then
  HOSTING_SA="service-${PNUM}@gcp-sa-firebasehosting.iam.gserviceaccount.com"
  if "$GCLOUD" run services add-iam-policy-binding kit-gen-server \
      --region="$REGION" \
      --project="$GCP_PROJECT" \
      --member="serviceAccount:${HOSTING_SA}" \
      --role="roles/run.invoker" \
      --quiet 2>/dev/null; then
    echo "  ✓ run.invoker granted to ${HOSTING_SA}"
  else
    echo "  ! Could not grant Hosting SA (optional if you use allUsers + same-origin only)."
    echo "    gcloud run services add-iam-policy-binding kit-gen-server \\"
    echo "      --region=$REGION --project=$GCP_PROJECT \\"
    echo "      --member=serviceAccount:${HOSTING_SA} --role=roles/run.invoker"
  fi
fi

# ── 4. Deploy Firebase Hosting (local firebase CLI) ───────────────────────────
echo ""
echo "▶ 4/4  Deploying to Firebase Hosting..."
"$FIREBASE" deploy --only hosting --project "$GCP_PROJECT"

CLOUD_RUN_URL=$("$GCLOUD" run services describe kit-gen-server \
  --platform managed --region "$REGION" --project "$GCP_PROJECT" \
  --format "value(status.url)" 2>/dev/null || echo "check GCP console")

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✓ Done!"
echo "  Frontend : https://${GCP_PROJECT}.web.app"
echo "  API      : ${CLOUD_RUN_URL}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
