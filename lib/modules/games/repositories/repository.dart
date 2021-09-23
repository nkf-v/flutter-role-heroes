import 'package:get_it/get_it.dart';
import 'package:role_heroes/clients/api/client.dart';
import 'package:role_heroes/clients/api/role_heroes_client.dart';
import 'package:role_heroes/modules/games/models/game.dart';
import 'package:role_heroes/repository/games.dart';
import 'package:role_heroes/utils/secure_storages.dart';

class GamesRepository implements IGamesRepository {
  final RoleHeroesClient apiClient = GetIt.instance<Client>() as RoleHeroesClient;
  final AccessTokenStorage accessTokenStorage = GetIt.instance<AccessTokenStorage>();

  @override
  Future<List<Game>> getList() async {
    final List list = await apiClient.games(await accessTokenStorage.getValue());

    final List<Game> games = [];

    for (final Map gameDatum in list) {
      Game game = Game();
      game.id = gameDatum['id'];
      game.name = gameDatum['name'];
      game.description = gameDatum['description'];

      games.add(game);
    }

    return games;
  }
}
