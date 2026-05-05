// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardSetModel _$CardSetModelFromJson(Map<String, dynamic> json) => CardSetModel(
  id: json['id'] as String,
  name: json['name'] as String,
  series: json['series'] as String,
  printedTotal: (json['printedTotal'] as num).toInt(),
  releaseDate: json['releaseDate'] as String,
  logoUrl: json['logoUrl'] as String,
);

Map<String, dynamic> _$CardSetModelToJson(CardSetModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'series': instance.series,
      'printedTotal': instance.printedTotal,
      'releaseDate': instance.releaseDate,
      'logoUrl': instance.logoUrl,
    };
