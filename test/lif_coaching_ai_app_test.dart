import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifecoach/life_coaching_ai_app.dart';
import 'package:lifecoach/ui/home/home_page.dart';

void main() {
  testWidgets('App initializes with correct title and theme', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const LifeCoachingAiApp());
    // Wait for the AnimatedTextKit widget to appear
    await tester.pumpAndSettle();

    // Verify the AnimatedTextKit widget is present
    expect(find.byType(AnimatedTextKit), findsOneWidget);

    // Verify the theme is dark
    final MaterialApp app = tester.widget(find.byType(MaterialApp));
    expect(app.theme?.brightness, Brightness.dark);
  });

  testWidgets('App navigates to home route', (WidgetTester tester) async {
    await tester.pumpWidget(const LifeCoachingAiApp());

    // Verify the initial route is the home route
    expect(find.byType(HomePage), findsOneWidget);
  });
}
