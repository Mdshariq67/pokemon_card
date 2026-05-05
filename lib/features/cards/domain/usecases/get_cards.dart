import 'package:dio/dio.dart';

import '../entities/pokemon_card.dart';
import '../repositories/card_repository.dart';

class GetCards {
  const GetCards(this._repository);

  final CardRepository _repository;

  Future<List<PokemonCard>> call({
    required int page,
    required CancelToken cancelToken,
  }) {
    return _repository.getCards(page: page, cancelToken: cancelToken);
  }
}
