import 'package:flutter/material.dart';
import 'package:role_heroes/components/flushbar.dart';
import 'package:role_heroes/components/preloader.dart';
import 'package:role_heroes/constants.dart';
import 'package:role_heroes/controllers/user_hero.dart';
import 'package:role_heroes/models/game/game.dart';
import 'package:role_heroes/screens/hero_detail.dart';

class HeroCreateFormValues {
  int gameId;
  String name;
}

class HeroCreateForm extends StatefulWidget {
  // TODO replace get controller realize
  IUserHeroController controller = UserHeroController();

  @override
  _HeroCreateFormState createState() => _HeroCreateFormState();
}

class _HeroCreateFormState extends State<HeroCreateForm> {
  final _formKey = GlobalKey<FormState>();
  final HeroCreateFormValues _formValues = HeroCreateFormValues();

  void createHeroSubject(BuildContext context) async {
    MainFlushbar processFlushbar = MainFlushbar(message: 'Process', showProgressIndicator: true)..show(context);
    var result = await widget.controller.createHero(_formValues.gameId, _formValues.name);
    processFlushbar.dismiss();

    if (result is Map) {
      MainFlushbar(
        message: 'Create success',
        statusColor: Colors.green,
        duration: Duration(seconds: 1),
      )..show(context).whenComplete(() => Navigator.of(context).pushReplacementNamed(HeroDetailScreen.routeName, arguments: {'heroId': result['id']}));
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
                    child: PreLoader(),
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
              child: RaisedButton(
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
