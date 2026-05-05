import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/pokemon_card.dart';

class CardDetailPage extends StatelessWidget {
  const CardDetailPage({super.key, required this.card});

  final PokemonCard card;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 400,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(card.name),
              background: CachedNetworkImage(
                imageUrl: card.imageUrlLarge,
                fit: BoxFit.fill,
                errorWidget: (_, __, ___) => const ColoredBox(
                  color: Colors.black12,
                  child: Center(child: Icon(Icons.broken_image_outlined)),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    card.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text('${card.set.name} • ${card.set.series}'),
                  const SizedBox(height: 4),
                  Text('HP: ${card.hp}'),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: card.types
                        .map((type) => Chip(label: Text(type)))
                        .toList(growable: false),
                  ),
                  const SizedBox(height: 8),
                  Text('Supertype: ${card.supertype}'),
                  const SizedBox(height: 4),
                  Text(
                    'Rarity: ${card.rarity.isEmpty ? 'Unknown' : card.rarity}',
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Artist: ${card.artist.isEmpty ? 'Unknown' : card.artist}',
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Attacks',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  if (card.attacks.isEmpty)
                    const Text('No attacks available')
                  else
                    ...card.attacks.map(
                      (attack) => Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${attack.name} ${attack.damage}'.trim(),
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 6,
                                runSpacing: 6,
                                children: attack.cost
                                    .map((cost) => Chip(label: Text(cost)))
                                    .toList(growable: false),
                              ),
                              const SizedBox(height: 8),
                              Text(attack.text.isEmpty ? '-' : attack.text),
                            ],
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),
                  Text(
                    'Weaknesses',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  if (card.weaknesses.isEmpty)
                    const Text('No weaknesses available')
                  else
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: card.weaknesses
                          .map(
                            (w) => Chip(
                              label: Text('${w.type} ${w.value}'),
                              backgroundColor: Colors.red.shade50,
                            ),
                          )
                          .toList(growable: false),
                    ),
                  const SizedBox(height: 20),
                  Text(
                    'Resistances',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  if (card.resistances.isEmpty)
                    const Text('No resistances available')
                  else
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: card.resistances
                          .map(
                            (r) => Chip(
                              label: Text('${r.type} ${r.value}'),
                              backgroundColor: Colors.green.shade50,
                            ),
                          )
                          .toList(growable: false),
                    ),
                  const SizedBox(height: 20),
                  Text(
                    'Retreat Cost',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  if (card.retreatCost.isEmpty)
                    const Text('No retreat cost')
                  else
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: card.retreatCost
                          .map((cost) => Chip(label: Text(cost)))
                          .toList(growable: false),
                    ),
                  const SizedBox(height: 6),
                  Text('Converted retreat cost: ${card.convertedRetreatCost}'),
                  const SizedBox(height: 20),
                  Text('Set', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          CachedNetworkImage(
                            imageUrl: card.set.logoUrl,
                            width: 80,
                            height: 40,
                            fit: BoxFit.contain,
                            errorWidget: (_, __, ___) =>
                                const SizedBox.shrink(),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  card.set.name,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                const SizedBox(height: 4),
                                Text('Release: ${card.set.releaseDate}'),
                                Text('Printed total: ${card.set.printedTotal}'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
