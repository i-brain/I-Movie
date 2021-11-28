import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:i_movie/bloc/random_movie/random_movie_cubit.dart';
import 'package:i_movie/presentation/widgets/no_internet_widget.dart';
import 'package:i_movie/presentation/widgets/refresh_button.dart';

import 'wide_movie_card_list.dart';

class InitialSearchList extends StatelessWidget {
  const InitialSearchList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<RandomMovieCubit, RandomMovieState>(
      builder: (context, state) {
        if (state is RandomMovieSuccess) {
          return WideMovieCardList(
            movieList: state.movieList,
          );
        }
        if (state is RandomMovieError) {
          return SliverToBoxAdapter(
            child: SizedBox(
              height: (size.height * 0.7),
              child: Center(
                child: Column(
                  children: [
                    const NoInternetWidget(),
                    RefreshButton(
                        onPressed:
                            context.read<RandomMovieCubit>().fetchMovies),
                  ],
                ),
              ),
            ),
          );
        }
        return SliverToBoxAdapter(
          child: SizedBox(
            height: size.height * 0.7,
            child: const Center(
              child: SpinKitDoubleBounce(
                color: Colors.orange,
              ),
            ),
          ),
        );
      },
    );
  }
}
