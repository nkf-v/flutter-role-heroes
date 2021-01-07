import 'package:flutter/material.dart';
import 'package:role_heroes/constants.dart';
import 'package:role_heroes/screens/login.dart';

class RegisterData {
  String login;
  String password;
  String passwordConfirmation;
}

class RegisterScreen extends StatelessWidget {
  static final routeName = '/register';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  RegisterData _registerData = RegisterData();

  void submitRegisterForm() {
    _formKey.currentState.save();
    if (_formKey.currentState.validate()) {
      // TODO send data to api method for register user
      print(_registerData.login);
      print(_registerData.password);
      // TODO navigate to game list after success register
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(gDefaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: gDefaultMargin),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      validator: (String value) {
                        String result = null;
                        if (value.length < 3)
                          result = 'Login not be less 3 characters';
                        return result;
                      },
                      onSaved: (value) => _registerData.login = value,
                      decoration: InputDecoration(
                        labelText: 'Login',
                        hintText: 'Enter login',
                        labelStyle: Theme.of(context).textTheme.bodyText2,
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: gDefaultMargin),
                    child: TextFormField(
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (String value) {
                        String result;
                        if (value.length < 6)
                          result = 'Password not be less 6 characters';
                        return result;
                      },
                      onSaved: (value) => _registerData.password = value,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter password',
                        labelStyle: Theme.of(context).textTheme.bodyText2,
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: gDefaultMargin),
                    child: TextFormField(
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (String value) {
                        String result;
                        if (value.length < 6)
                          result = 'Password not be less 6 characters';
                        if (value != _registerData.password)
                          result = 'Password confirmation not equals with password';
                        return result;
                      },
                      onSaved: (value) => _registerData.passwordConfirmation = value,
                      decoration: InputDecoration(
                        labelText: 'Password confirmation',
                        hintText: 'Enter password confirmation',
                        labelStyle: Theme.of(context).textTheme.bodyText2,
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: submitRegisterForm,
                        child: Text('Register'),
                      ),
                      RaisedButton(
                        onPressed: () => Navigator.of(context).pushNamed(LoginScreen.routeName),
                        child: Text('Log in'),
                      ),
                    ]
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
