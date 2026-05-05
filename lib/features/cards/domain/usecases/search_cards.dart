import 'package:dio/dio.dart';

import '../entities/pokemon_card.dart';
import '../repositories/card_repository.dart';

class SearchCards {
  const SearchCards(this._repository);

  final CardRepository _repository;

  Future<List<PokemonCard>> call({
    required String query,
    required CancelToken cancelToken,
  }) {
    return _repository.searchCards(query: query, cancelToken: cancelToken);
  }
}
