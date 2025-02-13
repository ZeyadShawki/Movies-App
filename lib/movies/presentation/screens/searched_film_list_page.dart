import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/movies/presentation/widgets/dashboard_error_widget.dart';

import '../../../core/app-router/app_router.gr.dart';
import '../../../core/asset_manger/app_string.dart';
import '../../../core/helpers/di/dependency_config.dart';
import '../../../core/helpers/extensions/screen_util_extension.dart';
import '../../../core/helpers/extensions/string_extensions.dart';
import '../../../core/network/api_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/enum_movie_state.dart';
import '../../domain/entities/movie.dart';
import '../bloc/search_cubit/search_for_movie_cubit.dart';
import '../widgets/image_loading_error_widget.dart';
import '../widgets/query_sheet_picker.dart';
import 'film_details_viewer.dart';

@RoutePage()
class SearchedFilmListPage extends StatefulWidget {
  const SearchedFilmListPage({super.key});

  @override
  State<SearchedFilmListPage> createState() => _SearchedFilmListPageState();
}

class _SearchedFilmListPageState extends State<SearchedFilmListPage>
    with FilmDetailsViewer<SearchedFilmListPage> {
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  final searchCubit = getIt<SearchForMovieCubit>();
  Timer? _debounce; // Add debounce timer
  Map<String, dynamic> query = {};
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.positions.first.pixels >=
            _scrollController.positions.first.maxScrollExtent &&
        !_scrollController.positions.first.outOfRange &&
        searchCubit.state.searchState != RequestState.isLoading) {
      searchCubit
          .searchForMovie(query: {...query, 'query': _searchController.text});
    }
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (_formkey.currentState!.validate() && value.isNotEmpty) {
        searchCubit
            .searchForMovie(query: {...query, 'query': _searchController.text});
      }
    });
  }

  @override
  Widget screen(BuildContext context) {
    return BlocProvider<SearchForMovieCubit>(
      create: (context) => searchCubit,
      child: BlocConsumer<SearchForMovieCubit, SearchForMovieState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.blackPrimary1,
            appBar: AppBar(
              automaticallyImplyLeading:
                  false, // Disables the default back button

              leading: IconButton(
                icon: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Icon(Icons.arrow_back_ios, color: Colors.white),
                ),
                onPressed: () => context.router.maybePop(),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.filter_list, color: Colors.white),
                  onPressed: () async {
                    final q = await showQueryParamsBottomSheet(context, query);
                    if (q != null) {
                      query = q;
                      searchCubit.searchForMovie(
                          query: {...query, 'query': _searchController.text});
                    }
                  },
                ),
              ],
              backgroundColor: AppColors.blackPrimary1,
              elevation: 0,
              title: Container(
                height: 40.h,
                decoration: BoxDecoration(
                  color: AppColors.blackPrimary2,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  validator: (value) {
                    // ignore: unnecessary_null_comparison
                    if (value!.isEmpty && value != null) {
                      return 'Please type the movie name';
                    } else {
                      return null;
                    }
                  },
                  controller: _searchController,
                  onChanged: (String value) {
                    if (_formkey.currentState!.validate()) {
                      _onSearchChanged(_searchController.text);
                    }
                  },
                  decoration: InputDecoration(
                    hintText: AppStrings.featuredFilms,
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    hintStyle: TextStyle(color: Colors.grey),
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: _formkey,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (state.searchList.isNotEmpty) ...[
                        const SizedBox(
                          height: 20,
                        ),
                        Stack(
                          children: [
                            ListView.separated(
                                shrinkWrap: true,
                                // controller: _scrollController,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return state.searchState ==
                                              RequestState.isLoading &&
                                          index == state.searchList.length - 1
                                      ? Column(
                                          children: [
                                            searchItemWidget(
                                              movie: state.searchList[index],
                                            ),
                                            const SizedBox(
                                              width: 50,
                                              child: Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                            ),
                                          ],
                                        )
                                      : searchItemWidget(
                                          movie: state.searchList[index],
                                        );
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      height: 20,
                                    ),
                                itemCount: state.searchList.length),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 100.h,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      AppColors.blackPrimary1
                                          .withValues(alpha: 1),
                                      AppColors.blackPrimary1
                                          .withValues(alpha: 0),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ] else if (_searchController.text == '')
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.8,
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    (Icons.movie_creation_outlined),
                                    size: 100,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'Start Search',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ))
                      else if (state.searchState == RequestState.isError) ...{
                        DashBoardErrorWidget(
                          message: state.searchMessage,
                          fun: () {
                            searchCubit.searchForMovie(query: {
                              ...query,
                              'query': _searchController.text
                            });
                          },
                        )
                      } else if (state.searchState == RequestState.isLoading &&
                          state.searchList.isNotEmpty) ...{
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.8,
                            child: const Center(
                                child: CircularProgressIndicator()))
                      } else if (state.searchState == RequestState.isLoading &&
                          state.searchList.isEmpty) ...{
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.8,
                            child: const Center(
                                child: CircularProgressIndicator()))
                      }
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget searchItemWidget({
    required Movie movie,
  }) {
    return GestureDetector(
      onLongPress: () => viewFilmDetails(movie: movie),
      onTap: () {
        context.router.push(MovieDetailsRoute(id: movie.id ?? 0));
      },
      child: Container(
        margin: REdgeInsets.only(top: 20),
        padding: REdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 120.h,
                  width: 80.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.r),
                    child: Image.network(
                      ApiConstants().networkimagemaker(movie.posterPath) ==
                              'https://image.tmdb.org/t/p/w500null'
                          ? 'https://img.freepik.com/free-vector/internet-network-warning-404-error-page-file-found-web-page-internet-error-page-issue-found-network-404-error-present-by-man-sleep-display_1150-55450.jpg?w=740&t=st=1663006046~exp=1663006646~hmac=d14191cc254ee49be9fe5a83ede0836c3e8085c67d04be6746f0d1977ce085bb'
                          : ApiConstants().networkimagemaker(movie.posterPath),
                      errorBuilder: (context, error, stackTrace) =>
                          ImageLoadingErrorWidget(),
                    ),
                  ),
                ),
                20.toSizedBox,
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * .5,
                  height: 120.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: (movie.title ?? '').toSubTitle(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      10.toSizedBox,
                      (movie.overview ?? '').toSubTitle(
                        maxLines: 2,
                        fontSize: 14.sp,
                        color: Colors.grey,
                        fontWeight: FontWeight.w300,
                      ),
                      10.toSizedBox,
                      if (movie.releaseDate != null &&
                          movie.releaseDate!.split('-').first != '')
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              color: Colors.grey.withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(5)),
                          child: movie.releaseDate!.split('-').first.toSubTitle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
