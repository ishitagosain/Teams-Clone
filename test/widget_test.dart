import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:twoconnect/authentication/registerscreen.dart';

void main() {
  testWidgets('Flutter Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(RegisterScreen());
    var textField = find.byType(TextField);
    expect(textField, findsOneWidget);
    await tester.enterText(textField, 'Flutter Devs');
    expect(find.text('Flutter Devs'), findsOneWidget);
    print('Flutter Devs');
  });
}
