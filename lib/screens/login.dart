import 'package:flutter/material.dart';
import 'package:role_heroes/components/main_snackbar.dart';
import 'package:role_heroes/constants.dart';
import 'package:role_heroes/controllers/auth.dart';
import 'package:role_heroes/screens/game_list.dart';
import 'package:role_heroes/screens/register.dart';

class LoginFormValues {
  String login;
  String password;
}

class LoginScreen extends StatefulWidget {
  static final routeName = '/';

  // TODO replace get controller realize
  final IAuthController controller = AuthController();

  @override
  State<StatefulWidget> createState() {
    return _LoginScreen();
  }
}

class _LoginScreen extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final LoginFormValues _formValues = LoginFormValues();

  void login(BuildContext context) async {
    // TODO придумать норм preloader
    ScaffoldMessenger.of(context).showSnackBar(MainSnackBar(
        content: Center(
          heightFactor: 1,
          widthFactor: 0,
          child: CircularProgressIndicator(),
        ),
    ));

    var result = await widget.controller.login(_formValues.login, _formValues.password);

    if (result is bool && result) {
      ScaffoldMessenger.of(context).showSnackBar(
          MainSnackBar(
            content: Text('Аунтификация успешна'),
            onVisible: () {
              Navigator.of(context).pushReplacementNamed(GameScreen.routeName);
          },
        )
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(MainSnackBar(content: Text(result.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO check auth on splash screen
    widget.controller.checkAuth()
      .then((isAuth) {
        if (isAuth)
          Navigator.of(context).pushReplacementNamed(GameScreen.routeName);
      });

    return Scaffold(
      body: Container(
        height: 500.0,
        padding: const EdgeInsets.all(gDefaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FlutterLogo(size: 90.0),
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
                          result = 'Логин должен содержать больше 3 символов';
                        return result;
                      },
                      onSaved: (String value) => _formValues.login = value,
                      decoration: InputDecoration(
                        labelText: 'Логин',
                        hintText: 'Введите логин',
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
                          result = 'Пароль должен содержать больше 6 символов';
                        return result;
                      },
                      onSaved: (String value) => _formValues.password = value,
                      decoration: InputDecoration(
                        labelText: 'Пароль',
                        hintText: 'Введите пароль',
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
                            login(context);
                        },
                        child: Text('Войти'),
                      ),
                      ElevatedButton(
                        // TODO create style
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey,
                        ),
                        onPressed: () => Navigator.of(context).pushNamed(RegisterScreen.routeName),
                        child: Text('Зарегистрироваться'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
