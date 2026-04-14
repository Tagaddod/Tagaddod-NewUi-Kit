import 'package:flutter_test/flutter_test.dart';
import 'package:kit_gen_web_app/main.dart';

void main() {
  testWidgets('app loads the chat shell', (tester) async {
    await tester.pumpWidget(const KitGenWebApp());
    await tester.pumpAndSettle();

    expect(find.text('Kit-Gen'), findsAtLeastNWidgets(1));
    expect(find.text('Architecture mode'), findsAtLeastNWidgets(1));
    expect(find.text('Kit-Gen Product Workspace'), findsOneWidget);
    expect(find.text('Describe the product outcome you want'), findsOneWidget);
    expect(find.text('Generate'), findsOneWidget);
  });
}
