# Kit-Gen Workflow Guide

## For Users

### One-Time Setup

```bash
# 1. Install kit-gen globally
dart pub global activate --source git https://github.com/Tagaddod/Tagaddod-NewUi-Kit.git --git-path kit-gen-dart

# 2. Configure API key
kit-gen config set-key
```

Get FREE API key: https://aistudio.google.com/apikey

### Per-Project Setup

In your Flutter app's `pubspec.yaml`:

```yaml
dependencies:
  tagaddod_ui_kit:
    git:
      url: https://github.com/Tagaddod/Tagaddod-NewUi-Kit.git
```

Then:

```bash
flutter pub get
```

### Daily Usage

```bash
cd your-project
kit-gen gen -r "Login screen with email and password" -o lib/screens/login.dart
```

---

## For Maintainers

### Adding New Widgets to Kit

```bash
# 1. Create widget in UI kit
cd /path/to/Tagaddod-NewUi-Kit
# Add your widget to lib/widgets/

# 2. Update manifest
cd kit-gen-dart
dart run bin/kit_gen.dart manifest
cp data/components.json lib/data/components.json

# 3. Commit and push
git add lib/data/components.json
git commit -m "Add [WidgetName] to kit manifest"
git push
```

### How Manifest Updates Reach Users

1. You update `lib/data/components.json` and push
2. Users reinstall kit-gen (or install for first time):
   ```bash
   dart pub global activate --source git https://github.com/Tagaddod/Tagaddod-NewUi-Kit.git --git-path kit-gen-dart
   ```
3. New manifest is automatically included via `package:kit_gen/data/components.json`
4. Users immediately have access to new widgets

**No hardcoding needed!** The JSON file in `lib/data/` is automatically included in the package distribution and loaded via Dart's package URI resolution.

---

## Technical Details

### How Manifest Loading Works

```dart
// Development (in kit repo)
File('data/components.json')  // ✓ Works

// Global installation (anywhere)
Isolate.resolvePackageUri(Uri.parse('package:kit_gen/data/components.json'))  // ✓ Works
```

Files in `lib/` are automatically included when you do `dart pub global activate`.

### Why This Works

- Dart packages include ALL files in `lib/` directory
- `package:` URIs resolve to the installed package location
- No file path manipulation needed
- Works in development and production

---

## Branch Strategy

You're currently on `gen-kit` branch. Options:

### Option 1: Keep Separate Branch (Recommended for testing)

```bash
# Users install from gen-kit branch
dart pub global activate --source git https://github.com/Tagaddod/Tagaddod-NewUi-Kit.git --git-path kit-gen-dart --git-ref gen-kit
```

### Option 2: Merge to Main (When stable)

```bash
git checkout main
git merge gen-kit
git push origin main

# Users install from main (simpler)
dart pub global activate --source git https://github.com/Tagaddod/Tagaddod-NewUi-Kit.git --git-path kit-gen-dart
```

---

## Complete Example

### Scenario: Add StarRating Widget

```bash
# 1. Add widget to kit
cd /path/to/Tagaddod-NewUi-Kit
# Create lib/widgets/star_rating.dart

# 2. Update manifest
cd kit-gen-dart
dart run bin/kit_gen.dart manifest
cp data/components.json lib/data/components.json

# 3. Commit
git add lib/data/components.json
git commit -m "Add StarRating widget to manifest"
git push origin gen-kit

# 4. Users update (optional, or wait for next install)
# dart pub global activate --source git https://github.com/Tagaddod/Tagaddod-NewUi-Kit.git --git-path kit-gen-dart --git-ref gen-kit
```

Now when users generate code, they can use `StarRating`!

---

## Summary

✅ **JSON manifest** - Easy to update, no hardcoding  
✅ **Automatic distribution** - Files in `lib/` are included  
✅ **Package URI resolution** - Reliable loading anywhere  
✅ **Simple workflow** - Update JSON, commit, push, done  

No manual steps, no hardcoding, just pure Dart package management!
