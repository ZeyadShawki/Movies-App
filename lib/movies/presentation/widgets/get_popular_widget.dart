import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies/presentation/widgets/dashboard_error_widget.dart';

import '../../../core/utils/enum_movie_state.dart';
import '../bloc/movie_bloc/home_moive_bloc.dart';
import '../bloc/movie_bloc/home_moive_bloc_event.dart';
import '../bloc/movie_bloc/home_moive_bloc_state.dart';
import 'mini_list_view_item_widget.dart';

class GetPopularListViewWidget extends StatefulWidget {
  const GetPopularListViewWidget({super.key});

  @override
  State<GetPopularListViewWidget> createState() =>
      _GetPopularListViewWidgetState();
}

class _GetPopularListViewWidgetState extends State<GetPopularListViewWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.positions.first.pixels >=
            _scrollController.positions.first.maxScrollExtent * 0.9 &&
        !_scrollController.positions.first.outOfRange &&
        context.read<HomeMovieBloc>().state.popularState !=
            RequestState.isLoading) {
      context.read<HomeMovieBloc>().add(GetPopularEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeMovieBloc, HomeMovieState>(
      bloc: context.read<HomeMovieBloc>(),
      buildWhen: (previous, current) =>
          previous.popularState != current.popularState,
      listener: (context, state) {},
      builder: (context, state) {
        if (state.popularMovie.isNotEmpty) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.3,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                if (index == state.popularMovie.length - 1) {
                  return state.popularState == RequestState.isLoading
                      ? Row(
                          children: [
                            MiniItemWidget(movie: state.popularMovie[index]),
                            const SizedBox(
                              width: 50,
                              child: Center(child: CircularProgressIndicator()),
                            ),
                          ],
                        )
                      : MiniItemWidget(movie: state.popularMovie[index]);
                }
                return MiniItemWidget(movie: state.popularMovie[index]);
              },
              itemCount: state.popularMovie.length,
              separatorBuilder: (context, index) {
                return const SizedBox(
                  width: 10,
                );
              },
            ),
          );
        } else if (state.popularState == RequestState.isError) {
          return DashBoardErrorWidget(
            message: state.nowPlayingMessage,
            fun: () {
              context.read<HomeMovieBloc>().add(GetPopularEvent());
            },
          );
        } else {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
