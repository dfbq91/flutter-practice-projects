import 'package:flutter/material.dart';
import 'package:form_validation/src/bloc/provider.dart';
import 'package:form_validation/src/pages/home_page.dart';
import 'package:form_validation/src/pages/login_page.dart';
import 'package:form_validation/src/pages/product_page.dart';
import 'package:form_validation/src/pages/sign_up_page.dart';

import 'src/user_preferences/user_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final userPreferences = new UserPreferences();
  await userPreferences.initPreferences();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userPreferences = new UserPreferences();
    print('Token: ${userPreferences.token}');

    return Provider(
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        initialRoute: 'login',
        routes: {
          'login': (BuildContext context) => LoginPage(),
          'homepage': (BuildContext context) => HomePage(),
          'product': (BuildContext context) => ProductPage(),
          'signUp': (BuildContext context) => SignUpPage()
        },
        theme: ThemeData(primaryColor: Colors.teal),
      ),
    );
  }
}
