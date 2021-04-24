import 'package:flutter/material.dart';
import 'package:form_validation/src/bloc/provider.dart';
import 'package:form_validation/src/providers/user_provider.dart';
import 'package:form_validation/src/utils/utils.dart';

class SignUpPage extends StatelessWidget {
  final userProvider = new UserProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [createBackground(context), _signUpForm(context)],
      ),
    );
  }

  Widget createBackground(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    final tealBackground = Container(
      width: double.infinity,
      height: height * 0.4,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromRGBO(0, 128, 128, 1.0),
        Color.fromRGBO(0, 138, 138, 1.0)
      ])),
    );

    final circle = Container(
      width: height * 0.15,
      height: height * 0.15,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.05)),
    );

    return Stack(
      children: [
        tealBackground,
        Positioned(child: circle, top: 90.0, left: 30.0),
        Positioned(child: circle, top: -40.0, right: -30.0),
        Positioned(child: circle, bottom: -50.0, right: -10.0),
        Positioned(child: circle, top: -10.0, right: 120.0),
        Positioned(child: circle, bottom: -50.0, left: -20.0),
        Container(
          padding: EdgeInsets.only(top: height * 0.07),
          child: Column(
            children: [
              Icon(
                Icons.person_pin_circle,
                color: Colors.white,
                size: height * 0.12,
              ),
              SizedBox(
                height: 10.0,
                width: double.infinity,
              ),
              Text(
                'Diego Betancourt',
                style: TextStyle(color: Colors.white, fontSize: 25.0),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _signUpForm(BuildContext context) {
    final bloc = Provider.of(context);
    final double width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(children: [
        SafeArea(
          child: Container(
            height: 180.0,
          ),
        ),
        Container(
          width: width * 0.85,
          padding: EdgeInsets.symmetric(vertical: 30.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 3.0,
                    spreadRadius: 3.0,
                    offset: (Offset(0.0, 5.0)))
              ]),
          child: Column(
            children: [
              Text('Crear cuenta', style: TextStyle(fontSize: 20.0)),
              SizedBox(height: 50.0),
              _createEmailField(bloc),
              SizedBox(height: 30.0),
              _createPasswordField(bloc),
              SizedBox(height: 30.0),
              _createButton(bloc)
            ],
          ),
        ),
        SizedBox(height: 15.0),
        TextButton(
            onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
            child: Text('Ya tengo una cuenta. Iniciar sesión')),
        SizedBox(
          height: 100.0,
        )
      ]),
    );
  }

  Widget _createEmailField(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.alternate_email, color: Colors.teal),
              hintText: 'myemail@email.com',
              labelText: 'Correo electrónico',
              counterText: snapshot.data,
              errorText: snapshot.error,
            ),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    );
  }

  Widget _createPasswordField(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                icon: Icon(Icons.lock_outline, color: Colors.teal),
                labelText: 'Contraseña',
                counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  Widget _createButton(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 90.0, vertical: 15.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            elevation: 0.0,
          ),
          child: Container(
            child: Text('Ingresar'),
          ),
          onPressed: snapshot.hasData ? () => _signUp(bloc, context) : null,
          // elevation: 0.0,
          // color: Colors.teal,
          // textColor: Colors.white,
        );
      },
    );
  }

  _signUp(LoginBloc bloc, BuildContext context) async {
    userProvider.newUser(bloc.email, bloc.password);

    final Map signUpResult =
        await userProvider.newUser(bloc.email, bloc.password);
    if (signUpResult.containsKey('token')) {
      Navigator.pushReplacementNamed(context, 'homepage');
    } else {
      showAlert(context, signUpResult['message']);
    }
  }
}
