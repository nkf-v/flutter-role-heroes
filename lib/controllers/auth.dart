import 'package:role_heroes/utils/base_controller.dart';

abstract class IAuthController {
  Future<dynamic> login(String login, String password);
  Future<dynamic> register(String login, String password, String passwordConfirmation);
  Future logout();
  Future<bool> checkAuth();
}

class AuthController extends BaseController implements IAuthController {
  @override
  Future<dynamic> login(String login, String password) async {
    final Map<String, dynamic> data = await this.apiClient.login({
      'login': login,
      'password': password,
    });

    if (data.containsKey('access_token')) {
      await this.accessTokenStorage.setValue(data['access_token']);
      return true;
    }

    return data;
  }

  @override
  Future<dynamic> register(
      String login,
      String password,
      String passwordConfirmation
    ) async {
    Map result = await apiClient.register({
      'login': login,
      'password': password,
      'password_confirmation': passwordConfirmation,
    });

    await this.accessTokenStorage.setValue(result['access_token']);
    return true;
  }

  @override
  Future logout() async {
    return apiClient.logout(await accessTokenStorage.getValue());
  }

  @override
  Future<bool> checkAuth() async {
    bool result = false;
    String accessToken = await accessTokenStorage.getValue();

    if (accessToken != null && accessToken != '') {
      Map response = await apiClient.refresh(accessToken);

      if (response.containsKey('access_token') != null) {
        await accessTokenStorage.setValue(response['access_token']);
        result = true;
      }
    }

    return result;
  }
}
