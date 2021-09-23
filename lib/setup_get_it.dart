import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:role_heroes/clients/api/client.dart';
import 'package:role_heroes/clients/api/role_heroes_client.dart';
import 'package:role_heroes/utils/secure_storages.dart';

setup() {
  GetIt.I.registerSingleton<FlutterSecureStorage>(FlutterSecureStorage());
  GetIt.I.registerSingleton<AccessTokenStorage>(AccessTokenStorage());
  GetIt.I.registerFactory<Dio>(() {
    final BaseOptions options = BaseOptions(
      baseUrl: 'http://dry-bastion-45736.herokuapp.com/api',
    );
    return Dio(options);
  });
  GetIt.I.registerFactory<Client>(() {
    return new RoleHeroesClient(dio: GetIt.I.get<Dio>(), accessTokenStorage: GetIt.instance<AccessTokenStorage>());
  });
}
