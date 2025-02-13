import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/utils/enum_movie_state.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/usecase/search_for_movie_use_case.dart';

part 'search_for_movie_state.dart';

@injectable
class SearchForMovieCubit extends Cubit<SearchForMovieState> {
  final SearchForMovieUseCase searchForMovieUseCase;
  SearchForMovieCubit(this.searchForMovieUseCase)
      : super(const SearchForMovieState());

  int page = 1;

  void searchForMovie({required Map<String, dynamic> query}) async {
    if (state.query['query'] == '') return;

    if (jsonEncode(state.query) != jsonEncode(query)) {
      page = 1;

      emit(state.copyWith(searchState: RequestState.isLoading, searchList: []));
    } else {
      emit(state.copyWith(
        searchState: RequestState.isLoading,
      ));
    }

    final result = await searchForMovieUseCase({
      ...query,
      'page': page++,
    });
    result.fold((l) {
      emit(state.copyWith(
          searchMessage: l.message, searchState: RequestState.isError));
    }, (r) {
      emit(state.copyWith(
          query: query,
          searchList: [...state.searchList, ...r],
          searchState: RequestState.isLoaded));
    });
  }
}
