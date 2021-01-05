// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:safeevents/SignIn.dart';
import 'package:safeevents/reserves.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  testWidgets("login screen", (WidgetTester tester) async {
    //find all the widgets needed in first screen

    final withoutsessionfield = find.byKey(ValueKey("without_session"));
    final signinsessionfield = find.byKey(ValueKey("login_button"));

    await tester.pumpWidget(MaterialApp(
      home: SignIn(),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('es', ''),
        const Locale('ca', ''),
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode)
            return supportedLocale;
        }
        return supportedLocales.first;
      },
    ));
    await tester.tap(withoutsessionfield);
    await tester.pump(); //rebuild your widget

    await tester.pumpWidget(MaterialApp(
      home: SignIn(),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('es', ''),
        const Locale('ca', ''),
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode)
            return supportedLocale;
        }
        return supportedLocales.first;
      },
    ));
    await tester.tap(signinsessionfield);
    await tester.pump(); //rebuild your widget
  });
/*
  testWidgets("selecciona nombre d'entrades", (WidgetTester tester) async {
    //find all the widgets needed in first screen
    final selectField = find.byKey(ValueKey("seleccionar_N_entrades"));
    final reservaField = find.byKey(ValueKey("Reserva_reservaButton"));
    final comprarField = find.byKey(ValueKey("Comprar_reservaButton"));

    //all the alert dialog widgets
    //selectfield widgets
    final selectnumberfield = find.byKey(ValueKey("numberpicker_N_entrades"));
    final okeyField = find.byKey(ValueKey("Okey_selector"));

    //errors and confirmation dialogs
    final errorField = find.byKey(ValueKey("error_button_alert"));
    final confirmacio_compraField =
        find.byKey(ValueKey("confirmation_button_alert_compra"));
    final confirmacio_reservaField =
        find.byKey(ValueKey("confirmation_button_alert_reserva"));
    final okey_comprar2Field =
        find.byKey(ValueKey("Okey_button_alert_compra_2"));
    final okey_comprar1Field =
        find.byKey(ValueKey("Okey_button_alert_compra_1"));
    final okey_reservaField = find.byKey(ValueKey("Okey_button_alert_reserva"));
    final without_sessionfield = find.byKey(ValueKey("without_session"));
    final signin_sessionfield = find.byKey(ValueKey("login_button"));

    //the params needed
    int id = 1;
    int entrades = 1;
    //expect(actual, matcher);

    //execute the actual test
    await tester.pumpWidget(MaterialApp(
        home: Reserves(
      id: id,
      entradas: entrades,
    )));
    await tester.tap(selectField);
    // await tester.ensureVisible(selectnumberfield);
    //await tester.
    await tester.tap(okeyField);
    await tester.pump(); //rebuild your widget

    //check outputs
    expect(find.text("Nombre d'entrades seleccionades: 0"), findsOneWidget);
  });*/
}
