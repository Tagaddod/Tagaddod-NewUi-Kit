import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import '../models/prompt_preset.dart';

class WorkspaceLanding extends StatelessComponent {
  final void Function(String) onUsePrompt;
  const WorkspaceLanding({required this.onUsePrompt, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      [
        div(
          [
            h1(
              [Component.text('Describe a screen.')],
              classes: 'landing-headline',
            ),
            p(
              [
                Component.text('Powered by '),
                strong([Component.text('Tagaddod UI Kit')]),
                Component.text(' — generates real Flutter code with live preview.'),
              ],
              classes: 'landing-sub',
            ),
          ],
          classes: 'landing-hero',
        ),
        div(
          PromptPreset.defaults.map(_buildCard).toList(),
          classes: 'presets-grid',
        ),
      ],
      classes: 'landing',
    );
  }

  Component _buildCard(PromptPreset preset) => div(
        [
          div([Component.text(preset.icon)], classes: 'preset-card-icon'),
          div([Component.text(preset.label)], classes: 'preset-card-label'),
          div([Component.text(preset.audience)], classes: 'preset-card-tag'),
          div([Component.text(preset.prompt)], classes: 'preset-card-prompt'),
        ],
        classes: 'preset-card',
        events: events(onClick: () => onUsePrompt(preset.prompt)),
      );
}
