import 'package:i_movie/data/models/movie.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class ISearchMovieRepository {
  Future<Result<String, Movie>> searchMovie(String movieTitle);
}
