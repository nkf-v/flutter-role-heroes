import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:role_heroes/clients/api/role_heroes.dart';
import 'package:role_heroes/utils/base_controller.dart';
import 'package:role_heroes/utils/secure_storages.dart';

abstract class IAuthController {
  Future<dynamic> login(String login, String password);
  Future<dynamic> register(String login, String password, String passwordConfirmation);
  Future<void> logout();
  Future<dynamic> checkAuth();
}

class AuthController extends BaseController implements IAuthController {
  @override
  Future<dynamic> login(String login, String password) async {
    var result;
    try {
      result = _saveAccessToken(await apiClient.login({'login': login, 'password': password}));
    }
    catch (dioError) {
      result = handleException(dioError);
    }
    return result;
  }

  @override
  Future<dynamic> register(String login, String password, String passwordConfirmation) async {
    var result;
    try {
      result = _saveAccessToken(await apiClient.register({'login': login, 'password': password, 'password_confirmation': passwordConfirmation}));
    }
    catch (dioError) {
      result = handleException(dioError);
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
      accessTokenStorage.setValue(response['access_token']);
      isSave = true;
    }
    return isSave;
  }

  @override
  Future<bool> checkAuth() async {
    String accessToken = await accessTokenStorage.getValue();
    bool result = false;
    if (accessToken != null && accessToken != '')
      result = await _refresh(accessToken);
    return result;
  }

  Future<bool> _refresh(String accessToken) async {
    bool result = false;
    try {
      result = _saveAccessToken(await apiClient.refresh(accessToken));
    }
    catch (dioError) {}
    return result;
  }
}
