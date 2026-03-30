# Kit-Gen Quick Reference

## Install

```bash
dart pub global activate --source git https://github.com/Tagaddod/Tagaddod-NewUi-Kit.git --git-path kit-gen-dart
kit-gen config set-key
```

Get key: https://aistudio.google.com/apikey

---

## Add UI Kit to Your App

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

---

## Generate

```bash
kit-gen gen -i                              # Interactive
kit-gen gen -r "requirement"                # Direct
kit-gen gen -r "requirement" -o file.dart   # Save to file
```

---

## Explore

```bash
kit-gen info                # All components
kit-gen search button       # Find components
```

---

## Examples

```bash
kit-gen gen -r "Login screen with email, password, and login button"
kit-gen gen -r "Product card with image, title, price, and add button"
kit-gen gen -r "Settings page with profile section and logout button"
```

---

## Cost

- **FREE:** 1,500 requests/day
- **Paid:** ~$0.02 per screen

---

**Full guide:** [FOR-USERS.md](FOR-USERS.md)
