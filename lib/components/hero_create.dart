import 'package:flutter/material.dart';
import 'package:role_heroes/components/main_snackbar.dart';
import 'package:role_heroes/components/pre_loader_widget.dart';
import 'package:role_heroes/constants.dart';
import 'package:role_heroes/controllers/user_hero.dart';
import 'package:role_heroes/modules/games/models/game.dart';
import 'package:role_heroes/modules/heroes/controller/user_hero.dart';

class HeroCreateFormValues {
  int gameId;
  String name;
}

class HeroCreateForm extends StatefulWidget {
  final IUserHeroController controller = UserHeroController();

  @override
  _HeroCreateFormState createState() => _HeroCreateFormState();
}

class _HeroCreateFormState extends State<HeroCreateForm> {
  final _formKey = GlobalKey<FormState>();
  final HeroCreateFormValues _formValues = HeroCreateFormValues();

  void createHeroSubject(BuildContext context) async {
    var result = await widget.controller.create(_formValues.gameId, _formValues.name);

    if (result) {
      ScaffoldMessenger.of(context).showSnackBar(MainSnackBar(content: Text('Герой успешно создан'), onVisible: () {
        Navigator.of(context).pop();
      }));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(MainSnackBar(content: Text('Не удалось создать героя')));
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> defaultValues = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    _formValues.gameId = defaultValues['gameId'];

    return Container(
      padding: EdgeInsets.all(gDefaultPadding),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: gDefaultMargin),
              alignment: AlignmentDirectional.topStart,
              child: FutureBuilder(
                future: widget.controller.gamesForCreateUserHero(),
                builder: (BuildContext context, AsyncSnapshot<List<Game>> snapshot) {
                  Widget result = Center(
                    child: PreLoaderWidget(),
                  );
                  if (snapshot.hasData) {
                    result = DropdownButton<int>(
                      items: snapshot.data.map<DropdownMenuItem<int>>((Game game) {
                        return DropdownMenuItem<int>(value: game.id, child: Text(game.name));
                      }).toList(),
                      onChanged: (int gameId) { _formValues.gameId = gameId; },
                      value: defaultValues['gameId'],
                    );
                  }
                  else if (snapshot.hasError) {
                    result = Text(snapshot.error.toString());
                  }
                  return result;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: gDefaultMargin),
              child: TextFormField(
                keyboardType: TextInputType.text,
                onSaved: (String value) { _formValues.name = value; },
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter name',
                  labelStyle: Theme.of(context).textTheme.bodyText2,
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              child: TextButton(
                child: Text('Create'),
                onPressed: () {
                  _formKey.currentState.save();
                  if (_formKey.currentState.validate())
                    createHeroSubject(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
