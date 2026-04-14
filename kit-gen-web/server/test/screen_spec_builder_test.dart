import 'package:kit_gen_web_server/models/kit_gap.dart';
import 'package:kit_gen_web_server/models/screen_spec.dart';
import 'package:kit_gen_web_server/services/screen_spec_builder.dart';
import 'package:test/test.dart';

void main() {
  group('ScreenSpecBuilder', () {
    test('creates a renderable auth spec from a login requirement', () {
      final builder = ScreenSpecBuilder();

      final spec = builder.build(
        requirement:
            'Create a login screen with email, password, remember me, and forgot password.',
        kitGaps: const [],
        arch: false,
      );

      expect(spec.screenType, 'auth');
      expect(spec.isRenderable, isTrue);
      expect(spec.useLogo, isTrue);
      expect(spec.sections.any((section) => section.kind == 'form'), isTrue);
      expect(
        spec.sections
            .expand((section) => section.items)
            .any(
              (item) =>
                  item.kind == 'text_field' && item.label == 'Email address',
            ),
        isTrue,
      );
    });

    test('normalizes a generated spec with missing titles', () {
      final builder = ScreenSpecBuilder();

      final spec = builder.build(
        requirement: 'Create a dashboard screen',
        kitGaps: [
          KitGap(
            widgetName: 'AppTrendChart',
            description: 'Reusable trend chart',
            reason: 'Helpful for dashboard metrics',
            suggestedComponentName: 'AppTrendChart',
            priority: 2,
          ),
        ],
        generatedSpec: ScreenSpec(
          screenType: 'dashboard',
          title: '',
          subtitle: '',
          topBarTitle: null,
          useLogo: false,
          sections: [
            ScreenSpecSection(
              kind: 'metrics',
              title: '',
              subtitle: '',
              items: [
                ScreenSpecItem(kind: 'metric', label: 'Revenue', value: '1.2M'),
              ],
            ),
          ],
        ),
        arch: false,
      );

      expect(spec.title, isNotEmpty);
      expect(spec.subtitle, isNotEmpty);
      expect(spec.topBarTitle, isNotEmpty);
      expect(spec.sections.single.items.single.label, 'Revenue');
    });
  });
}
