part of 'search_for_movie_cubit.dart';

 class SearchForMovieState extends Equatable {
  final RequestState searchState;
  final String searchMessage;
  final List<Movie> searchList;
  final Map<String,dynamic> query;

  const SearchForMovieState({ 
     this.query=const {},
    this.searchState = RequestState
      .isLoading, this.searchMessage = '', this.searchList = const []});


  SearchForMovieState copyWith({
    RequestState? searchState,
    String? searchMessage,
    List<Movie>? searchList,    Map<String,dynamic>? query,

  }) {
    return SearchForMovieState(
              query: query ?? this.query,

        searchState: searchState ?? this.searchState,
        searchMessage: searchMessage ?? this.searchMessage,
        searchList: searchList ?? this.searchList);
  }

  @override
  List<Object> get props => [query,searchState, searchMessage, searchList];
}
