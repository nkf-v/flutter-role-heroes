import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:role_heroes/models/game/game.dart';
part 'role_heroes.g.dart';

// TODO: get baseUrl from env
@RestApi(baseUrl: 'http://dry-bastion-45736.herokuapp.com/api/')
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  static ApiClient setup({Dio dio}) {
    if (dio == null)
      dio = new Dio();
    return ApiClient(dio);
  }

  @GET('auth/login')
  Future login(@Queries() Map<String, dynamic> json);

  @GET('auth/register')
  Future register(@Queries() Map<String, dynamic> json);

  @GET('auth/logout')
  Future logout(@Header('Authorization') String accessToken, @Queries() Map<String, dynamic> json);

  @GET('auth/refresh')
  Future refresh(@Header('Authorization') String accessToken);

  @GET('games')
  Future<List<Game>> games(@Header('Authorization') String accessToken);
}
