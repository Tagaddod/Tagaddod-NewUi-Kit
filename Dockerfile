# ─────────────────────────────────────────────────────────────────────────────
# Stage 1 — Build the Jaspr frontend to static JS
# ─────────────────────────────────────────────────────────────────────────────
FROM dart:stable AS jaspr-builder

WORKDIR /build

COPY kit-gen-web/ui/pubspec.yaml kit-gen-web/ui/pubspec.lock* ./ui/
RUN cd ui && dart pub get

COPY kit-gen-web/ui/ ./ui/
RUN dart pub global activate jaspr_cli && \
    cd ui && jaspr build && \
    sed -i '/sourceMappingURL=/d' build/jaspr/main.client.dart.js

# ─────────────────────────────────────────────────────────────────────────────
# Stage 2 — Runtime image with Flutter + Dart server
# ─────────────────────────────────────────────────────────────────────────────
FROM debian:bookworm-slim

# System dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl git wget unzip xz-utils bash \
    libglu1-mesa lib32z1 libstdc++6 \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install Flutter (stable channel — must match local version)
ENV FLUTTER_ROOT=/flutter
ENV PATH="${FLUTTER_ROOT}/bin:${FLUTTER_ROOT}/bin/cache/dart-sdk/bin:${PATH}"
ARG FLUTTER_VERSION=3.38.3
RUN git clone --depth 1 --branch ${FLUTTER_VERSION} \
        https://github.com/flutter/flutter.git ${FLUTTER_ROOT} && \
    flutter config --enable-web && \
    flutter precache --web && \
    flutter doctor -v || true

# ── Repo layout (mirrors the local monorepo structure) ────────────────────────
WORKDIR /repo

# UI Kit package at /repo (preview_harness path dependency). Must include every
# path listed under flutter: assets / fonts in pubspec.yaml or `flutter run`
# fails inside ephemeral preview workspaces.
COPY lib/ ./lib/
COPY assets/ ./assets/
COPY fonts/ ./fonts/
COPY pubspec.yaml ./pubspec.yaml
COPY pubspec.lock ./pubspec.lock
COPY analysis_options.yaml ./analysis_options.yaml

# Flat copy for Flutter preview `path:` dependency — see KIT_GEN_UI_KIT_PATH.
RUN mkdir -p /opt/tagaddod-ui-kit
COPY lib/ /opt/tagaddod-ui-kit/lib/
COPY assets/ /opt/tagaddod-ui-kit/assets/
COPY fonts/ /opt/tagaddod-ui-kit/fonts/
COPY pubspec.yaml pubspec.lock analysis_options.yaml /opt/tagaddod-ui-kit/
ENV KIT_GEN_UI_KIT_PATH=/opt/tagaddod-ui-kit
RUN test -f /opt/tagaddod-ui-kit/fonts/outfit/Outfit-Regular.ttf \
    && test -d /opt/tagaddod-ui-kit/assets/svg \
    && test -n "$(ls -A /opt/tagaddod-ui-kit/assets/svg)"

# Component manifest
COPY kit-gen-dart/lib/data/ ./kit-gen-dart/lib/data/

# Preview harness template (keep {{UI_KIT_PATH}} placeholder intact)
COPY kit-gen-web/preview_harness/ ./kit-gen-web/preview_harness/

# Server source
COPY kit-gen-web/server/ ./kit-gen-web/server/

# Jaspr UI build (compiled static assets from Stage 1)
COPY --from=jaspr-builder /build/ui/build/jaspr/ ./kit-gen-web/ui/build/jaspr/

# Pre-fetch server Dart dependencies
RUN cd kit-gen-web/server && dart pub get

# Pre-fetch UI-kit root dependencies (needed by preview_harness workspaces)
RUN dart pub get

# Pre-warm Flutter pub cache for the preview harness.
# We resolve {{UI_KIT_PATH}} to /repo for the warm-up only; the workspace
# factory will copy the original template and do its own replacement at runtime.
RUN cd /tmp && \
    cp -r /repo/kit-gen-web/preview_harness ./preview_harness_warmup && \
    sed -i 's|{{UI_KIT_PATH}}|/repo|g' ./preview_harness_warmup/pubspec.yaml && \
    cd ./preview_harness_warmup && \
    flutter pub get && \
    cd / && rm -rf /tmp/preview_harness_warmup

EXPOSE 8080

WORKDIR /repo/kit-gen-web/server

CMD ["dart", "run", "bin/server.dart"]
