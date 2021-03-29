import 'package:flutter/material.dart';

import 'package:user_preferences_app/src/share_prefs/preferences_user.dart';
import 'package:user_preferences_app/widgets/menu_widget.dart';

// import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  static final String routeName = 'settings';

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _secundaryColor;
  int _genre;
  // String _name = 'Diego';

  TextEditingController _textEditingController;

  final UserPreferences userPreferences = new UserPreferences();

  @override
  void initState() {
    super.initState();

    // loadPreferences();

    // instead of loadPreferences()
    _genre = userPreferences.genre;
    _secundaryColor = userPreferences.secundaryColor;

    userPreferences.lastPage = SettingsPage.routeName;

    _textEditingController =
        new TextEditingController(text: userPreferences.userName);

    final hashCode = identityHashCode(userPreferences);
    print('hashCode from Settings Page in initState: $hashCode');
  }

  // It could be used in initState, but userPreferences is used instead
  // loadPreferences() async {
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  //   _genre = prefs.getInt('genre');
  // _secundaryColor = prefs.getBool('secundaryColor');
  // _name = prefs.getString('userName');
  //   setState(() {});
  // }

  _setSelectedRadio(value) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setInt('genre', value);
    // _genre = value;
    // setState(() {});

    // Instead last 4 lines, we can do the same with userPreferences instance
    userPreferences.genre = value;
    _genre = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor:
            (userPreferences.secundaryColor) ? Colors.teal : Colors.blue,
      ),
      drawer: MenuWidget(),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(5.0),
            child: Text(
              'Settings',
              style: TextStyle(fontSize: 45.0, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(),
          SwitchListTile(
            value: _secundaryColor,
            title: Text('Secundary color'),
            onChanged: (value) {
              _secundaryColor = value;
              userPreferences.secundaryColor = value;
              setState(() {});
            },
          ),
          RadioListTile(
            value: 1,
            title: Text('Male'),
            groupValue: _genre,
            onChanged: _setSelectedRadio,
          ),
          RadioListTile(
            value: 2,
            title: Text('Female'),
            groupValue: _genre,
            onChanged: _setSelectedRadio,
          ),
          Divider(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                  labelText: 'Name',
                  helperText: 'Name of the person using the phone'),
              onChanged: (value) {
                userPreferences.userName = value;
              },
            ),
          )
        ],
      ),
    );
  }
}
