import 'package:dio/dio.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/pokemon_card.dart';
import '../../domain/repositories/card_repository.dart';
import '../datasources/card_remote_datasource.dart';
import '../models/card_model.dart';

class CardRepositoryImpl implements CardRepository {
  const CardRepositoryImpl(this._remoteDatasource);

  final CardRemoteDatasource _remoteDatasource;

  @override
  Future<List<PokemonCard>> getCards({
    required int page,
    required CancelToken cancelToken,
  }) async {
    try {
      final response = await _remoteDatasource.getCards(
        page: page,
        cancelToken: cancelToken,
      );
      final data = (response['data'] as List<dynamic>? ?? <dynamic>[])
          .map((json) => CardModel.fromJson(json as Map<String, dynamic>))
          .toList(growable: false);
      return data;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        throw const RequestCancelledException();
      }
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw const NetworkFailure();
      }
      throw const ServerFailure();
    }
  }

  @override
  Future<List<PokemonCard>> searchCards({
    required String query,
    required CancelToken cancelToken,
  }) async {
    try {
      final response = await _remoteDatasource.searchCards(
        query: query,
        cancelToken: cancelToken,
      );
      final data = (response['data'] as List<dynamic>? ?? <dynamic>[])
          .map((json) => CardModel.fromJson(json as Map<String, dynamic>))
          .toList(growable: false);
      return data;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        throw const RequestCancelledException();
      }
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw const NetworkFailure();
      }
      throw const ServerFailure();
    }
  }
}
