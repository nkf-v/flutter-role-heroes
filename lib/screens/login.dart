import 'package:flutter/material.dart';
import 'package:role_heroes/constants.dart';
import 'package:role_heroes/screens/register.dart';

class LoginScreen extends StatelessWidget {
  static final routeName = '/';

  final _formKey = GlobalKey<FormState>();

  void submitLoginForm() {
    _formKey.currentState.save();
    if (_formKey.currentState.validate()) {
      // TODO login by api method
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
                      keyboardType: TextInputType.text,
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
                          onPressed: () {},
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
