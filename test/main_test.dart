import 'package:flutter_test/flutter_test.dart';
import 'package:lifecoach/di/injector.dart';
import 'package:lifecoach/life_coaching_ai_app.dart';

void main() {
  setUp(() {
    // Ensure dependencies are injected before each test
    injectDependencies();
  });

  testWidgets('App initializes without errors', (WidgetTester tester) async {
    await tester.pumpWidget(const LifeCoachingAiApp());

    // Verify the app initializes correctly
    expect(find.byType(LifeCoachingAiApp), findsOneWidget);
  });
}
