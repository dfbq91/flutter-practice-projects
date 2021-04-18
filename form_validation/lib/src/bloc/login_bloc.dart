import 'dart:async';
import 'package:form_validation/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {
  // Broadcast allows that there are many instances listening changes
  // final _emailController = StreamController<String>.broadcast();
  // final _passwordController = StreamController<String>.broadcast();
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  // Get values of stream
  Stream<String> get emailStream =>
      _emailController.stream.transform(validateEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validatePassword);
  Stream<bool> get formValidStream =>
      Observable.combineLatest2(emailStream, passwordStream, (e, p) => true);

  // Add values to stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  // Get the last value of the stream
  String get email =>
      _emailController.value != null ? _emailController.value : '';
  String get password =>
      _passwordController.value != null ? _passwordController.value : '';

  // Close stream
  dispose() {
    _emailController?.close();
    _passwordController?.close();
  }
}
