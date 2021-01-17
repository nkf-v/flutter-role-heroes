import 'package:role_heroes/models/game/game.dart';
import 'package:role_heroes/utils/base_controller.dart';

abstract class IGameController {
  Future<List<Game>> games();
}

class GameController extends BaseController implements IGameController {
  @override
  Future<List<Game>> games() async {
    return apiClient.games(await getBearerToken());
  }
}