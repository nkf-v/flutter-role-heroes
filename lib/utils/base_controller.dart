import 'package:get_it/get_it.dart';
import 'package:role_heroes/clients/api/client.dart';
import 'package:role_heroes/utils/secure_storages.dart';

abstract class BaseController {
  final Client apiClient = GetIt.instance<Client>();
  final AccessTokenStorage accessTokenStorage = GetIt.instance<AccessTokenStorage>();

  Future<String> getBearerToken() async {
    return 'Bearer ${await accessTokenStorage.getValue()}';
  }
}
