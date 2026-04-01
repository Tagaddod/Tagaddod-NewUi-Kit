import '../models/kit_manifest.dart';
import '../models/widget_info.dart';

class RetrievedComponents {
  final List<WidgetInfo> detailedWidgets;
  final List<String> allWidgetNames;
  final bool usedFullManifest;

  const RetrievedComponents({
    required this.detailedWidgets,
    required this.allWidgetNames,
    required this.usedFullManifest,
  });
}

class ComponentRetrievalService {
  static const _coreWidgetNames = {
    'AppText',
    'AppIcon',
    'AppDivider',
  };

  static const _keywordBoosts = {
    'login': [
      'AppTextField',
      'AppFilledButton',
      'AppTextButton',
      'AppCheckBox',
    ],
    'sign in': [
      'AppTextField',
      'AppFilledButton',
      'AppTextButton',
    ],
    'register': [
      'AppTextField',
      'AppFilledButton',
      'AppCheckBox',
    ],
    'profile': [
      'TopAppBar',
      'AppTextField',
      'AppFilledButton',
      'AppIcon',
    ],
    'settings': [
      'TopAppBar',
      'AppSwitch',
      'AppOutlinedButton',
      'AppDivider',
    ],
    'dashboard': [
      'TopAppBar',
      'AppBadge',
      'BarPercentIndicator',
      'CirclePercentIndicator',
    ],
    'list': [
      'AppText',
      'ScrollableTabBar',
      'AppDivider',
      'AppBadge',
    ],
    'search': [
      'AppTextField',
      'AppIcon',
      'ScrollableTabBar',
    ],
    'filter': [
      'ScrollableTabBar',
      'AppCheckBox',
      'AppRadioButton',
    ],
    'modal': [
      'AppModalDialog',
      'AppBottomSheet',
    ],
    'dialog': [
      'AppModalDialog',
    ],
    'bottom sheet': [
      'AppBottomSheet',
    ],
    'toast': [
      'SuccessMessage',
      'ErrorMessage',
    ],
    'loading': [
      'AppLoadingView',
    ],
    'progress': [
      'BarPercentIndicator',
      'CirclePercentIndicator',
      'MultiSegmentCircularProgress',
      'MultiSegmentLinearProgress',
    ],
    'step': [
      'AppStepper',
      'StepperFlow',
    ],
    'tab': [
      'ScrollableTabBar',
      'TopAppBar',
    ],
    'navigation': [
      'TopAppBar',
      'AppBottomNavigationBar',
    ],
  };

  static const _stopWords = {
    'a',
    'an',
    'and',
    'app',
    'build',
    'create',
    'for',
    'from',
    'in',
    'into',
    'of',
    'on',
    'or',
    'screen',
    'show',
    'that',
    'the',
    'to',
    'with',
  };

  RetrievedComponents select({
    required String requirement,
    required KitManifest manifest,
    int limit = 14,
  }) {
    final allWidgetNames =
        manifest.widgets.map((w) => w.className).toList();
    final requirementLower = requirement.toLowerCase();
    final queryTokens = _tokensFor(requirementLower);

    final scored = manifest.widgets
        .map((widget) => _ScoredWidget(
              widget: widget,
              score: _scoreWidget(
                widget: widget,
                requirementLower: requirementLower,
                queryTokens: queryTokens,
              ),
            ))
        .toList()
      ..sort((a, b) {
        final byScore = b.score.compareTo(a.score);
        if (byScore != 0) return byScore;
        return a.widget.className.compareTo(b.widget.className);
      });

    final positive = scored.where((item) => item.score > 0).toList();
    if (positive.isEmpty || positive.length < 6) {
      return RetrievedComponents(
        detailedWidgets: manifest.widgets,
        allWidgetNames: allWidgetNames,
        usedFullManifest: true,
      );
    }

    final selected = <WidgetInfo>[];
    for (final item in positive.take(limit)) {
      selected.add(item.widget);
    }

    for (final coreName in _coreWidgetNames) {
      final coreWidget = manifest.widgets.where(
        (widget) => widget.className == coreName,
      );
      if (coreWidget.isEmpty) continue;
      if (selected.any((widget) => widget.className == coreName)) {
        continue;
      }
      selected.add(coreWidget.first);
    }

    selected.sort(
      (a, b) => a.className.compareTo(b.className),
    );

    return RetrievedComponents(
      detailedWidgets: selected,
      allWidgetNames: allWidgetNames,
      usedFullManifest: false,
    );
  }

  int _scoreWidget({
    required WidgetInfo widget,
    required String requirementLower,
    required Set<String> queryTokens,
  }) {
    var score = 0;
    final classNameLower = widget.className.toLowerCase();
    final classTokens = _tokensFor(
      _splitCamelCase(widget.className).toLowerCase(),
    );
    final descriptionLower = widget.description.toLowerCase();
    final parametersLower = widget.parameters.toLowerCase();
    final exampleLower = widget.example.toLowerCase();
    final importPathLower = widget.importPath.toLowerCase();

    if (requirementLower.contains(classNameLower)) {
      score += 24;
    }

    for (final entry in _keywordBoosts.entries) {
      if (!requirementLower.contains(entry.key)) continue;
      if (entry.value.contains(widget.className)) {
        score += 14;
      }
    }

    for (final token in queryTokens) {
      if (classTokens.contains(token) ||
          classNameLower.contains(token)) {
        score += 8;
      }
      if (descriptionLower.contains(token)) score += 4;
      if (parametersLower.contains(token)) score += 2;
      if (exampleLower.contains(token)) score += 3;
      if (importPathLower.contains(token)) score += 1;

      final singular = token.endsWith('s') && token.length > 3
          ? token.substring(0, token.length - 1)
          : null;
      if (singular != null &&
          (classTokens.contains(singular) ||
              classNameLower.contains(singular))) {
        score += 4;
      }
    }

    return score;
  }

  Set<String> _tokensFor(String text) {
    final matches =
        RegExp(r'[a-zA-Z][a-zA-Z0-9_+-]*').allMatches(text);
    return matches
        .map((match) => match.group(0)!.toLowerCase())
        .where(
          (token) => token.length > 2 && !_stopWords.contains(token),
        )
        .toSet();
  }

  String _splitCamelCase(String value) {
    return value.replaceAllMapped(
      RegExp(r'(?<!^)([A-Z])'),
      (match) => ' ${match.group(1)}',
    );
  }
}

class _ScoredWidget {
  final WidgetInfo widget;
  final int score;

  const _ScoredWidget({
    required this.widget,
    required this.score,
  });
}
