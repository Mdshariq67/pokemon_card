import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/cards/domain/entities/pokemon_card.dart';
import '../../features/cards/presentation/bloc/card_list/card_list_bloc.dart';
import '../../features/cards/presentation/bloc/card_list/card_list_event.dart';
import '../../features/cards/presentation/bloc/card_search/card_search_bloc.dart';
import '../../features/cards/presentation/pages/card_detail_page.dart';
import '../../features/cards/presentation/pages/card_list_page.dart';
import '../di/injection_container.dart';

final GoRouter goRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider<CardListBloc>(
            create: (_) => sl<CardListBloc>()..add(const LoadCards()),
          ),
          BlocProvider<CardSearchBloc>(create: (_) => sl<CardSearchBloc>()),
        ],
        child: const CardListPage(),
      ),
    ),
    GoRoute(
      path: '/card/:id',
      builder: (context, state) {
        final card = state.extra as PokemonCard?;
        if (card == null) {
          return const Scaffold(
            body: Center(child: Text('Card not found')),
          );
        }
        return CardDetailPage(card: card);
      },
    ),
  ],
);
