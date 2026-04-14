import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

class ProgressCard extends StatelessComponent {
  final String stage;
  final int elapsed;
  final String prompt;

  const ProgressCard({
    required this.stage,
    required this.elapsed,
    required this.prompt,
    super.key,
  });

  static const _stages = [
    'Understanding the requirement',
    'Matching Tagaddod components',
    'Generating Flutter code',
    'Validating and repairing',
    'Rendering live preview',
  ];

  @override
  Component build(BuildContext context) {
    final stageIdx = _stages.indexOf(stage).clamp(0, _stages.length - 1);
    final pct = ((stageIdx + 1) / _stages.length * 100).toDouble();
    final shortPrompt =
        prompt.length > 80 ? '${prompt.substring(0, 80)}…' : prompt;

    return div(
      [
        div([], classes: 'progress-spinner'),
        div(
          [Component.text('"$shortPrompt"')],
          classes: 'progress-prompt',
        ),
        div(
          [
            div(
              [],
              classes: 'progress-bar-fill',
              styles: Styles(width: Unit.percent(pct)),
            ),
          ],
          classes: 'progress-bar-wrap',
        ),
        div([Component.text(stage)], classes: 'progress-stage'),
        div([Component.text('${elapsed}s elapsed')], classes: 'progress-elapsed'),
      ],
      classes: 'progress-card',
    );
  }
}
