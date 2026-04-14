import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import '../models/generation_payload.dart';

class DetailsTab extends StatelessComponent {
  final GenerationPayload result;
  const DetailsTab({required this.result, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      [
        _buildValidation(),
        if (result.matchedComponents.isNotEmpty) _buildComponents(),
        if (result.kitGaps.isNotEmpty) _buildKitGaps(),
        if (!result.tokens.isEmpty) _buildMetrics(),
      ],
      classes: 'result-body',
    );
  }

  Component _buildValidation() {
    final v = result.validation;
    final cls = v.passed ? 'pass' : 'fail';
    final label = !v.ran
        ? 'Validation skipped'
        : v.passed
            ? v.repaired
                ? 'Passed after auto-repair ✓'
                : 'Validation passed ✓'
            : 'Validation failed';
    return div(
      [
        div([Component.text('Validation')], classes: 'detail-section-title'),
        div(
          [
            div([], classes: 'status-dot $cls'),
            span([Component.text(label)]),
          ],
          classes: 'status-row',
        ),
        ...v.errors.map((e) => div([Component.text(e)], classes: 'error-item')),
      ],
      classes: 'detail-section',
    );
  }

  Component _buildComponents() => div(
        [
          div(
            [Component.text('Matched (${result.matchedComponents.length})')],
            classes: 'detail-section-title',
          ),
          ...result.matchedComponents.map((c) => div(
                [
                  div([], classes: 'component-dot'),
                  div(
                    [
                      div([Component.text(c.className)], classes: 'component-name'),
                      div([Component.text(c.importPath)], classes: 'component-path'),
                    ],
                  ),
                ],
                classes: 'component-row',
              )),
        ],
        classes: 'detail-section',
      );

  Component _buildKitGaps() => div(
        [
          div(
            [Component.text('Kit Gaps (${result.kitGaps.length})')],
            classes: 'detail-section-title',
          ),
          ...result.kitGaps.map((g) => div(
                [
                  div([Component.text(g.widgetName)], classes: 'gap-name'),
                  div([Component.text(g.description)], classes: 'gap-desc'),
                ],
                classes: 'gap-item',
              )),
        ],
        classes: 'detail-section',
      );

  Component _buildMetrics() {
    final t = result.tokens;
    return div(
      [
        div([Component.text('Usage')], classes: 'detail-section-title'),
        div(
          [
            _metric('${t['input']}', 'Input tokens'),
            _metric('${t['output']}', 'Output tokens'),
          ],
          classes: 'metric-grid',
        ),
      ],
      classes: 'detail-section',
    );
  }

  Component _metric(String val, String key) => div(
        [
          div([Component.text(val)], classes: 'metric-val'),
          div([Component.text(key)], classes: 'metric-key'),
        ],
        classes: 'metric-card',
      );
}
