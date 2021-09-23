import 'package:get_it/get_it.dart';
import 'package:role_heroes/clients/api/client.dart';
import 'package:role_heroes/clients/api/role_heroes_client.dart';
import 'package:role_heroes/modules/heroes/models/user_hero.dart';
import 'package:role_heroes/modules/heroes/repositories/base.dart';
import 'package:role_heroes/repository/user_heroes.dart';
import 'package:role_heroes/utils/secure_storages.dart';

class UserHeroesRepository extends BaseRepository implements IUserHeroesRepository {
  @override
  Future<List<UserHero>> getListByGame(int gameId) async {
    final List userHeroData = await this.apiClient.userHeroes(await this.accessTokenStorage.getValue(), gameId);
    final List<UserHero> userHeroes = [];

    for (final Map userHeroDatum in userHeroData) {
      UserHero userHero = UserHero();
      userHero.id = userHeroDatum['id'];
      userHero.name = userHeroDatum['name'];
      userHeroes.add(userHero);
    }

    return userHeroes;
  }

  @override
  Future<UserHero> getDetail(int heroId) async {
    return UserHero.createFromData(
        await this.apiClient.userHero(await accessTokenStorage.getValue(), heroId)
    );
  }

  @override
  Future<bool> create(Map data) async {
    final Map response = await this.apiClient.createHero(await accessTokenStorage.getValue(), data);
    return checkSuccessResponse(response);
  }

  @override
  Future<bool> delete(int heroId) async {
    final Map response = await this.apiClient.deleteHero(await accessTokenStorage.getValue(), heroId);
    return checkSuccessResponse(response);
  }

  @override
  Future<bool> update(UserHero hero, Map data) async {
    final Map response = await this.apiClient.updateHero(await accessTokenStorage.getValue(), hero.id, data);
    return checkSuccessResponse(response);
  }
}
