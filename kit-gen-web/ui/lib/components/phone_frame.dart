import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

class PhoneFrame extends StatelessComponent {
  final String? previewUrl;
  const PhoneFrame({this.previewUrl, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      [div([_buildScreen()], classes: 'phone-device')],
      classes: 'phone-wrap',
    );
  }

  Component _buildScreen() {
    final url = previewUrl;
    if (url != null && url.isNotEmpty) {
      return div(
        [
          iframe(
            [],
            src: url,
            allow: 'same-origin',
          ),
        ],
        classes: 'phone-screen',
      );
    }
    return div(
      [
        div([Component.text('📱')], classes: 'phone-placeholder-icon'),
        div(
          [Component.text('Preview will appear here')],
          classes: 'phone-placeholder-text',
        ),
      ],
      classes: 'phone-screen phone-placeholder',
    );
  }
}
