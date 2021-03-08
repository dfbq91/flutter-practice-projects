import 'package:flutter/material.dart';

import 'package:designs/src/pages/basic_page.dart';
import 'package:designs/src/pages/scroll_page.dart';
import 'package:designs/src/pages/buttons_page.dart';
// import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // // Set color of notch in IoS devices
    // SystemChrome.setSystemUIOverlayStyle(
    //     SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.white));

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Designs',
        initialRoute: 'buttons',
        routes: {
          'basic': (BuildContext context) => BasicPage(),
          'scroll': (BuildContext context) => ScrollPage(),
          'buttons': (BuildContext context) => ButtonsPage()
        });
  }
}
