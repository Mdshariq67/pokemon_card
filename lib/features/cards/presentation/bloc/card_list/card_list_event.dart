import 'package:equatable/equatable.dart';

sealed class CardListEvent extends Equatable {
  const CardListEvent();

  @override
  List<Object?> get props => [];
}

class LoadCards extends CardListEvent {
  const LoadCards();
}

class LoadMoreCards extends CardListEvent {
  const LoadMoreCards();
}

class RefreshCards extends CardListEvent {
  const RefreshCards();
}
