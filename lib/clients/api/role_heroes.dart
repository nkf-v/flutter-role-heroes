import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:role_heroes/models/game/game.dart';
import 'package:role_heroes/models/user_hero/user_hero.dart';

part 'role_heroes.g.dart';

// TODO слишком многго Header Authorization

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

  @GET('games/{gameId}/heroes')
  Future<List<UserHero>> userHeroes(@Header('Authorization') String accessToken, @Path('gameId') int gameId);

  @GET('heroes/{heroId}')
  Future<UserHero> userHero(@Header('Authorization') String accessToken, @Path('heroId') int heroId);

  @POST('heroes/create')
  Future createHero(@Header('Authorization') String accessToken, @Body() Map<String, dynamic> json);

  @DELETE('heroes/{heroId}')
  Future deleteHero(@Header('Authorization') String accessToken, @Path('heroId') int heroId);

  @PUT('heroes/{heroId}')
  Future updateHero(@Header('Authorization') String accessToken, @Path('heroId') int heroId, @Body() Map<String, dynamic> json);
}
