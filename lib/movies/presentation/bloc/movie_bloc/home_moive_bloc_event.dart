import 'package:equatable/equatable.dart';

abstract class HomeMovieEvent extends Equatable {
  const HomeMovieEvent();

  @override
  List<Object> get props => [];
}

class GetNowPlayingEvent extends HomeMovieEvent {
  final bool loadMore;

  const GetNowPlayingEvent({this.loadMore = false});
}

class GetPopularEvent extends HomeMovieEvent {
  final bool loadMore;

  const GetPopularEvent({this.loadMore = false});
}

class GetTopRatedEvent extends HomeMovieEvent {
  final bool loadMore;

  const GetTopRatedEvent({this.loadMore = false});
}
