import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import '../models/prompt_preset.dart';

class Sidebar extends StatelessComponent {
  final bool arch;
  final void Function(bool) onArchChanged;
  final void Function(String) onUsePrompt;

  const Sidebar({
    required this.arch,
    required this.onArchChanged,
    required this.onUsePrompt,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return nav(
      [
        _buildHeader(),
        div(
          [
            div([Component.text('Generation Mode')], classes: 'sidebar-label'),
            _buildModeToggle(),
          ],
          classes: 'sidebar-section',
        ),
        div(
          [
            div([Component.text('Example Prompts')], classes: 'sidebar-label'),
            div(
              PromptPreset.defaults.map(_buildPresetTile).toList(),
              classes: 'presets-list',
            ),
          ],
          classes: 'sidebar-section',
        ),
        div(
          [Component.text('Tagaddod · Kit Gen · Internal tool')],
          classes: 'sidebar-footer',
        ),
      ],
      classes: 'sidebar',
    );
  }

  Component _buildHeader() => div(
        [
          div(
            [
              div([Component.text('T')], classes: 'brand-logo'),
              div(
                [
                  div([Component.text('Tagaddod')], classes: 'brand-name'),
                  div([Component.text('Kit Generator')], classes: 'brand-badge'),
                ],
              ),
            ],
            classes: 'brand',
          ),
        ],
        classes: 'sidebar-header',
      );

  Component _buildModeToggle() => div(
        [
          button(
            [Component.text('Screen')],
            classes: 'mode-btn${!arch ? ' active' : ''}',
            onClick: () => onArchChanged(false),
          ),
          button(
            [Component.text('Architecture')],
            classes: 'mode-btn${arch ? ' active' : ''}',
            onClick: () => onArchChanged(true),
          ),
        ],
        classes: 'mode-toggle',
      );

  Component _buildPresetTile(PromptPreset p) => button(
        [
          div([Component.text(p.icon)], classes: 'preset-icon'),
          div(
            [
              div([Component.text(p.label)], classes: 'preset-name'),
              div([Component.text(p.audience)], classes: 'preset-tag'),
            ],
            classes: 'preset-info',
          ),
        ],
        classes: 'preset-item',
        onClick: () => onUsePrompt(p.prompt),
      );
}
