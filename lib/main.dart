import 'package:flutter/material.dart';
import 'package:push_notification/screens/login/login.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: const [
        FormBuilderLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar'),
        Locale('bn'),
        Locale('ca'),
        Locale('de'),
        Locale('en'),
        Locale('es'),
        Locale('et'),
        Locale('fa'),
        Locale('fr'),
        Locale('hu'),
        Locale('id'),
        Locale('it'),
        Locale('ja'),
        Locale('ko'),
        Locale('lo'),
        Locale('nl'),
        Locale('ro'),
        Locale('sw'),
        Locale('uk'),
        Locale('zh_Hans'),
        Locale('zh_Hant'),
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Login(),
    );
  }
}
