import 'package:i_movie/data/contarctors/i_favorites_repository.dart';
import 'package:i_movie/data/data_sources/favorites_data_source.dart';
import 'package:i_movie/data/models/movie.dart';
import 'package:multiple_result/multiple_result.dart';

class FavoritesRepository implements IFavoritesRepository {
  final _dataSource = FavoritesDataSource();

  @override
  Future<Result<String, List<Movie>>> fetchFavoriteMovies(
      {bool isFetchingNextFavorites = false}) async {
    try {
      final List<Movie> movieList =
          await _dataSource.fetchFavoritesFromFirestore(
              isFetchingNextFavorites: isFetchingNextFavorites);

      return Success(movieList);
    } catch (error) {
      return Error(error.toString());
    }
  }

  Future<int> getFavoritesCount() async {
    return _dataSource.getFavoriteMoviesCount();
  }
}
