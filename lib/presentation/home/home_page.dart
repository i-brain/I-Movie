import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:i_movie/bloc/random_movie/random_movie_cubit.dart';
import 'package:i_movie/presentation/core/dialogs.dart';

import 'package:i_movie/presentation/home/widgets/tik_tok_widget.dart';
import 'package:i_movie/presentation/widgets/no_internet_widget.dart';
import 'package:i_movie/presentation/widgets/refresh_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: const Text('IMovie'),
      ),
      backgroundColor: Colors.black,
      body: BlocBuilder<RandomMovieCubit, RandomMovieState>(
        builder: (context, state) {
          print(state);
          if (state is RandomMovieSuccess) {
            List<Widget> list = [];

            for (var movie in state.movieList) {
              list.add(TikTokWidget(movie: movie));
            }
            if (state.isNextMoviesFetching) {
              list.add(
                const SpinKitDoubleBounce(
                  color: Colors.pink,
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: context.read<RandomMovieCubit>().fetchMovies,
              child: PageView.builder(
                controller: pageController,
                itemCount: state.movieList.length +
                    (state.isNextMoviesFetching ? 1 : 0),
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (value) {
                  if (value > list.length - 15 &&
                      state.isNextMoviesFetching == false) {
                    print('fetching next movies');
                    context.read<RandomMovieCubit>().fetchNextMovies();
                  }

                  if (value == list.length - 1 &&
                      state.fetchingNextMoviesFailed) {
                    Dialogs.showFlushbar(
                      context: context,
                      message: 'No internet connection',
                      color: Colors.redAccent,
                    );
                  }
                },
                itemBuilder: (context, index) => list[index],
              ),
            );
          }

          if (state is RandomMovieError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const NoInternetWidget(),
                  SizedBox(
                    height: 80.h,
                  ),
                  RefreshButton(
                    onPressed: context.read<RandomMovieCubit>().fetchMovies,
                  ),
                ],
              ),
            );
          }
          return const SpinKitDoubleBounce(
            color: Colors.pink,
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
