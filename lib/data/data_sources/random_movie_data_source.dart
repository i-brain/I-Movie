import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:i_movie/presentation/core/const.dart';
import 'package:i_movie/data/models/movie.dart';
import 'package:i_movie/presentation/core/locator.dart';
import 'package:multiple_result/multiple_result.dart';

import 'search_movie_data_source.dart';

class RandomMovieDataSource {
  Future<List<Movie>> fetchMovieList() async {
    List<Movie> _list = [];

    var searchDataSource = getIt<SearchMovieDataSource>();

    var response = await http
        .get(Uri.parse(randomMoviesApi + Random().nextInt(220).toString()));

    var result = (jsonDecode(response.body) as Map<String, dynamic>)['results'];

    for (int i = 0; i < result.length / 2; i++) {
      Result<void, Movie> movie = await searchDataSource
          .findInfoAboutMovie(result[i]['original_title']);

      if (movie.isSuccess()) {
        _list.add(movie.getSuccess()!);
      }
    }

    return _list;
  }
}
