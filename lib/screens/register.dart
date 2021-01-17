import 'package:flutter/material.dart';
import 'package:role_heroes/components/flushbar.dart';
import 'package:role_heroes/constants.dart';
import 'package:role_heroes/controllers/auth.dart';

import 'game_list.dart';

class RegisterFormValues {
  String login;
  String password;
  String passwordConfirmation;
}

class RegisterScreen extends StatelessWidget {
  static final routeName = '/register';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RegisterFormValues _formValues = RegisterFormValues();
  // TODO replace get controller realize
  final IAuthController controller = AuthController();

  void register(BuildContext context) async {
    MainFlushbar processFlushbar = MainFlushbar(message: 'Process', showProgressIndicator: true)..show(context);
    var result = await controller.register(_formValues.login, _formValues.password, _formValues.passwordConfirmation);
    processFlushbar.dismiss();

    if (result is bool && result) {
      MainFlushbar(
        message: 'Register success',
        statusColor: Colors.green,
        duration: Duration(seconds: 1),
      )..show(context).whenComplete(() => Navigator.of(context).pushReplacementNamed(GameScreen.routeName));
    }
    else {
      MainFlushbar(
        message: result,
        statusColor: Colors.red,
        duration: Duration(seconds: 2),
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(gDefaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: gDefaultPadding),
              child: Text('Register new user', style: Theme.of(context).textTheme.headline2,),
            ),
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
                        String result;
                        if (value.length < 3)
                          result = 'Login not be less 3 characters';
                        return result;
                      },
                      onSaved: (value) => _formValues.login = value,
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
                      onSaved: (value) => _formValues.password = value,
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
                        if (value != _formValues.password)
                          result = 'Password confirmation not equals with password';
                        return result;
                      },
                      onSaved: (value) => _formValues.passwordConfirmation = value,
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
                        onPressed: () {
                          _formKey.currentState.save();
                          if (_formKey.currentState.validate())
                            register(context);
                        },
                        child: Text('Register'),
                      ),
                      RaisedButton(
                        onPressed: Navigator.of(context).pop,
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
