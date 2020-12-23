import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:safeevents/PublishEvents.dart';

void main() {
  testWidgets('Error de Nom Esdeveniment', (WidgetTester tester) async {
    // Build the widget.

    await tester.pumpWidget(Publish());

    expect(
        find.byWidgetPredicate((widget) => widget is Visibility && widget.visible == false && widget.key == Key('nomerr')), findsOneWidget
    );

    //await tester.pump(const Duration(milliseconds: 100));
    var textfield = find.byKey(Key('bott'));
    expect(textfield, findsOneWidget);
    await tester.ensureVisible(textfield);
    // Tap the add button.
    await tester.tap(textfield);
    //print(find.widgetWithText(RaisedButton,'Publica').toString());
   /* RaisedButton button = find.byType(RaisedButton).evaluate().first.widget;
    button.onPressed();*/


    expect(find.byWidgetPredicate((widget) => widget is Visibility && widget.visible == false && widget.key == Key('nomerr')), findsNothing);

    await tester.enterText(find.byKey(Key('nomesdeveniment')), 'KIKO RIVERA ON TOUR');

    await tester.tap(find.byType(RaisedButton));

    expect(
        find.byWidgetPredicate((widget) => widget is Visibility && widget.visible == false && widget.key == Key('nomerr')), findsOneWidget
    );

  });
  testWidgets('Error de Direccio', (WidgetTester tester) async {
    // Build the widget.

    await tester.pumpWidget(Publish());

    expect(
        find.byWidgetPredicate((widget) => widget is Visibility && widget.visible == false && widget.key == Key('direrr')), findsOneWidget
    );

    //await tester.pump(const Duration(milliseconds: 100));
    var textfield = find.byKey(Key('bott'));
    // Tap the add button.
    await tester.tap(textfield);
    //print(find.widgetWithText(RaisedButton,'Publica').toString());
    RaisedButton button = find.widgetWithText(RaisedButton, 'Publica').evaluate().first.widget;
    button.onPressed();


    expect(find.byWidgetPredicate((widget) => widget is Visibility && widget.visible == false && widget.key == Key('direrr')), findsNothing);

    await tester.enterText(find.byKey(Key('diresdeveniment')), 'KIKO RIVERA ON TOUR');

    await tester.tap(find.byType(RaisedButton));

    expect(
        find.byWidgetPredicate((widget) => widget is Visibility && widget.visible == false && widget.key == Key('direrr')), findsOneWidget
    );

  });
}

