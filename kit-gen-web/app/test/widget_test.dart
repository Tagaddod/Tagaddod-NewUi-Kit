import 'package:flutter_test/flutter_test.dart';
import 'package:kit_gen_web_app/main.dart';

void main() {
  testWidgets('app loads the chat shell', (tester) async {
    await tester.pumpWidget(const KitGenWebApp());

    expect(find.text('Kit-Gen'), findsOneWidget);
    expect(find.text('Architecture mode'), findsOneWidget);
    expect(find.text('Describe a screen. Show the board what it would look like.'), findsOneWidget);
    expect(find.text('Generate'), findsOneWidget);
  });
}
