import 'package:flutter/material.dart';
import 'package:role_heroes/components/flushbar.dart';
import 'package:role_heroes/constants.dart';
import 'package:role_heroes/controllers/AuthController.dart';
import 'package:role_heroes/screens/game_list.dart';
import 'package:role_heroes/screens/register.dart';

class LoginFormValues {
  String login;
  String password;
}

class LoginScreen extends StatelessWidget {
  static final routeName = '/';

  final _formKey = GlobalKey<FormState>();
  final LoginFormValues formValues = LoginFormValues();
  // TODO Change method get controller
  final AuthController controller = AuthController();

  void login(BuildContext context) async {
    MainFlushbar processFlushbar = MainFlushbar(message: 'Process', showProgressIndicator: true)..show(context);
    var result = await controller.login(formValues.login, formValues.password);
    processFlushbar.dismiss();

    if (result is bool && result) {
      MainFlushbar(
        message: 'Log in success',
        statusColor: Colors.green,
        duration: Duration(seconds: 2),
      ).show(context);
      Navigator.of(context).pushReplacementNamed(GameScreen.routeName);
    }
    else {
      MainFlushbar(
        message: result,
        statusColor: Colors.red,
        duration: Duration(seconds: 2),
      ).show(context);
    }
  }

  void submitLoginForm(BuildContext context) async {
    _formKey.currentState.save();
    if (_formKey.currentState.validate()) {
      login(context);
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Role', style:  TextStyle(color: gTextColor, fontSize: 28.0, fontWeight: FontWeight.bold)),
                Text('heroes', style: TextStyle(color: gTextLightColor, fontSize: 28.0)),
              ],
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
                          result = 'Login length is less 3 characters';
                        return result;
                      },
                      onSaved: (String value) => formValues.login = value,
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
                      keyboardType: TextInputType.text,
                      validator: (String value) {
                        String result;
                        if (value.length < 6)
                          result = 'Password length is less 6 characters';
                        return result;
                      },
                      onSaved: (String value) => formValues.password = value,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter password',
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
                          onPressed: () => submitLoginForm(context),
                          child: Text('Log in'),
                        ),
                        RaisedButton(
                          onPressed: () => Navigator.of(context).pushNamed(RegisterScreen.routeName),
                          child: Text('Register'),
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
