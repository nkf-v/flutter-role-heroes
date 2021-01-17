import 'package:role_heroes/models/user_hero/user_hero.dart';
import 'package:role_heroes/utils/base_controller.dart';

abstract class IUserHeroController {
  Future<List<UserHero>> userHeroes(int gameId);
}

class UserHeroController extends BaseController implements IUserHeroController {
  @override
  Future<List<UserHero>> userHeroes(int gameId) async {
    return apiClient.userHeroes(await getBearerToken(), gameId);
  }
}
