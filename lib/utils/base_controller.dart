import 'package:get_it/get_it.dart';
import 'package:role_heroes/clients/api/role_heroes.dart';
import 'package:role_heroes/utils/secure_storages.dart';

class BaseController {
  final ApiClient apiClient = GetIt.instance<ApiClient>();
  final AccessTokenStorage accessTokenStorage = GetIt.instance<AccessTokenStorage>();

  // ApiClient get apiClient => _apiClient;

  // AccessTokenStorage get accessTokenStorage => _accessTokenStorage;

  String getErrorMessage(Map response) {
    response = Map.from(response['errors']);
    var error = response[response.keys.first].first;
    String errorMessage = error['message'];
    if (errorMessage == null)
      errorMessage = error['code'];
    return errorMessage;
  }

  Future<String> getBearerToken() async {
    return 'Bearer ${await accessTokenStorage.getValue()}';
  }
}