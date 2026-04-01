import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../../core/widgets/copy_button.dart';
import '../../domain/generation_payload.dart';
import 'code_block_widget.dart';

enum _ResultView { business, developer }

class AssistantResultCard extends StatefulWidget {
  const AssistantResultCard({
    super.key,
    required this.result,
  });

  final GenerationPayload result;

  @override
  State<AssistantResultCard> createState() =>
      _AssistantResultCardState();
}

class _AssistantResultCardState extends State<AssistantResultCard> {
  var _view = _ResultView.business;

  @override
  Widget build(BuildContext context) {
    final result = widget.result;

    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 8),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 28,
            offset: Offset(0, 18),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Header(result: result),
          const SizedBox(height: 14),
          SegmentedButton<_ResultView>(
            showSelectedIcon: false,
            segments: const [
              ButtonSegment(
                value: _ResultView.business,
                label: Text('Business View'),
                icon: Icon(Icons.visibility_outlined),
              ),
              ButtonSegment(
                value: _ResultView.developer,
                label: Text('Developer View'),
                icon: Icon(Icons.code_outlined),
              ),
            ],
            selected: {_view},
            onSelectionChanged: (selection) {
              setState(() => _view = selection.first);
            },
          ),
          const SizedBox(height: 18),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 220),
            child: _view == _ResultView.business
                ? _BusinessView(
                    key: const ValueKey('business'),
                    result: result,
                  )
                : _DeveloperView(
                    key: const ValueKey('developer'),
                    result: result,
                  ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.result});

  final GenerationPayload result;

  @override
  Widget build(BuildContext context) {
    final chips = <Widget>[
      _StatusChip(
        label: result.preview.isRealPreview
            ? 'Real Preview'
            : result.preview.isConceptFallback
                ? 'Concept Fallback'
                : 'Preview Pending',
        color: result.preview.isRealPreview
            ? const Color(0xFFD8F0DF)
            : result.preview.isConceptFallback
                ? const Color(0xFFF7E3D3)
                : const Color(0xFFE5E2DA),
        foreground: const Color(0xFF1F1E1A),
      ),
      _StatusChip(
        label: result.validation.passed
            ? 'Validation Passed'
            : result.validation.ran
                ? 'Needs Fixing'
                : 'Validation Skipped',
        color: result.validation.passed
            ? const Color(0xFFDDEED8)
            : result.validation.ran
                ? const Color(0xFFF7D9D5)
                : const Color(0xFFE8E4DB),
        foreground: const Color(0xFF1F1E1A),
      ),
      if (result.validation.repaired)
        const _StatusChip(
          label: 'Repaired Once',
          color: Color(0xFFEEDFF8),
          foreground: Color(0xFF31213F),
        ),
      if (result.isArchitectureMode)
        const _StatusChip(
          label: '3 Files Mode',
          color: Color(0xFFE5E8F8),
          foreground: Color(0xFF222B54),
        ),
    ];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Generated Tagaddod Experience',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 6),
              Text(
                'Board-friendly summary first, implementation details second.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: chips,
              ),
            ],
          ),
        ),
        CopyButton(
          text: result.requirement,
          tooltip: 'Copy requirement',
        ),
      ],
    );
  }
}

class _BusinessView extends StatelessWidget {
  const _BusinessView({
    super.key,
    required this.result,
  });

  final GenerationPayload result;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 900;

        final previewCard = _SectionCard(
          title: result.preview.isRealPreview
              ? 'Real Mobile Preview'
              : result.preview.isConceptFallback
                  ? 'Concept Preview Fallback'
                  : 'Preview Status',
          subtitle: result.preview.message ??
              'A rendered output for non-technical stakeholders.',
          child: _PreviewPanel(preview: result.preview),
        );

        final insightColumn = Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _SectionCard(
              title: 'Requirement Summary',
              subtitle: 'The original request used for generation.',
              trailing: CopyButton(
                text: result.requirement,
                tooltip: 'Copy requirement',
              ),
              child: SelectableText(result.requirement),
            ),
            const SizedBox(height: 16),
            _SectionCard(
              title: 'Components Used From Tagaddod UI Kit',
              subtitle:
                  'The system grounded this output in your reusable library.',
              child: _MatchedComponentsList(
                components: result.matchedComponents,
              ),
            ),
            const SizedBox(height: 16),
            _SectionCard(
              title: 'Suggested Additions To The Library',
              subtitle:
                  'Recommendations that could improve future prompts.',
              child: _GapRecommendationsList(gaps: result.kitGaps),
            ),
          ],
        );

        if (!wide) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              previewCard,
              const SizedBox(height: 16),
              insightColumn,
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 6, child: previewCard),
            const SizedBox(width: 16),
            Expanded(flex: 5, child: insightColumn),
          ],
        );
      },
    );
  }
}

class _DeveloperView extends StatelessWidget {
  const _DeveloperView({
    super.key,
    required this.result,
  });

  final GenerationPayload result;

  @override
  Widget build(BuildContext context) {
    final files = result.files;
    final diagnostics = <Widget>[
      _MetricCard(
        title: 'Validation',
        child: _ValidationSummary(result: result),
      ),
      _MetricCard(
        title: 'Diagnostics',
        child: _MetricWrap(result: result),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: diagnostics
              .map(
                (card) => SizedBox(width: 320, child: card),
              )
              .toList(),
        ),
        const SizedBox(height: 18),
        if (files.isNotEmpty)
          ...files.map(
            (file) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: CodeBlockWidget(
                code: file.code,
                title: file.path,
              ),
            ),
          ),
        if (files.isEmpty && result.screenCode.isNotEmpty)
          CodeBlockWidget(
            code: result.screenCode,
            title: 'generated_preview_screen.dart',
          ),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.subtitle,
    required this.child,
    this.trailing,
  });

  final String title;
  final String subtitle;
  final Widget child;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                trailing ?? const SizedBox.shrink(),
              ],
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}

class _PreviewPanel extends StatelessWidget {
  const _PreviewPanel({required this.preview});

  final PreviewArtifact preview;

  @override
  Widget build(BuildContext context) {
    if (!preview.hasImage) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.phone_iphone_rounded, size: 36),
            const SizedBox(height: 12),
            Text(
              preview.message ??
                  'A real preview was not available for this result yet.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      );
    }

    final bytes = base64Decode(preview.imageBase64!);

    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: ColoredBox(
        color: const Color(0xFFF2EEE8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _StatusChip(
                    label: preview.isRealPreview
                        ? 'Rendered From Flutter'
                        : 'Concept Fallback',
                    color: preview.isRealPreview
                        ? const Color(0xFFD6EDDD)
                        : const Color(0xFFF7E3D3),
                    foreground: const Color(0xFF1F1E1A),
                  ),
                  if (preview.width != null && preview.height != null)
                    _StatusChip(
                      label: '${preview.width} x ${preview.height}',
                      color: const Color(0xFFE7E3DB),
                      foreground: const Color(0xFF1F1E1A),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.memory(
                  bytes,
                  fit: BoxFit.contain,
                  gaplessPlayback: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MatchedComponentsList extends StatelessWidget {
  const _MatchedComponentsList({required this.components});

  final List<MatchedComponent> components;

  @override
  Widget build(BuildContext context) {
    if (components.isEmpty) {
      return Text(
        'No concrete matches were extracted from the generated code.',
        style: Theme.of(context).textTheme.bodyMedium,
      );
    }

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: components
          .map(
            (component) => Container(
              constraints: const BoxConstraints(maxWidth: 260),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    component.className,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    component.description,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

class _GapRecommendationsList extends StatelessWidget {
  const _GapRecommendationsList({required this.gaps});

  final List<GenerationKitGap> gaps;

  @override
  Widget build(BuildContext context) {
    if (gaps.isEmpty) {
      return Text(
        'No missing kit capabilities were flagged for this prompt.',
        style: Theme.of(context).textTheme.bodyMedium,
      );
    }

    return Column(
      children: gaps
          .map(
            (gap) => Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF5EA),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFF0C89A)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          gap.suggestedComponentName ??
                              gap.widgetName,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                      if (gap.priority != null)
                        _StatusChip(
                          label: 'Priority ${gap.priority}',
                          color: const Color(0xFFF8D8A7),
                          foreground: const Color(0xFF3F2B18),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(gap.description),
                  if ((gap.reason ?? '').isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      'Why it matters: ${gap.reason}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

class _ValidationSummary extends StatelessWidget {
  const _ValidationSummary({required this.result});

  final GenerationPayload result;

  @override
  Widget build(BuildContext context) {
    final validation = result.validation;

    if (!validation.ran) {
      return Text(
        validation.errors.isEmpty
            ? 'Validation was skipped for this result.'
            : validation.errors.join('\n'),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _StatusChip(
              label: validation.passed
                  ? 'Ready To Render'
                  : 'Blocked',
              color: validation.passed
                  ? const Color(0xFFD8EEDC)
                  : const Color(0xFFF7D8D5),
              foreground: const Color(0xFF1F1E1A),
            ),
            if (validation.repaired)
              const _StatusChip(
                label: 'One Repair Attempt',
                color: Color(0xFFE6DFF8),
                foreground: Color(0xFF2E2241),
              ),
          ],
        ),
        if (validation.errors.isNotEmpty) ...[
          const SizedBox(height: 10),
          SelectableText(
            validation.errors.join('\n'),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontFamily: 'monospace',
                ),
          ),
        ],
      ],
    );
  }
}

class _MetricWrap extends StatelessWidget {
  const _MetricWrap({required this.result});

  final GenerationPayload result;

  @override
  Widget build(BuildContext context) {
    final chips = <Widget>[
      _MetricChip(
        label: 'Input tokens',
        value: '${result.tokens['input']}',
      ),
      _MetricChip(
        label: 'Output tokens',
        value: '${result.tokens['output']}',
      ),
      ...result.timings.values.entries.map(
        (entry) => _MetricChip(
          label: _formatMetricLabel(entry.key),
          value: '${entry.value} ms',
        ),
      ),
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: chips,
    );
  }

  String _formatMetricLabel(String key) {
    return key
        .replaceAll('Ms', '')
        .replaceAllMapped(
          RegExp(r'([A-Z])'),
          (match) => ' ${match.group(1)}',
        )
        .trim();
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({
    required this.label,
    required this.color,
    required this.foreground,
  });

  final String label;
  final Color color;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: foreground,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}

class _MetricChip extends StatelessWidget {
  const _MetricChip({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodySmall,
          children: [
            TextSpan(
              text: '$label: ',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}
