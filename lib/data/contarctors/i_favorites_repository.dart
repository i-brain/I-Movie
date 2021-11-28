import 'package:i_movie/data/models/movie.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class IFavoritesRepository {
  Future<Result<String, List<Movie>>> fetchFavoriteMovies();
}
