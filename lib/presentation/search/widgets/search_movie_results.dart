import 'package:flutter/material.dart';
import 'package:i_movie/data/models/movie.dart';
import 'package:i_movie/presentation/home/widgets/tik_tok_widget.dart';

class SearchMovieResults extends StatelessWidget {
  const SearchMovieResults({
    Key? key,
    required this.movieList,
    required this.pageController,
  }) : super(key: key);

  final List<Movie> movieList;

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Search Results'),
      ),
      body: PageView.builder(
        controller: pageController,
        itemCount: movieList.length,
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return GestureDetector(
            onHorizontalDragEnd: (details) {
              if (!details.primaryVelocity!.isNegative) {
                Navigator.pop(context);
              }
            },
            child: TikTokWidget(
              movie: movieList[index],
            ),
          );
        },
      ),
    );
  }
}
