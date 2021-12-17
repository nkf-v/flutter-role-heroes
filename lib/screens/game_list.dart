import 'package:flutter/material.dart';
import 'package:role_heroes/components/game_list.dart';
import 'package:role_heroes/controllers/auth.dart';
import 'package:role_heroes/screens/login.dart';
import 'package:role_heroes/widgets/pre_loader.dart';

class GameScreen extends StatelessWidget {
  static const routeName = '/games';
  final IAuthController authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GameList(),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text(
                'Test' // TODO replace on localization
              ),
            ),
            ListTile(
              title: Text('Log out'),
              onTap: () {
                PreLoader.show(context);

                authController.logout().then((value) {
                  Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
