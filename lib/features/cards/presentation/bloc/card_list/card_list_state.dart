import 'package:equatable/equatable.dart';

import '../../../domain/entities/pokemon_card.dart';

sealed class CardListState extends Equatable {
  const CardListState();

  @override
  List<Object?> get props => [];
}

class CardListInitial extends CardListState {
  const CardListInitial();
}

class CardListLoading extends CardListState {
  const CardListLoading();
}

class CardListLoadingMore extends CardListState {
  const CardListLoadingMore({
    required this.cards,
    required this.page,
    required this.hasMore,
  });

  final List<PokemonCard> cards;
  final int page;
  final bool hasMore;

  @override
  List<Object?> get props => [cards, page, hasMore];
}

class CardListSuccess extends CardListState {
  const CardListSuccess({
    required this.cards,
    required this.page,
    required this.hasMore,
  });

  final List<PokemonCard> cards;
  final int page;
  final bool hasMore;

  @override
  List<Object?> get props => [cards, page, hasMore];
}

class CardListError extends CardListState {
  const CardListError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
