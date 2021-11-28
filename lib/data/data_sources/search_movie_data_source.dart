import 'dart:convert';
import 'dart:io';

import 'package:i_movie/presentation/core/const.dart';
import 'package:i_movie/data/models/movie.dart';
import 'package:http/http.dart' as http;
import 'package:multiple_result/multiple_result.dart';

class SearchMovieDataSource {
  Future<Result<String, Movie>> findInfoAboutMovie(String movieTitle) async {
    try {
      var response = await http.get(Uri.parse(searchMovieApi + movieTitle));

      var result = jsonDecode(response.body) as Map<String, dynamic>;

      if (result['Title'] != null) {
        return Success(Movie.fromApiJson(result));
      }
    } on SocketException {
      return const Error('No Internet Connection');
    }

    return const Error('');
  }
}
