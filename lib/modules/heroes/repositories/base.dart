import 'package:get_it/get_it.dart';
import 'package:role_heroes/clients/api/client.dart';
import 'package:role_heroes/clients/api/role_heroes_client.dart';
import 'package:role_heroes/utils/secure_storages.dart';

abstract class BaseRepository {
  final Client apiClient = GetIt.instance<Client>() as RoleHeroesClient;
  final AccessTokenStorage accessTokenStorage = GetIt.instance<AccessTokenStorage>();

  bool checkSuccessResponse(Map response) => !response.containsKey('errors');
}
