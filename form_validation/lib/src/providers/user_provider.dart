import 'dart:convert';

import 'package:form_validation/src/user_preferences/user_preferences.dart';
import 'package:http/http.dart' as http;

class UserProvider {
  final String firebaseToken = '';
  final _userPreferences = new UserPreferences();

  Future<Map<String, dynamic>> login(String email, String password) async {
    final Uri _url = Uri.https('identitytoolkit.googleapis.com',
        '/v1/accounts:signInWithPassword', {"key": firebaseToken});

    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final response = await http.post(_url, body: json.encode(authData));

    final Map<String, dynamic> decodedResponse = json.decode(response.body);

    print(decodedResponse);

    if (decodedResponse.containsKey("idToken")) {
      // Saves in device session storage
      _userPreferences.token = decodedResponse['idToken'];
      return {'ok': true, 'token': decodedResponse['idToken']};
    } else {
      return {'ok': false, 'message': decodedResponse['error']['message']};
    }
  }

  Future<Map<String, dynamic>> newUser(String email, String password) async {
    final Uri _url = Uri.https('identitytoolkit.googleapis.com',
        '/v1/accounts:signUp', {"key": firebaseToken});

    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final response = await http.post(_url, body: json.encode(authData));

    final Map<String, dynamic> decodedResponse = json.decode(response.body);

    print(decodedResponse);

    if (decodedResponse.containsKey("idToken")) {
      _userPreferences.token = decodedResponse['idToken'];

      return {'ok': true, 'token': decodedResponse['idToken']};
    } else {
      return {'ok': false, 'message': decodedResponse['error']['message']};
    }
  }
}
