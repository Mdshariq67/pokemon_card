import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/resistance.dart';

part 'resistance_model.g.dart';

@JsonSerializable()
class ResistanceModel extends Resistance {
  const ResistanceModel({
    required super.type,
    required super.value,
  });

  factory ResistanceModel.fromJson(Map<String, dynamic> json) =>
      _$ResistanceModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResistanceModelToJson(this);
}
