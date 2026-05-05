import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/attack.dart';

part 'attack_model.g.dart';

@JsonSerializable()
class AttackModel extends Attack {
  const AttackModel({
    required super.name,
    required super.cost,
    required super.convertedEnergyCost,
    required super.damage,
    required super.text,
  });

  factory AttackModel.fromJson(Map<String, dynamic> json) => _$AttackModelFromJson(json);

  Map<String, dynamic> toJson() => _$AttackModelToJson(this);
}
