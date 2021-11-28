import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_movie/bloc/favorites/favorites_cubit.dart';
import 'package:i_movie/data/models/movie.dart';
import 'package:i_movie/data/repositories/favorites_repository.dart';
import 'package:i_movie/presentation/core/locator.dart';
import 'package:i_movie/presentation/search/widgets/wide_movie_card.dart';

import 'search_movie_results.dart';

class WideMovieCardList extends StatelessWidget {
  const WideMovieCardList({Key? key, required this.movieList})
      : super(key: key);

  final List<Movie> movieList;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Padding(
          padding: EdgeInsets.only(bottom: 14.h),
          child: InkWell(
            onTap: () => _onTap(context, index),
            child: WideMovieCard(
              movie: Movie(
                name: movieList[index].name,
                imageUrl: movieList[index].imageUrl,
                genre: movieList[index].genre,
                imdb: movieList[index].imdb,
                date: movieList[index].date,
                story: movieList[index].story,
                runtime: movieList[index].runtime,
              ),
            ),
          ),
        ),
        childCount: movieList.length,
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            SearchMovieResults(
          movieList: movieList,
          pageController: PageController(initialPage: index),
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }
}
