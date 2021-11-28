import 'dart:io';

import 'package:i_movie/data/contarctors/i_random_movie_repository.dart';
import 'package:i_movie/data/data_sources/random_movie_data_source.dart';
import 'package:i_movie/data/models/movie.dart';
import 'package:i_movie/presentation/core/locator.dart';
import 'package:multiple_result/multiple_result.dart';

class RandomMovieRepository implements IRandomMovieRepository {
  var dataSource = getIt<RandomMovieDataSource>();

  @override
  Future<Result<String, List<Movie>>> getRandomMovieList() async {
    try {
      final List<Movie> _list = await dataSource.fetchMovieList();

      return Success(_list);
    } on SocketException {
      return const Error('No Internet Connection');
    } catch (_) {
      return const Error('Server Error Happened');
    }
  }
}
