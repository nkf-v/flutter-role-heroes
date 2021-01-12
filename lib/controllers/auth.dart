import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:role_heroes/clients/api/role_heroes.dart';
import 'package:role_heroes/utils/base_controller.dart';
import 'package:role_heroes/utils/secure_storages.dart';

abstract class IAuthController {
  Future<dynamic> login(String login, String password);
  Future<dynamic> register(String login, String password, String passwordConfirmation);
  Future<void> logout();
  Future<bool> checkAuth();
}

class AuthController extends BaseController implements IAuthController {
  final ApiClient _apiClient = GetIt.instance<ApiClient>();
  final AccessTokenStorage _accessTokenStorage = GetIt.instance<AccessTokenStorage>();

  @override
  Future<dynamic> login(String login, String password) async {
    var result;
    try {
      result = _saveAccessToken(await _apiClient.login({'login': login, 'password': password}));
    }
    catch (dioError) {
      result = _exceptionHandle(dioError);
    }
    return result;
  }

  @override
  Future<dynamic> register(String login, String password, String passwordConfirmation) async {
    var result;
    try {
      result = _saveAccessToken(await _apiClient.register({'login': login, 'password': password, 'password_confirmation': passwordConfirmation}));
    }
    catch (dioError) {
      result = _exceptionHandle(dioError);
    }
    return result;
  }

  @override
  Future<void> logout() {
    // TODO: realize logout
  }

  bool _saveAccessToken(response) {
    bool isSave = false;
    if (response['access_token'] != null) {
      _accessTokenStorage.setValue(response['access_token']);
      isSave = true;
    }
    return isSave;
  }

  @override
  Future<bool> checkAuth() async {
    String accessToken = await _accessTokenStorage.getValue();
    bool result = true;
    if (accessToken != null && accessToken != '')
      result = await _refresh(accessToken);
    return result;
  }

  Future<bool> _refresh(String accessToken) async {
    bool result = true;
    try {
      result = _saveAccessToken(await _apiClient.refresh(accessToken));
    }
    catch (dioError) {
      result = _exceptionHandle(dioError);
    }
    return result;
  }

  dynamic _exceptionHandle(exception) {
    var result;
    switch (exception.runtimeType) {
      case DioError:
        result = getErrorMessage((exception as DioError).response.data);
        break;
      default:
    }
    return result;
  }
}