// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_heroes_api_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ApiClient implements ApiClient {
  _ApiClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'http://dry-bastion-45736.herokuapp.com/api/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<dynamic> login(json) async {
    ArgumentError.checkNotNull(json, 'json');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(json ?? <String, dynamic>{});
    final _data = <String, dynamic>{};
    final _result = await _dio.request('auth/login',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
    return value;
  }
}
