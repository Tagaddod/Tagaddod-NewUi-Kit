class PromptPreset {
  final String label;
  final String audience;
  final String icon;
  final String prompt;

  const PromptPreset({
    required this.label,
    required this.audience,
    required this.icon,
    required this.prompt,
  });

  static const List<PromptPreset> defaults = [
    PromptPreset(
      label: 'Login', audience: 'Product', icon: '🔐',
      prompt: 'Create a premium login screen with email, password, remember me, and a strong primary CTA.',
    ),
    PromptPreset(
      label: 'Dashboard', audience: 'Operations', icon: '📊',
      prompt: 'Create an operations dashboard with key metrics, progress indicators, alerts, and a quick actions section.',
    ),
    PromptPreset(
      label: 'Profile', audience: 'Growth', icon: '👤',
      prompt: 'Create an edit profile screen with avatar, personal information fields, and save/cancel actions.',
    ),
    PromptPreset(
      label: 'Settings', audience: 'Support', icon: '⚙️',
      prompt: 'Create a settings screen with grouped preferences, notification toggles, and a danger zone action.',
    ),
    PromptPreset(
      label: 'List', audience: 'Marketing', icon: '📋',
      prompt: 'Create a product list page with search, category tabs, item cards, and a sticky filter action.',
    ),
    PromptPreset(
      label: 'Landing', audience: 'Leadership', icon: '✨',
      prompt: 'Create a marketing landing screen with a hero section, benefit cards, social proof, and a CTA banner.',
    ),
  ];
}
