import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/network/dio_client.dart';
import '../../../domain/entities/pokemon_card.dart';
import '../../../domain/usecases/get_cards.dart';
import 'card_list_event.dart';
import 'card_list_state.dart';

class CardListBloc extends Bloc<CardListEvent, CardListState> {
  CardListBloc(this._getCards) : super(const CardListInitial()) {
    on<LoadCards>(_onLoadCards);
    on<LoadMoreCards>(_onLoadMoreCards);
    on<RefreshCards>(_onRefreshCards);
  }

  final GetCards _getCards;
  CancelToken? _cancelToken;
  CardListEvent _lastEvent = const LoadCards();

  CardListEvent get lastEvent => _lastEvent;

  Future<void> _onLoadCards(LoadCards event, Emitter<CardListState> emit) async {
    _lastEvent = event;
    _cancelToken?.cancel();
    _cancelToken = DioClient.createCancelToken();
    emit(const CardListLoading());

    try {
      final cards = await _getCards(page: 1, cancelToken: _cancelToken!);
      emit(
        CardListSuccess(
          cards: cards,
          page: 1,
          hasMore: cards.length >= pageSize,
        ),
      );
    } on RequestCancelledException {
      return;
    } on Failure catch (failure) {
      emit(CardListError(failure.message));
    } catch (_) {
      emit(const CardListError('Unable to load cards. Please try again.'));
    }
  }

  Future<void> _onLoadMoreCards(LoadMoreCards event, Emitter<CardListState> emit) async {
    if (state is! CardListSuccess) return;

    final current = state as CardListSuccess;
    if (!current.hasMore || state is CardListLoadingMore) return;

    _lastEvent = event;
    _cancelToken?.cancel();
    _cancelToken = DioClient.createCancelToken();
    emit(CardListLoadingMore(cards: current.cards, page: current.page, hasMore: current.hasMore));

    try {
      final nextPage = current.page + 1;
      final cards = await _getCards(page: nextPage, cancelToken: _cancelToken!);
      final combined = List<PokemonCard>.of(current.cards)..addAll(cards);
      emit(
        CardListSuccess(
          cards: combined,
          page: nextPage,
          hasMore: cards.length >= pageSize,
        ),
      );
    } on RequestCancelledException {
      emit(current);
    } on Failure catch (failure) {
      emit(CardListError(failure.message));
      emit(current);
    } catch (_) {
      emit(const CardListError('Unable to load more cards.'));
      emit(current);
    }
  }

  Future<void> _onRefreshCards(RefreshCards event, Emitter<CardListState> emit) async {
    _lastEvent = event;
    add(const LoadCards());
  }

  @override
  Future<void> close() {
    _cancelToken?.cancel();
    return super.close();
  }
}
