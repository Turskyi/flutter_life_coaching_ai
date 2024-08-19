import 'package:flutter_test/flutter_test.dart';
import 'package:lifecoach/main.dart' as app;
import 'package:lifecoach/ui/app/app.dart';

void main() {
  testWidgets('Main initializes the app', (WidgetTester tester) async {
    await tester.runAsync(() async {
      app.main();
      await tester.pumpAndSettle();
      expect(find.byType(App), findsOneWidget);
    });
  });
}
