import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import '../models/generation_payload.dart';
import 'code_block.dart';
import 'details_tab.dart';

enum _Tab { details, code }

class ResultPanel extends StatefulComponent {
  final GenerationPayload result;
  const ResultPanel({required this.result, super.key});

  @override
  State<ResultPanel> createState() => _ResultPanelState();
}

class _ResultPanelState extends State<ResultPanel> {
  _Tab _tab = _Tab.details;

  @override
  Component build(BuildContext context) {
    final r = component.result;
    return div(
      [
        div(
          [
            div(
              [Component.text(
                r.requirement.length > 50
                    ? '${r.requirement.substring(0, 50)}…'
                    : r.requirement,
              )],
              classes: 'result-title',
            ),
            div(
              [
                _tabBtn(_Tab.details, 'Details'),
                if (r.hasCode) _tabBtn(_Tab.code, 'Code'),
              ],
              classes: 'tab-bar',
            ),
          ],
          classes: 'result-header',
        ),
        _buildBody(r),
      ],
      classes: 'result-panel',
    );
  }

  Component _tabBtn(_Tab tab, String label) => button(
        [Component.text(label)],
        classes: 'tab-btn${_tab == tab ? ' active' : ''}',
        onClick: () => setState(() => _tab = tab),
      );

  Component _buildBody(GenerationPayload r) {
    if (_tab == _Tab.code && r.hasCode) {
      if (r.files.isNotEmpty) {
        return div(
          r.files
              .map((f) => CodeBlock(filename: f.path, code: f.code))
              .toList(),
          classes: 'result-body',
        );
      }
      return div(
        [CodeBlock(filename: r.primaryTitle, code: r.primaryCode)],
        classes: 'result-body',
      );
    }
    return DetailsTab(result: r);
  }
}
