import '../models/kit_gap.dart';
import '../models/screen_spec.dart';

class ScreenSpecBuilder {
  ScreenSpec build({
    required String requirement,
    required List<KitGap> kitGaps,
    ScreenSpec? generatedSpec,
    required bool arch,
  }) {
    final type = _detectType(requirement);
    final normalized = generatedSpec == null
        ? null
        : _normalize(spec: generatedSpec, type: type, requirement: requirement);

    if (normalized != null && normalized.isRenderable) {
      return normalized;
    }

    return switch (type) {
      'auth' => _buildAuth(requirement),
      'profile' => _buildProfile(requirement),
      'settings' => _buildSettings(requirement),
      'dashboard' => _buildDashboard(requirement),
      'list' => _buildList(requirement),
      'marketing' => _buildMarketing(requirement),
      _ => _buildGeneric(requirement, arch: arch, kitGaps: kitGaps),
    };
  }

  ScreenSpec _normalize({
    required ScreenSpec spec,
    required String type,
    required String requirement,
  }) {
    final title = spec.title.trim().isNotEmpty
        ? spec.title.trim()
        : _defaultTitle(type, requirement);
    final subtitle = spec.subtitle.trim().isNotEmpty
        ? spec.subtitle.trim()
        : _defaultSubtitle(type, requirement);
    final sections = spec.sections
        .map(_normalizeSection)
        .where(
          (section) =>
              section.title.trim().isNotEmpty ||
              section.subtitle.trim().isNotEmpty ||
              section.items.isNotEmpty,
        )
        .toList();

    return ScreenSpec(
      screenType: spec.screenType.trim().isNotEmpty ? spec.screenType : type,
      title: title,
      subtitle: subtitle,
      topBarTitle: (spec.topBarTitle ?? '').trim().isNotEmpty
          ? spec.topBarTitle!.trim()
          : title,
      useLogo: spec.useLogo || _shouldUseLogo(type, requirement),
      sections: sections,
    );
  }

  ScreenSpecSection _normalizeSection(ScreenSpecSection section) {
    final items = section.items
        .map(
          (item) => ScreenSpecItem(
            kind: item.kind.trim().isNotEmpty
                ? item.kind.trim()
                : 'placeholder',
            label: item.label.trim(),
            value: item.value?.trim(),
            hint: item.hint?.trim(),
            componentName: item.componentName?.trim().isEmpty ?? true
                ? _defaultComponentName(item.kind)
                : item.componentName?.trim(),
            emphasis: item.emphasis?.trim().isEmpty ?? true
                ? _defaultEmphasis(item.kind)
                : item.emphasis?.trim(),
            resolution: item.resolution?.trim().isEmpty ?? true
                ? 'explicit'
                : item.resolution?.trim(),
            checked: item.checked,
            obscured: item.obscured,
          ),
        )
        .where(
          (item) =>
              item.label.isNotEmpty ||
              (item.value ?? '').isNotEmpty ||
              item.kind == 'divider',
        )
        .toList();

    return ScreenSpecSection(
      kind: section.kind.trim().isNotEmpty ? section.kind.trim() : 'content',
      title: section.title.trim(),
      subtitle: section.subtitle.trim(),
      items: items,
    );
  }

  ScreenSpec _buildAuth(String requirement) {
    final isRegister = _containsAny(requirement, const [
      'register',
      'sign up',
      'signup',
      'create account',
    ]);
    final wantsPhone = _containsAny(requirement, const [
      'phone',
      'mobile',
      'otp',
    ]);
    final wantsName = _containsAny(requirement, const ['name', 'full name']);
    final wantsRemember = _containsAny(requirement, const ['remember']);
    final wantsForgot = _containsAny(requirement, const ['forgot']);
    final wantsSocial = _containsAny(requirement, const [
      'social',
      'google',
      'apple',
      'facebook',
    ]);

    final fields = <ScreenSpecItem>[
      if (wantsName) _field('Full name', hint: 'Enter your full name'),
      _field(
        wantsPhone ? 'Phone number' : 'Email address',
        hint: wantsPhone ? '+20 10 0000 0000' : 'name@tagaddod.com',
      ),
      _field(
        isRegister ? 'Create password' : 'Password',
        hint: isRegister ? 'Set a secure password' : 'Enter your password',
        obscured: true,
      ),
      if (isRegister && _containsAny(requirement, const ['confirm', 'repeat']))
        _field(
          'Confirm password',
          hint: 'Re-enter your password',
          obscured: true,
        ),
    ];

    final actions = <ScreenSpecItem>[
      _button(isRegister ? 'Create account' : 'Sign in'),
      if (wantsForgot) _link('Forgot password?'),
      if (wantsRemember) _toggle('Remember me', checked: true),
    ];

    final socialActions = wantsSocial
        ? [
            _button('Continue with Google', emphasis: 'secondary'),
            _button('Continue with Apple', emphasis: 'secondary'),
          ]
        : const <ScreenSpecItem>[];

    return ScreenSpec(
      screenType: 'auth',
      title: isRegister ? 'Create your account' : 'Welcome back',
      subtitle: isRegister
          ? 'Start with a trusted Tagaddod-ready authentication flow.'
          : 'Sign in to continue with your Tagaddod workspace.',
      topBarTitle: isRegister ? 'Register' : 'Login',
      useLogo: true,
      sections: [
        ScreenSpecSection(
          kind: 'form',
          title: 'Credentials',
          subtitle: 'Capture the inputs required to complete the flow.',
          items: fields,
        ),
        ScreenSpecSection(
          kind: 'actions',
          title: 'Primary actions',
          subtitle: 'Support the main conversion path clearly.',
          items: actions,
        ),
        if (socialActions.isNotEmpty)
          ScreenSpecSection(
            kind: 'actions',
            title: 'Alternative sign in',
            subtitle: 'Offer a faster path for returning users.',
            items: socialActions,
          ),
      ],
    );
  }

  ScreenSpec _buildProfile(String requirement) {
    final wantsPhone = _containsAny(requirement, const ['phone', 'mobile']);
    final wantsCompany = _containsAny(requirement, const [
      'company',
      'organization',
    ]);

    return ScreenSpec(
      screenType: 'profile',
      title: 'Profile details',
      subtitle: 'Make account edits feel clear, fast, and trusted.',
      topBarTitle: 'Edit profile',
      useLogo: false,
      sections: [
        ScreenSpecSection(
          kind: 'profile',
          title: 'Identity',
          subtitle: 'Highlight the primary user context first.',
          items: const [
            ScreenSpecItem(
              kind: 'avatar',
              label: 'Profile photo',
              resolution: 'placeholder',
            ),
          ],
        ),
        ScreenSpecSection(
          kind: 'form',
          title: 'Personal information',
          subtitle: 'Structure the editable fields in a calm vertical flow.',
          items: [
            _field('Full name', hint: 'Enter full name'),
            _field('Email address', hint: 'name@tagaddod.com'),
            if (wantsPhone) _field('Phone number', hint: '+20 10 0000 0000'),
            if (wantsCompany) _field('Company', hint: 'Tagaddod'),
          ],
        ),
        ScreenSpecSection(
          kind: 'actions',
          title: 'Save flow',
          subtitle: 'Keep the decision clear and low-friction.',
          items: const [
            ScreenSpecItem(
              kind: 'button',
              label: 'Save changes',
              componentName: 'AppFilledButton.large',
              emphasis: 'primary',
              resolution: 'explicit',
            ),
            ScreenSpecItem(
              kind: 'button',
              label: 'Cancel',
              componentName: 'AppFilledButton.large',
              emphasis: 'secondary',
              resolution: 'explicit',
            ),
          ],
        ),
      ],
    );
  }

  ScreenSpec _buildSettings(String requirement) {
    final mentionsSecurity = _containsAny(requirement, const [
      'security',
      'privacy',
      'biometric',
      'password',
    ]);

    return ScreenSpec(
      screenType: 'settings',
      title: 'Settings',
      subtitle: 'Group preferences so teams can scan and act quickly.',
      topBarTitle: 'Settings',
      useLogo: false,
      sections: [
        ScreenSpecSection(
          kind: 'toggles',
          title: 'Preferences',
          subtitle: 'Use clear groups for recurring operational controls.',
          items: [
            _toggle('Push notifications', checked: true),
            _toggle('Email summaries', checked: true),
            _toggle('Weekly digest', checked: false),
            if (mentionsSecurity) _toggle('Biometric sign in', checked: true),
          ],
        ),
        ScreenSpecSection(
          kind: 'actions',
          title: 'Actions',
          subtitle: 'Keep saving and destructive actions visually separated.',
          items: const [
            ScreenSpecItem(
              kind: 'button',
              label: 'Save preferences',
              componentName: 'AppFilledButton.large',
              emphasis: 'primary',
              resolution: 'explicit',
            ),
            ScreenSpecItem(
              kind: 'button',
              label: 'Delete account',
              componentName: 'AppFilledButton.large',
              emphasis: 'critical',
              resolution: 'placeholder',
            ),
          ],
        ),
      ],
    );
  }

  ScreenSpec _buildDashboard(String requirement) {
    return ScreenSpec(
      screenType: 'dashboard',
      title: 'Operations dashboard',
      subtitle: 'Present the highest-signal metrics and next actions first.',
      topBarTitle: 'Dashboard',
      useLogo: false,
      sections: [
        ScreenSpecSection(
          kind: 'metrics',
          title: 'Key metrics',
          subtitle: 'Use compact cards to surface daily health at a glance.',
          items: const [
            ScreenSpecItem(
              kind: 'metric',
              label: 'Orders today',
              value: '248',
              emphasis: 'primary',
              resolution: 'placeholder',
            ),
            ScreenSpecItem(
              kind: 'metric',
              label: 'Conversion',
              value: '63%',
              emphasis: 'positive',
              resolution: 'placeholder',
            ),
            ScreenSpecItem(
              kind: 'metric',
              label: 'Open alerts',
              value: '5',
              emphasis: 'critical',
              resolution: 'placeholder',
            ),
          ],
        ),
        ScreenSpecSection(
          kind: 'list',
          title: 'Live feed',
          subtitle: 'Show the latest events with a compact supporting detail.',
          items: const [
            ScreenSpecItem(
              kind: 'list_item',
              label: 'Shipment reconciliation completed',
              value: 'Updated 4 minutes ago',
              resolution: 'placeholder',
            ),
            ScreenSpecItem(
              kind: 'list_item',
              label: 'Payment issue flagged',
              value: 'Needs finance review',
              resolution: 'placeholder',
            ),
            ScreenSpecItem(
              kind: 'list_item',
              label: 'Stock threshold reached',
              value: '2 suppliers impacted',
              resolution: 'placeholder',
            ),
          ],
        ),
        ScreenSpecSection(
          kind: 'actions',
          title: 'Quick actions',
          subtitle: 'Offer a small set of high-frequency next steps.',
          items: const [
            ScreenSpecItem(
              kind: 'button',
              label: 'Create task',
              componentName: 'AppFilledButton.large',
              emphasis: 'primary',
              resolution: 'explicit',
            ),
            ScreenSpecItem(
              kind: 'button',
              label: 'View full report',
              componentName: 'AppFilledButton.large',
              emphasis: 'secondary',
              resolution: 'explicit',
            ),
          ],
        ),
      ],
    );
  }

  ScreenSpec _buildList(String requirement) {
    return ScreenSpec(
      screenType: 'list',
      title: 'Browse collection',
      subtitle: 'Keep search, filtering, and item scanning in one flow.',
      topBarTitle: 'Catalog',
      useLogo: false,
      sections: [
        ScreenSpecSection(
          kind: 'form',
          title: 'Search',
          subtitle: 'Lead with a searchable input tied to the main content.',
          items: const [
            ScreenSpecItem(
              kind: 'text_field',
              label: 'Search',
              hint: 'Search items, categories, or suppliers',
              componentName: 'AppTextField.large',
              emphasis: 'primary',
              resolution: 'explicit',
            ),
          ],
        ),
        ScreenSpecSection(
          kind: 'chips',
          title: 'Filters',
          subtitle: 'Show the active categories or segments as quick chips.',
          items: const [
            ScreenSpecItem(kind: 'chip', label: 'All'),
            ScreenSpecItem(kind: 'chip', label: 'Featured'),
            ScreenSpecItem(kind: 'chip', label: 'Available'),
          ],
        ),
        ScreenSpecSection(
          kind: 'list',
          title: 'Results',
          subtitle:
              'Use compact cards so non-technical teams can read the flow.',
          items: const [
            ScreenSpecItem(
              kind: 'list_item',
              label: 'Premium biodiesel blend',
              value: 'In stock · Cairo warehouse',
              resolution: 'placeholder',
            ),
            ScreenSpecItem(
              kind: 'list_item',
              label: 'Industrial lubricant pack',
              value: 'Low stock · Alexandria',
              resolution: 'placeholder',
            ),
            ScreenSpecItem(
              kind: 'list_item',
              label: 'Fleet servicing bundle',
              value: 'Ready to schedule',
              resolution: 'placeholder',
            ),
          ],
        ),
        ScreenSpecSection(
          kind: 'actions',
          title: 'Sticky action',
          subtitle: 'Keep the main action visible when the list grows.',
          items: const [
            ScreenSpecItem(
              kind: 'button',
              label: 'Apply filters',
              componentName: 'AppFilledButton.large',
              emphasis: 'primary',
              resolution: 'explicit',
            ),
          ],
        ),
      ],
    );
  }

  ScreenSpec _buildMarketing(String requirement) {
    return ScreenSpec(
      screenType: 'marketing',
      title: 'Make the value obvious immediately',
      subtitle:
          'Lead with a strong promise, proof, and a clean conversion path.',
      topBarTitle: 'Experience',
      useLogo: true,
      sections: [
        ScreenSpecSection(
          kind: 'highlight',
          title: 'Hero message',
          subtitle: 'This is the dominant story the page should tell.',
          items: const [
            ScreenSpecItem(
              kind: 'placeholder',
              label: 'Hero visual',
              value: 'Campaign illustration or product image',
              resolution: 'placeholder',
            ),
          ],
        ),
        ScreenSpecSection(
          kind: 'metrics',
          title: 'Proof',
          subtitle: 'Use a few concrete signals to strengthen trust.',
          items: const [
            ScreenSpecItem(
              kind: 'metric',
              label: 'Partner brands',
              value: '120+',
              resolution: 'placeholder',
            ),
            ScreenSpecItem(
              kind: 'metric',
              label: 'Fulfillment speed',
              value: '24 hrs',
              resolution: 'placeholder',
            ),
          ],
        ),
        ScreenSpecSection(
          kind: 'actions',
          title: 'Call to action',
          subtitle: 'Make the primary next step unmistakable.',
          items: const [
            ScreenSpecItem(
              kind: 'button',
              label: 'Get started',
              componentName: 'AppFilledButton.large',
              emphasis: 'primary',
              resolution: 'explicit',
            ),
            ScreenSpecItem(
              kind: 'button',
              label: 'Talk to sales',
              componentName: 'AppFilledButton.large',
              emphasis: 'secondary',
              resolution: 'explicit',
            ),
          ],
        ),
      ],
    );
  }

  ScreenSpec _buildGeneric(
    String requirement, {
    required bool arch,
    required List<KitGap> kitGaps,
  }) {
    final items = <ScreenSpecItem>[
      const ScreenSpecItem(
        kind: 'placeholder',
        label: 'Primary content area',
        value: 'Interpretation of the written requirement',
        resolution: 'placeholder',
      ),
      if (kitGaps.isNotEmpty)
        ScreenSpecItem(
          kind: 'placeholder',
          label:
              kitGaps.first.suggestedComponentName ?? kitGaps.first.widgetName,
          value: 'Suggested as a future reusable Tagaddod component',
          resolution: 'placeholder',
        ),
    ];

    return ScreenSpec(
      screenType: 'generic',
      title: _defaultTitle('generic', requirement),
      subtitle: arch
          ? 'Architecture mode is still using a visual requirement summary for preview.'
          : _defaultSubtitle('generic', requirement),
      topBarTitle: 'Generated screen',
      useLogo: _shouldUseLogo('generic', requirement),
      sections: [
        ScreenSpecSection(
          kind: 'content',
          title: 'Requirement interpretation',
          subtitle: 'Preview the intended outcome before reviewing code.',
          items: items,
        ),
        ScreenSpecSection(
          kind: 'actions',
          title: 'Next step',
          subtitle:
              'Keep the primary action clear even when the request is broad.',
          items: const [
            ScreenSpecItem(
              kind: 'button',
              label: 'Continue',
              componentName: 'AppFilledButton.large',
              emphasis: 'primary',
              resolution: 'explicit',
            ),
          ],
        ),
      ],
    );
  }

  ScreenSpecItem _field(String label, {String? hint, bool obscured = false}) {
    return ScreenSpecItem(
      kind: 'text_field',
      label: label,
      hint: hint,
      componentName: 'AppTextField.large',
      emphasis: 'primary',
      resolution: 'explicit',
      obscured: obscured,
    );
  }

  ScreenSpecItem _button(String label, {String emphasis = 'primary'}) {
    return ScreenSpecItem(
      kind: 'button',
      label: label,
      componentName: 'AppFilledButton.large',
      emphasis: emphasis,
      resolution: 'explicit',
    );
  }

  ScreenSpecItem _link(String label) {
    return ScreenSpecItem(
      kind: 'link',
      label: label,
      emphasis: 'secondary',
      resolution: 'explicit',
    );
  }

  ScreenSpecItem _toggle(String label, {required bool checked}) {
    return ScreenSpecItem(
      kind: 'toggle',
      label: label,
      emphasis: checked ? 'positive' : 'neutral',
      resolution: 'explicit',
      checked: checked,
    );
  }

  String _detectType(String requirement) {
    if (_containsAny(requirement, const [
      'login',
      'sign in',
      'password',
      'register',
      'sign up',
      'signup',
      'otp',
      'authentication',
    ])) {
      return 'auth';
    }
    if (_containsAny(requirement, const [
      'profile',
      'account',
      'edit profile',
      'personal information',
      'user details',
    ])) {
      return 'profile';
    }
    if (_containsAny(requirement, const [
      'setting',
      'preference',
      'notification',
      'privacy',
      'permission',
      'toggle',
    ])) {
      return 'settings';
    }
    if (_containsAny(requirement, const [
      'dashboard',
      'kpi',
      'metric',
      'analytics',
      'overview',
      'report',
    ])) {
      return 'dashboard';
    }
    if (_containsAny(requirement, const [
      'list',
      'catalog',
      'search',
      'filter',
      'table',
      'feed',
      'collection',
    ])) {
      return 'list';
    }
    if (_containsAny(requirement, const [
      'landing',
      'marketing',
      'campaign',
      'hero',
      'website',
      'pricing',
      'promo',
    ])) {
      return 'marketing';
    }
    return 'generic';
  }

  String _defaultTitle(String type, String requirement) {
    return switch (type) {
      'auth' =>
        _containsAny(requirement, const ['register', 'sign up', 'signup'])
            ? 'Create your account'
            : 'Welcome back',
      'profile' => 'Profile details',
      'settings' => 'Settings',
      'dashboard' => 'Operations dashboard',
      'list' => 'Browse collection',
      'marketing' => 'Make the value obvious immediately',
      _ => 'Generated product screen',
    };
  }

  String _defaultSubtitle(String type, String requirement) {
    return switch (type) {
      'auth' => 'Translate the requirement into a focused authentication flow.',
      'profile' =>
        'Translate the requirement into a polished editable profile.',
      'settings' =>
        'Translate the requirement into grouped operational preferences.',
      'dashboard' =>
        'Translate the requirement into a metrics-first operational surface.',
      'list' =>
        'Translate the requirement into a searchable browsable experience.',
      'marketing' => 'Translate the requirement into a story-led branded page.',
      _ => 'Translate the requirement into a Tagaddod-aligned screen preview.',
    };
  }

  String? _defaultComponentName(String kind) {
    return switch (kind) {
      'text_field' => 'AppTextField.large',
      'button' => 'AppFilledButton.large',
      'link' => 'AppText.bodySmSemiBold',
      'logo' => 'AppLogo',
      _ => null,
    };
  }

  String? _defaultEmphasis(String kind) {
    return switch (kind) {
      'button' => 'primary',
      'metric' => 'primary',
      'toggle' => 'neutral',
      _ => null,
    };
  }

  bool _shouldUseLogo(String type, String requirement) {
    if (type == 'auth' || type == 'marketing') return true;
    return _containsAny(requirement, const ['logo', 'brand']);
  }

  bool _containsAny(String text, List<String> values) {
    final normalized = text.toLowerCase();
    return values.any(normalized.contains);
  }
}
