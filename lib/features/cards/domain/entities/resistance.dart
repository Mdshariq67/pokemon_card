import 'package:equatable/equatable.dart';

class Resistance extends Equatable {
  const Resistance({
    required this.type,
    required this.value,
  });

  final String type;
  final String value;

  @override
  List<Object?> get props => [type, value];
}
