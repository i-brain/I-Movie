import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:i_movie/bloc/search/search_movie_cubit.dart';
import 'package:i_movie/data/models/movie.dart';
import 'package:i_movie/presentation/search/widgets/search_bar.dart';
import 'package:i_movie/presentation/search/widgets/initial_search_list.dart';
import 'package:i_movie/presentation/search/widgets/movie_not_found.dart';
import 'package:i_movie/presentation/search/widgets/wide_card_loading.dart';
import 'package:i_movie/presentation/search/widgets/wide_movie_card_list.dart';
import 'package:i_movie/presentation/widgets/no_internet_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin {
  final ValueNotifier<String> _searchKey = ValueNotifier('');

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: DefaultTextStyle(
          style: const TextStyle(color: Colors.white),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                leadingWidth: 0,
                title: const Text('Search'),
                actions: [
                  IconButton(
                      onPressed: () async {
                        _searchKey.value = (await showSearch<String>(
                          context: context,
                          delegate: CustomSearchDelegate(
                              cubit: context.read<SearchMovieCubit>()),
                        ))!;
                      },
                      icon: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ))
                ],
                floating: true,
                backgroundColor: Colors.black,
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(6.0.w),
                  child: ValueListenableBuilder<String>(
                      valueListenable: _searchKey,
                      builder: (context, value, child) {
                        return RichText(
                          text: TextSpan(
                            style:
                                TextStyle(color: Colors.grey, fontSize: 18.sp),
                            children: <TextSpan>[
                              TextSpan(
                                text: _searchKey.value.isEmpty
                                    ? ''
                                    : 'Searching results for ',
                              ),
                              TextSpan(
                                text: _searchKey.value,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 20.sp),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ),
              BlocBuilder<SearchMovieCubit, SearchMovieState>(
                builder: (context, state) {
                  print(state);
                  if (state is SearchMovieSucces) {
                    List<Movie> list = [];
                    list.add(state.movie);

                    return WideMovieCardList(
                      movieList: list,
                    );
                  }
                  if (state is SearchMovieError) {
                    return const SliverToBoxAdapter(
                      child: NoInternetWidget(),
                    );
                  }

                  if (state is SearchMovieNotFound) {
                    return const MovieNotFound();
                  }

                  if (state is SearchMovieLoading) {
                    return const WideCardLoading();
                  }

                  return const InitialSearchList();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
