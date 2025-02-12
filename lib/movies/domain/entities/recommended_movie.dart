
import 'package:equatable/equatable.dart';

class RecommendedMovie extends Equatable {
 final String? backdropPath;
 final String title;
 final int id;
 final  String overview;
 final String posterPath;

  const RecommendedMovie({
    required this.overview,
    required this.title,
    required this.id,
    required this.backdropPath,
    required this.posterPath,
  });

  @override
  List<Object> get props => [title,id,override,posterPath];
}