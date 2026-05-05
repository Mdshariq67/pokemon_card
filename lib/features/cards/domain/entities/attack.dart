import 'package:equatable/equatable.dart';

class Attack extends Equatable {
  const Attack({
    required this.name,
    required this.cost,
    required this.convertedEnergyCost,
    required this.damage,
    required this.text,
  });

  final String name;
  final List<String> cost;
  final int convertedEnergyCost;
  final String damage;
  final String text;

  @override
  List<Object?> get props => [name, cost, convertedEnergyCost, damage, text];
}
