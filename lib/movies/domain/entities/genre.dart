import 'package:equatable/equatable.dart';

class Genre extends Equatable {
  final String name;
  final int id;

  const Genre({
   required this.name,
   required this.id});

  @override
  List<Object> get props => [name, id];
}