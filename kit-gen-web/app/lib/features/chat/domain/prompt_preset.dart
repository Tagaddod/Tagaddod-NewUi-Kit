import 'package:flutter/material.dart';

class PromptPreset {
  const PromptPreset({
    required this.label,
    required this.audience,
    required this.icon,
    required this.prompt,
  });

  final String label;
  final String audience;
  final IconData icon;
  final String prompt;

  static const List<PromptPreset> defaults = [
    PromptPreset(
      label: 'Login',
      audience: 'Product',
      icon: Icons.lock_outline_rounded,
      prompt:
          'Create a premium login screen with email, password, remember me, and a strong primary CTA.',
    ),
    PromptPreset(
      label: 'Dashboard',
      audience: 'Operations',
      icon: Icons.grid_view_rounded,
      prompt:
          'Create an operations dashboard with key metrics, progress indicators, alerts, and a quick actions section.',
    ),
    PromptPreset(
      label: 'Profile',
      audience: 'Growth',
      icon: Icons.person_outline_rounded,
      prompt:
          'Create an edit profile screen with avatar, personal information fields, and save/cancel actions.',
    ),
    PromptPreset(
      label: 'Settings',
      audience: 'Support',
      icon: Icons.tune_rounded,
      prompt:
          'Create a settings screen with grouped preferences, notification toggles, and a danger zone action.',
    ),
    PromptPreset(
      label: 'List',
      audience: 'Marketing',
      icon: Icons.view_agenda_outlined,
      prompt:
          'Create a product list page with search, category tabs, item cards, and a sticky filter action.',
    ),
    PromptPreset(
      label: 'Landing',
      audience: 'Leadership',
      icon: Icons.auto_awesome_rounded,
      prompt:
          'Create a marketing landing screen with a hero section, benefit cards, social proof, and a CTA banner.',
    ),
  ];
}
