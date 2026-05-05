import 'package:equatable/equatable.dart';

import 'attack.dart';
import 'resistance.dart';
import 'weakness.dart';

class CardSet extends Equatable {
  const CardSet({
    required this.id,
    required this.name,
    required this.series,
    required this.printedTotal,
    required this.releaseDate,
    required this.logoUrl,
  });

  final String id;
  final String name;
  final String series;
  final int printedTotal;
  final String releaseDate;
  final String logoUrl;

  @override
  List<Object?> get props => [id, name, series, printedTotal, releaseDate, logoUrl];
}

class PokemonCard extends Equatable {
  const PokemonCard({
    required this.id,
    required this.name,
    required this.supertype,
    required this.subtypes,
    required this.hp,
    required this.types,
    required this.attacks,
    required this.weaknesses,
    required this.resistances,
    required this.retreatCost,
    required this.convertedRetreatCost,
    required this.set,
    required this.artist,
    required this.rarity,
    required this.imageUrlSmall,
    required this.imageUrlLarge,
  });

  final String id;
  final String name;
  final String supertype;
  final List<String> subtypes;
  final String hp;
  final List<String> types;
  final List<Attack> attacks;
  final List<Weakness> weaknesses;
  final List<Resistance> resistances;
  final List<String> retreatCost;
  final int convertedRetreatCost;
  final CardSet set;
  final String artist;
  final String rarity;
  final String imageUrlSmall;
  final String imageUrlLarge;

  @override
  List<Object?> get props => [
        id,
        name,
        supertype,
        subtypes,
        hp,
        types,
        attacks,
        weaknesses,
        resistances,
        retreatCost,
        convertedRetreatCost,
        set,
        artist,
        rarity,
        imageUrlSmall,
        imageUrlLarge,
      ];
}
