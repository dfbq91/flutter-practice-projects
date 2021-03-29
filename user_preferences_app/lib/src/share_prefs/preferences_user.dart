import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_preferences_app/src/pages/home_page.dart';

class UserPreferences {
  static final UserPreferences _instance = UserPreferences._internal();
  factory UserPreferences() {
    return _instance;
  }

  UserPreferences._internal();

  SharedPreferences _prefs;

  Future<void> initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // Getters and setters
  get genre {
    return this._prefs.getInt('genre') ?? 1;
  }

  set genre(int value) {
    this._prefs.setInt('genre', value);
  }

  get secundaryColor {
    return this._prefs.getBool('secundaryColor') ?? false;
  }

  set secundaryColor(bool value) {
    this._prefs.setBool('secundaryColor', value);
  }

  get userName {
    return this._prefs.getString('userName') ?? '';
  }

  set userName(String value) {
    this._prefs.setString('userName', value);
  }

  get lastPage {
    return this._prefs.getString('lastPage') ?? HomePage.routeName;
  }

  set lastPage(String value) {
    this._prefs.setString('lastPage', value);
  }
}
