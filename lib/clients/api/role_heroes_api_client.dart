import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'role_heroes_api_client.g.dart';

@RestApi(baseUrl: 'http://dry-bastion-45736.herokuapp.com/api/')
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET('auth/login')
  Future login(@Queries() Map<String, dynamic> json);
}
