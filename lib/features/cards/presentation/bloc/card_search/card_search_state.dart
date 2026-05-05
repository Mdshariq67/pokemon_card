import 'package:equatable/equatable.dart';

import '../../../domain/entities/pokemon_card.dart';

sealed class CardSearchState extends Equatable {
  const CardSearchState();

  @override
  List<Object?> get props => [];
}

class CardSearchInitial extends CardSearchState {
  const CardSearchInitial();
}

class CardSearchLoading extends CardSearchState {
  const CardSearchLoading(this.query);

  final String query;

  @override
  List<Object?> get props => [query];
}

class CardSearchSuccess extends CardSearchState {
  const CardSearchSuccess({
    required this.query,
    required this.cards,
  });

  final String query;
  final List<PokemonCard> cards;

  @override
  List<Object?> get props => [query, cards];
}

class CardSearchEmpty extends CardSearchState {
  const CardSearchEmpty(this.query);

  final String query;

  @override
  List<Object?> get props => [query];
}

class CardSearchError extends CardSearchState {
  const CardSearchError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
