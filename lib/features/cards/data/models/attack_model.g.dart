// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attack_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttackModel _$AttackModelFromJson(Map<String, dynamic> json) => AttackModel(
  name: json['name'] as String,
  cost: (json['cost'] as List<dynamic>).map((e) => e as String).toList(),
  convertedEnergyCost: (json['convertedEnergyCost'] as num).toInt(),
  damage: json['damage'] as String,
  text: json['text'] as String,
);

Map<String, dynamic> _$AttackModelToJson(AttackModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'cost': instance.cost,
      'convertedEnergyCost': instance.convertedEnergyCost,
      'damage': instance.damage,
      'text': instance.text,
    };
