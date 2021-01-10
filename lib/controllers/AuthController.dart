import 'package:get_it/get_it.dart';
import 'package:role_heroes/clients/api/role_heroes.dart';
import 'package:role_heroes/utils/base_controller.dart';
import 'package:role_heroes/utils/get_message_error.dart';
import 'package:role_heroes/utils/secure_storages.dart';
import 'package:dio/dio.dart';

abstract class IAuthController {
  Future<dynamic> login(String login, String password);
  Future<void> register();
  Future<void> logout();
}

class AuthController extends BaseController implements IAuthController {
  final ApiClient _apiClient = GetIt.instance<ApiClient>();
  final AccessTokenStorage _accessTokenStorage = GetIt.instance<AccessTokenStorage>();

  @override
  Future<dynamic> login(String login, String password) async {
    var result;
    try
    {
      result = _saveAccessToken(await _apiClient.login({'login': login, 'password': password}));
    }
    catch (dioError)
    {
      result = _exceptionHandle(dioError);
    }
    return result;
  }

  @override
  Future<void> logout() {
    
  }

  @override
  Future<void> register() {
    
  }

  bool _saveAccessToken(response) {
    bool isSave = false;
    if (response['access_token'] != null) {
      _accessTokenStorage.setValue(response['access_token']);
      isSave = true;
    }
    return isSave;
  }

  dynamic _exceptionHandle(exception) {
    var result;
    switch (exception.runtimeType) {
      case DioError:
        result =  GetErrorMessage.fromApiResponse((exception as DioError).response.data);
        break;
      default:
    }
    return result;
  }
}
