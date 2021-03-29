import 'package:flutter/material.dart';
import 'package:user_preferences_app/src/share_prefs/preferences_user.dart';

import 'package:user_preferences_app/widgets/menu_widget.dart';

class HomePage extends StatelessWidget {
  static final String routeName = 'home';

  @override
  Widget build(BuildContext context) {
    final UserPreferences userPreferences = new UserPreferences();

    userPreferences.lastPage = HomePage.routeName;

    final hashCode = identityHashCode(userPreferences);
    print('hashCode from HomePage: $hashCode');

    return Scaffold(
      appBar: AppBar(
        title: Text('User preferences'),
        backgroundColor:
            (userPreferences.secundaryColor) ? Colors.teal : Colors.blue,
      ),
      drawer: MenuWidget(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Secundary color: ${userPreferences.secundaryColor}'),
          Divider(),
          Text('Gender: ${userPreferences.genre}'),
          Divider(),
          Text('User Name: ${userPreferences.userName}'),
          Divider(),
        ],
      ),
    );
  }
}
