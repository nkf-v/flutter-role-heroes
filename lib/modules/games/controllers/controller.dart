import 'package:role_heroes/controllers/game.dart';
import 'package:role_heroes/modules/games/models/game.dart';
import 'package:role_heroes/modules/games/repositories/repository.dart';
import 'package:role_heroes/repository/games.dart';
import 'package:role_heroes/utils/base_controller.dart';

class GameController implements IGameController {
  final IGamesRepository repository = GamesRepository();

  @override
  Future<List<Game>> games() {
    return repository.getList();
  }
}
