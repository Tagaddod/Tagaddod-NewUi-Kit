# Kit-Gen

AI-powered Flutter code generator using Tagaddod UI Kit.

**Pure Dart** | **Gemini 2.0 Flash** | **FREE Tier** | **$0.01/screen**

---

## For Users (Install & Use)

### Install (one command):

```bash
dart pub global activate --source git https://github.com/Tagaddod/Tagaddod-NewUi-Kit.git --git-path kit-gen-dart
```

### Configure (one time):

```bash
kit-gen config set-key
```

Get FREE API key: https://aistudio.google.com/apikey

### Use anywhere:

```bash
cd your-project
kit-gen gen -i
```

**See [FOR-USERS.md](FOR-USERS.md) for complete user guide.**

---

## For Maintainers

### Update Manifest

When adding widgets to the kit:

```bash
cd kit-gen-dart
dart run kit_gen manifest
cp data/components.json lib/data/components.json
git add lib/data/components.json
git commit -m "Update manifest"
git push
```

Users get updates automatically on next install.

---

## Commands

```bash
kit-gen gen -i                  # Generate (interactive)
kit-gen gen -r "requirement"    # Generate (direct)
kit-gen gen -r "..." -o file.dart  # Save to file
kit-gen info                    # Show all widgets
kit-gen search <query>          # Search components
kit-gen config set-key          # Set API key
kit-gen config show             # Show config
```

---

## Cost

- **Free tier:** 1,500 requests/day (covers everything!)
- **Paid:** $0.01 per screen (85% cheaper than Claude)
- **Reality:** Probably $0/month

---

## How It Works

```
User requirement
      ↓
Gemini 2.0 Flash + Kit manifest
      ↓
Flutter code (kit components only)
```

**Time:** 30 seconds  
**Cost:** $0.01 or FREE  
**Saves:** 40 minutes per screen

---

## Project Structure

```
kit-gen-dart/
├── bin/kit_gen.dart              # CLI entry point
├── lib/
│   ├── commands/                 # Commands (gen, info, search, config)
│   ├── services/                 # Gemini API, manifest, prompt
│   ├── config/                   # API key management
│   └── data/components.json      # Pre-built manifest (bundled)
├── pubspec.yaml
├── README.md                     # This file
├── FOR-USERS.md                  # User guide
└── QUICKSTART.md                 # Quick reference
```

---

## Using Generated Code in Your App

### The UI Kit Dependency

Generated code imports from `tagaddod_ui_kit`:

```dart
import 'package:tagaddod_ui_kit/widgets/app_text_field.dart';
import 'package:tagaddod_ui_kit/widgets/button/app_filled_button.dart';
```

### Add UI Kit to Your App

In your Flutter app's `pubspec.yaml`:

```yaml
dependencies:
  tagaddod_ui_kit:
    git:
      url: https://github.com/Tagaddod/Tagaddod-NewUi-Kit.git
      path: .
```

Or if using local path:

```yaml
dependencies:
  tagaddod_ui_kit:
    path: ../Tagaddod-NewUi-Kit
```

Then:

```bash
flutter pub get
```

Now the generated code will work!

---

## Complete Workflow

### 1. Install Kit-Gen (once)

```bash
dart pub global activate --source git https://github.com/Tagaddod/Tagaddod-NewUi-Kit.git --git-path kit-gen-dart
kit-gen config set-key
```

### 2. Add UI Kit to Your App (once per app)

```yaml
# pubspec.yaml
dependencies:
  tagaddod_ui_kit:
    git:
      url: https://github.com/Tagaddod/Tagaddod-NewUi-Kit.git
```

```bash
flutter pub get
```

### 3. Generate Screens (anytime)

```bash
cd your-app
kit-gen gen -r "Create a login screen" -o lib/screens/login.dart
```

### 4. Use the Code

The generated code is ready to use - just add your business logic!

---

## Support

- **User guide:** [FOR-USERS.md](FOR-USERS.md)
- **Quick reference:** [QUICKSTART.md](QUICKSTART.md)
- **Questions:** Contact Flutter Team Lead

---

**Ready?** See [FOR-USERS.md](FOR-USERS.md) to get started!
