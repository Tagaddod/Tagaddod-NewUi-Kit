# Kit-Gen User Guide

Complete guide for developers using Kit-Gen to generate Flutter screens.

---

## Installation

### Step 1: Install Kit-Gen

```bash
dart pub global activate --source git https://github.com/Tagaddod/Tagaddod-NewUi-Kit.git --git-path kit-gen-dart
```

### Step 2: Configure API Key

```bash
kit-gen config set-key
```

Get a FREE API key from: https://aistudio.google.com/apikey

**That's it!** You can now use `kit-gen` from anywhere.

---

## Using in Your Flutter App

### Add UI Kit Dependency

In your app's `pubspec.yaml`:

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

Now all generated code will work because it imports from `tagaddod_ui_kit`.

---

## Generating Screens

### Interactive Mode (Recommended)

```bash
cd your-app
kit-gen gen -i
```

You'll be prompted to enter your requirement. Example:

```
Create a login screen with:
- Email and password fields
- Remember me checkbox
- Login button
- Forgot password link
```

### Direct Mode

```bash
kit-gen gen -r "Create a user profile screen with avatar, name, email, and edit button"
```

### Save to File

```bash
kit-gen gen -r "Create a settings screen" -o lib/screens/settings_screen.dart
```

---

## Writing Good Requirements

### Good Examples

```
Create a login screen with email field, password field, remember me checkbox, and login button
```

```
Build a product card showing image, title, price, rating stars, and add to cart button
```

```
Design a settings page with sections for account, notifications, privacy, and logout
```

### Tips

- Be specific about UI elements needed
- Mention user interactions (buttons, taps, toggles)
- Describe layout (vertical list, grid, tabs)
- Include states if relevant (loading, error, empty)

---

## Understanding Output

### Screen Code

The main Flutter widget code, ready to use:

```dart
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
```

### Kit Gaps

If a component you need isn't in the kit, Kit-Gen will propose it:

```
Missing: StarRating widget
Proposed implementation included
```

You can:
1. Add the proposed widget to the UI kit
2. Modify the generated code to use alternatives
3. Request the kit team to add it

---

## Common Workflows

### 1. Quick Prototype

```bash
kit-gen gen -r "Dashboard with stats cards" > temp.dart
# Review, copy what you need
```

### 2. New Feature Screen

```bash
kit-gen gen -r "Order history list" -o lib/screens/order_history.dart
# Edit to add business logic
```

### 3. Explore Components

```bash
kit-gen info                    # See all widgets
kit-gen search button           # Find button variants
kit-gen search "text field"     # Find input components
```

---

## What Gets Generated

### ✅ Included

- Complete StatefulWidget/StatelessWidget
- UI kit imports
- Layout structure (Column, Row, Stack, etc.)
- All UI components from the kit
- Basic state management setup
- Placeholder business logic

### ❌ Not Included

- API integration
- Database/storage
- Navigation logic
- Complex business logic
- Authentication flow
- State management implementation (Cubit/Bloc)

**You add these!** Kit-Gen gives you the UI foundation.

---

## Tips & Best Practices

### 1. Start Simple

Generate basic screens first, then refactor to add:
- Cubit/Bloc for state
- Repository pattern for data
- Dependency injection

### 2. Review & Adapt

Generated code is a starting point:
- Check widget parameters
- Adjust spacing/sizing
- Add validation logic
- Connect to your data layer

### 3. Iterate

If output isn't perfect:
- Refine your requirement
- Be more specific
- Try again (it's FREE!)

### 4. Keep Kit Updated

```bash
dart pub global activate --source git https://github.com/Tagaddod/Tagaddod-NewUi-Kit.git --git-path kit-gen-dart
```

This updates both Kit-Gen and the manifest.

---

## Troubleshooting

### "API key not configured"

```bash
kit-gen config set-key
```

### "Component not found in kit"

Check the Kit Gaps section in output. Either:
- Use the proposed implementation
- Ask kit team to add it
- Use an alternative component

### Generated code has errors

Make sure you added `tagaddod_ui_kit` to your `pubspec.yaml`:

```yaml
dependencies:
  tagaddod_ui_kit:
    git:
      url: https://github.com/Tagaddod/Tagaddod-NewUi-Kit.git
```

Then run:

```bash
flutter pub get
```

### Want to update Kit-Gen

```bash
dart pub global activate --source git https://github.com/Tagaddod/Tagaddod-NewUi-Kit.git --git-path kit-gen-dart
```

---

## Cost & Limits

- **Free tier:** 1,500 requests/day
- **Typical usage:** 10-50 requests/day
- **Cost:** $0/month for most teams
- **Paid tier:** $0.01 per screen if you exceed free tier

---

## Examples

### Login Screen

```bash
kit-gen gen -r "Login screen with email, password, remember me checkbox, login button, and forgot password link"
```

### Product List

```bash
kit-gen gen -r "Product list screen with search bar, filter chips, and grid of product cards showing image, title, price"
```

### Profile Edit

```bash
kit-gen gen -r "Edit profile screen with avatar picker, name field, email field, phone field, and save button"
```

---

## Support

Questions? Contact your Flutter Team Lead or check:
- `kit-gen info` - See all available components
- `kit-gen search <query>` - Find specific components
- [QUICKSTART.md](QUICKSTART.md) - Quick reference

---

**Happy building!** 🚀
