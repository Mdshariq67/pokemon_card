import 'package:dio/dio.dart';

import '../../../../core/constants/api_constants.dart';

abstract class CardRemoteDatasource {
  Future<Map<String, dynamic>> getCards({
    required int page,
    required CancelToken cancelToken,
  });

  Future<Map<String, dynamic>> searchCards({
    required String query,
    required CancelToken cancelToken,
  });
}

class CardRemoteDatasourceImpl implements CardRemoteDatasource {
  const CardRemoteDatasourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<Map<String, dynamic>> getCards({
    required int page,
    required CancelToken cancelToken,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/cards',
      queryParameters: <String, dynamic>{
        'page': page,
        'pageSize': pageSize,
      },
      cancelToken: cancelToken,
    );

    return response.data ?? <String, dynamic>{};
  }

  @override
  Future<Map<String, dynamic>> searchCards({
    required String query,
    required CancelToken cancelToken,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/cards',
      queryParameters: <String, dynamic>{
        'q': 'name:$query*',
      },
      cancelToken: cancelToken,
    );

    return response.data ?? <String, dynamic>{};
  }
}
