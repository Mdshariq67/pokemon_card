import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/weakness.dart';

part 'weakness_model.g.dart';

@JsonSerializable()
class WeaknessModel extends Weakness {
  const WeaknessModel({
    required super.type,
    required super.value,
  });

  factory WeaknessModel.fromJson(Map<String, dynamic> json) => _$WeaknessModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeaknessModelToJson(this);
}
