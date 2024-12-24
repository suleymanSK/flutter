// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:todo_app/main.dart';

void main() {
  testWidgets('BottomNavigationBar navigation test',
      (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(MyApp());

    // Verify initial screen is ExpensesScreen
    expect(find.text('Market'), findsOneWidget);
    expect(find.text('Alışveriş yap'), findsNothing);
    expect(find.text('Kullanıcı Adı: John Doe'), findsNothing);

    // Tap the Yapılacaklar tab
    await tester.tap(find.byIcon(Icons.check));
    await tester.pumpAndSettle();

    // Verify screen is TodoScreen
    expect(find.text('Market'), findsNothing);
    expect(find.text('Alışveriş yap'), findsOneWidget);
    expect(find.text('Kullanıcı Adı: John Doe'), findsNothing);

    // Tap the Hesabım tab
    await tester.tap(find.byIcon(Icons.account_circle));
    await tester.pumpAndSettle();

    // Verify screen is AccountScreen
    expect(find.text('Market'), findsNothing);
    expect(find.text('Alışveriş yap'), findsNothing);
    expect(find.text('Kullanıcı Adı: Suleyman'), findsOneWidget);
  });
}
