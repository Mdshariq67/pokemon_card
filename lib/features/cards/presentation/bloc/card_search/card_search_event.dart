import 'package:equatable/equatable.dart';

sealed class CardSearchEvent extends Equatable {
  const CardSearchEvent();

  @override
  List<Object?> get props => [];
}

class SearchQueryChanged extends CardSearchEvent {
  const SearchQueryChanged(this.query);

  final String query;

  @override
  List<Object?> get props => [query];
}

class ClearSearch extends CardSearchEvent {
  const ClearSearch();
}

class SearchRequested extends CardSearchEvent {
  const SearchRequested(this.query);

  final String query;

  @override
  List<Object?> get props => [query];
}
