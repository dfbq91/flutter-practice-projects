import 'package:flutter/material.dart';
import 'package:flutter_components_practice/src/pages/alert_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter_components_practice/src/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Components Practice',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', 'US'),
          const Locale('es', 'ES'),
        ],
        routes: getApplicationRoutes(),
        onGenerateRoute: (RouteSettings routeSettings) {
          return MaterialPageRoute(
              builder: (BuildContext context) => AlertPage());
        });
  }
}
