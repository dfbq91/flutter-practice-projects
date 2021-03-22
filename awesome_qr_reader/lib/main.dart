// Packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Providers
import 'package:awesome_qr_reader/providers/ui_provider.dart';
import 'package:awesome_qr_reader/providers/scan_list_provider.dart';

// Pages
import 'package:awesome_qr_reader/pages/home_page.dart';
import 'package:awesome_qr_reader/pages/map_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => new UiProvider()),
        ChangeNotifierProvider(create: (context) => new ScanListProvider()),
      ],
      child: MaterialApp(
          title: 'Awesome QR Reader',
          initialRoute: 'home',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primaryColor: Colors.blueGrey[800],
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Colors.blueGrey[800])),
          routes: {'home': (_) => HomePage(), 'map': (_) => MapPage()}),
    );
  }
}
