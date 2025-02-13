import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies/presentation/widgets/dashboard_error_widget.dart';

import '../../../core/utils/enum_movie_state.dart';
import '../bloc/movie_bloc/home_moive_bloc.dart';
import '../bloc/movie_bloc/home_moive_bloc_event.dart';
import '../bloc/movie_bloc/home_moive_bloc_state.dart';
import 'mini_list_view_item_widget.dart';

class GetTopRatedListViewWidget extends StatefulWidget {
  const GetTopRatedListViewWidget({super.key});

  @override
  State<GetTopRatedListViewWidget> createState() =>
      _GetTopRatedListViewWidgetState();
}

class _GetTopRatedListViewWidgetState extends State<GetTopRatedListViewWidget> {
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
        context.read<HomeMovieBloc>().state.topRatedState !=
            RequestState.isLoading) {
      context.read<HomeMovieBloc>().add(GetTopRatedEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeMovieBloc, HomeMovieState>(
      bloc: context.read<HomeMovieBloc>(),
      buildWhen: (previous, current) =>
          previous.topRatedState != current.topRatedState,
      listener: (context, state) {},
      builder: (context, state) {
        if (state.topRatedMovie.isNotEmpty) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.3,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                if (index == state.topRatedMovie.length - 1) {
                  return state.popularState == RequestState.isLoading
                      ? Row(
                          children: [
                            MiniItemWidget(movie: state.topRatedMovie[index]),
                            const SizedBox(
                              width: 50,
                              child: Center(child: CircularProgressIndicator()),
                            ),
                          ],
                        )
                      : MiniItemWidget(movie: state.topRatedMovie[index]);
                }
                return MiniItemWidget(movie: state.topRatedMovie[index]);
              },
              itemCount: state.topRatedMovie.length,
              separatorBuilder: (context, index) {
                return const SizedBox(
                  width: 10,
                );
              },
            ),
          );
        } else if (state.topRatedState == RequestState.isError) {
          return DashBoardErrorWidget(
            message: state.nowPlayingMessage,
            fun: () {
              context.read<HomeMovieBloc>().add(GetTopRatedEvent());
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
