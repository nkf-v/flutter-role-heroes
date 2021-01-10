import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:role_heroes/utils/secure_storages.dart';

import 'clients/api/role_heroes.dart';

setup() {
  GetIt.I.registerSingleton<FlutterSecureStorage>(FlutterSecureStorage());
  GetIt.I.registerSingleton<AccessTokenStorage>(AccessTokenStorage());
  GetIt.I.registerLazySingleton<ApiClient>(ApiClient.setup);
}