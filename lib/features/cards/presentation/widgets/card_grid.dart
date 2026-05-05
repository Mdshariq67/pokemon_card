import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/pokemon_card.dart';
import 'card_grid_item.dart';

class CardGrid extends StatelessWidget {
  const CardGrid({
    super.key,
    required this.cards,
  });

  final List<PokemonCard> cards;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverGrid.builder(
        itemCount: cards.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.72,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
        ),
        itemBuilder: (context, index) {
          final card = cards[index];
          return CardGridItem(
            card: card,
            onTap: () => GoRouter.of(context).push('/card/${card.id}', extra: card),
          );
        },
      ),
    );
  }
}
