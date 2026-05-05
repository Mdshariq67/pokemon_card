import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/pokemon_card.dart';
import 'attack_model.dart';
import 'resistance_model.dart';
import 'weakness_model.dart';

part 'card_model.g.dart';

@JsonSerializable(createFactory: false, createToJson: false)
class CardModel extends PokemonCard {
  const CardModel({
    required super.id,
    required super.name,
    required super.supertype,
    required super.subtypes,
    required super.hp,
    required super.types,
    required List<AttackModel> super.attacks,
    required List<WeaknessModel> super.weaknesses,
    required List<ResistanceModel> super.resistances,
    required super.retreatCost,
    required super.convertedRetreatCost,
    required CardSetModel super.set,
    required super.artist,
    required super.rarity,
    required super.imageUrlSmall,
    required super.imageUrlLarge,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    final images = (json['images'] as Map<String, dynamic>?) ?? const <String, dynamic>{};
    final setMap = (json['set'] as Map<String, dynamic>?) ?? const <String, dynamic>{};
    final setImages = (setMap['images'] as Map<String, dynamic>?) ?? const <String, dynamic>{};

    return CardModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      supertype: json['supertype'] as String? ?? '',
      subtypes: (json['subtypes'] as List<dynamic>? ?? const <dynamic>[])
          .map((e) => e.toString())
          .toList(growable: false),
      hp: json['hp']?.toString() ?? '',
      types: (json['types'] as List<dynamic>? ?? const <dynamic>[])
          .map((e) => e.toString())
          .toList(growable: false),
      attacks: (json['attacks'] as List<dynamic>? ?? const <dynamic>[])
          .map((e) => AttackModel.fromJson(e as Map<String, dynamic>))
          .toList(growable: false),
      weaknesses: (json['weaknesses'] as List<dynamic>? ?? const <dynamic>[])
          .map((e) => WeaknessModel.fromJson(e as Map<String, dynamic>))
          .toList(growable: false),
      resistances: (json['resistances'] as List<dynamic>? ?? const <dynamic>[])
          .map((e) => ResistanceModel.fromJson(e as Map<String, dynamic>))
          .toList(growable: false),
      retreatCost: (json['retreatCost'] as List<dynamic>? ?? const <dynamic>[])
          .map((e) => e.toString())
          .toList(growable: false),
      convertedRetreatCost: (json['convertedRetreatCost'] as num?)?.toInt() ?? 0,
      set: CardSetModel.fromJson(
        <String, dynamic>{
          ...setMap,
          'logoUrl': setImages['logo'] ?? '',
        },
      ),
      artist: json['artist'] as String? ?? '',
      rarity: json['rarity'] as String? ?? '',
      imageUrlSmall: images['small'] as String? ?? '',
      imageUrlLarge: images['large'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'supertype': supertype,
      };
}

@JsonSerializable()
class CardSetModel extends CardSet {
  const CardSetModel({
    required super.id,
    required super.name,
    required super.series,
    required super.printedTotal,
    required super.releaseDate,
    required super.logoUrl,
  });

  factory CardSetModel.fromJson(Map<String, dynamic> json) => _$CardSetModelFromJson(json);

  Map<String, dynamic> toJson() => _$CardSetModelToJson(this);
}
