import 'package:equatable/equatable.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class GetNowPlayingEvent extends MovieEvent {
  final bool loadMore;

  const GetNowPlayingEvent({this.loadMore = false});
}

class GetPopularEvent extends MovieEvent {
  final bool loadMore;

  const GetPopularEvent({this.loadMore = false});
}

class GetTopRatedEvent extends MovieEvent {
  final bool loadMore;

  const GetTopRatedEvent({this.loadMore = false});
}
