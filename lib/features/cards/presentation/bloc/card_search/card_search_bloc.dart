import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/network/dio_client.dart';
import '../../../domain/usecases/search_cards.dart';
import 'card_search_event.dart';
import 'card_search_state.dart';

class CardSearchBloc extends Bloc<CardSearchEvent, CardSearchState> {
  CardSearchBloc(this._searchCards) : super(const CardSearchInitial()) {
    on<SearchQueryChanged>(_onSearchQueryChanged);
    on<SearchRequested>(_onSearchRequested);
    on<ClearSearch>(_onClearSearch);
  }

  final SearchCards _searchCards;
  Timer? _debounce;
  CancelToken? _cancelToken;

  Future<void> _onSearchQueryChanged(
    SearchQueryChanged event,
    Emitter<CardSearchState> emit,
  ) async {
    final query = event.query.trim();
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      add(SearchRequested(query));
    });
  }

  Future<void> _onSearchRequested(
    SearchRequested event,
    Emitter<CardSearchState> emit,
  ) async {
    if (event.query.isEmpty) {
      _cancelToken?.cancel();
      emit(const CardSearchInitial());
      return;
    }

    _cancelToken?.cancel();
    _cancelToken = DioClient.createCancelToken();
    emit(CardSearchLoading(event.query));

    try {
      final cards = await _searchCards(
        query: event.query,
        cancelToken: _cancelToken!,
      );
      if (cards.isEmpty) {
        emit(CardSearchEmpty(event.query));
        return;
      }
      emit(CardSearchSuccess(query: event.query, cards: cards));
    } on RequestCancelledException {
      return;
    } on Failure catch (failure) {
      emit(CardSearchError(failure.message));
    } catch (_) {
      emit(const CardSearchError('Search failed. Please try again.'));
    }
  }

  Future<void> _onClearSearch(
    ClearSearch event,
    Emitter<CardSearchState> emit,
  ) async {
    _debounce?.cancel();
    _cancelToken?.cancel();
    emit(const CardSearchInitial());
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    _cancelToken?.cancel();
    return super.close();
  }
}
