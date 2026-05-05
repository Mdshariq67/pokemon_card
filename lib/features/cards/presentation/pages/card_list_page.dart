import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/card_list/card_list_bloc.dart';
import '../bloc/card_list/card_list_event.dart';
import '../bloc/card_list/card_list_state.dart';
import '../bloc/card_search/card_search_bloc.dart';
import '../bloc/card_search/card_search_state.dart';
import '../widgets/card_grid.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/loading_shimmer.dart';
import '../widgets/pagination_loader.dart';
import '../widgets/search_bar_widget.dart';

class CardListPage extends StatelessWidget {
  const CardListPage({super.key});

  bool _buildWhen(CardListState previous, CardListState current) {
    if (previous.runtimeType != current.runtimeType) return true;
    if (previous is CardListSuccess && current is CardListSuccess) {
      if (previous.cards.length != current.cards.length) return true;
      for (var i = 0; i < current.cards.length; i++) {
        if (previous.cards[i].id != current.cards[i].id) return true;
      }
      return previous.page != current.page || previous.hasMore != current.hasMore;
    }
    return previous != current;
  }

  bool _onScrollNotification(BuildContext context, ScrollNotification notification) {
    if (notification.metrics.pixels > notification.metrics.maxScrollExtent - 200) {
      context.read<CardListBloc>().add(const LoadMoreCards());
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<CardListBloc, CardListState>(
        listener: (context, state) {
          if (state is CardListError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: NotificationListener<ScrollNotification>(
          onNotification: (notification) => _onScrollNotification(context, notification),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                title: const Text('PokemonTCG Explorer'),
                actions: [
                  IconButton(
                    onPressed: () => context.read<CardListBloc>().add(const RefreshCards()),
                    icon: const Icon(Icons.refresh),
                  ),
                ],
              ),
              const SliverToBoxAdapter(child: SearchBarWidget()),
              BlocBuilder<CardSearchBloc, CardSearchState>(
                builder: (context, searchState) {
                  if (searchState is CardSearchLoading) {
                    return const SliverToBoxAdapter(child: LoadingShimmer());
                  }
                  if (searchState is CardSearchSuccess) {
                    return CardGrid(cards: searchState.cards);
                  }
                  if (searchState is CardSearchEmpty) {
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: EmptyStateWidget(
                        title: 'No Pokemon found',
                        subtitle: 'No results for "${searchState.query}".',
                      ),
                    );
                  }
                  if (searchState is CardSearchError) {
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(child: Text(searchState.message)),
                    );
                  }

                  return BlocBuilder<CardListBloc, CardListState>(
                    buildWhen: _buildWhen,
                    builder: (context, state) {
                      if (state is CardListInitial || state is CardListLoading) {
                        return const SliverToBoxAdapter(child: LoadingShimmer());
                      }

                      if (state is CardListError) {
                        return SliverFillRemaining(
                          hasScrollBody: false,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(state.message),
                                const SizedBox(height: 8),
                                FilledButton(
                                  onPressed: () {
                                    final event = context.read<CardListBloc>().lastEvent;
                                    context.read<CardListBloc>().add(event);
                                  },
                                  child: const Text('Retry'),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      if (state is CardListSuccess || state is CardListLoadingMore) {
                        final cards = state is CardListSuccess ? state.cards : (state as CardListLoadingMore).cards;
                        if (cards.isEmpty) {
                          return const SliverFillRemaining(
                            hasScrollBody: false,
                            child: EmptyStateWidget(),
                          );
                        }
                        return SliverMainAxisGroup(
                          slivers: [
                            CardGrid(cards: cards),
                            if (state is CardListLoadingMore)
                              const SliverToBoxAdapter(child: PaginationLoader()),
                          ],
                        );
                      }

                      return const SliverFillRemaining(
                        hasScrollBody: false,
                        child: EmptyStateWidget(),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
