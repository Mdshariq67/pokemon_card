import 'package:dio/dio.dart';

import '../entities/pokemon_card.dart';

abstract class CardRepository {
  Future<List<PokemonCard>> getCards({
    required int page,
    required CancelToken cancelToken,
  });

  Future<List<PokemonCard>> searchCards({
    required String query,
    required CancelToken cancelToken,
  });
}
