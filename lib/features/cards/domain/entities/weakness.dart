import 'package:equatable/equatable.dart';

class Weakness extends Equatable {
  const Weakness({
    required this.type,
    required this.value,
  });

  final String type;
  final String value;

  @override
  List<Object?> get props => [type, value];
}
