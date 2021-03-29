import 'package:flutter/material.dart';

import 'package:user_preferences_app/src/pages/home_page.dart';
import 'package:user_preferences_app/src/pages/settings_page.dart';
import 'package:user_preferences_app/src/share_prefs/preferences_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final UserPreferences userPreferences = new UserPreferences();

  final hashCode = identityHashCode(userPreferences);
  print(
      'hashCode from main: $hashCode'); // it should be the same hashcode due to singleton

  await userPreferences.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserPreferences userPreferences = new UserPreferences();
    return MaterialApp(
        title: 'User preferences',
        initialRoute: userPreferences.lastPage,
        routes: {
          HomePage.routeName: (BuildContext context) => HomePage(),
          SettingsPage.routeName: (BuildContext context) => SettingsPage()
        });
  }
}
