import 'package:i_movie/data/contarctors/i_search_movie_repository.dart';
import 'package:i_movie/data/data_sources/search_movie_data_source.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:i_movie/data/models/movie.dart';

import '../../presentation/core/locator.dart';

class SearchMovieRepository implements ISearchMovieRepository {
  var dataSource = getIt<SearchMovieDataSource>();

  @override
  Future<Result<String, Movie>> searchMovie(String movieTitle) async {
    var movieOrException = await dataSource.findInfoAboutMovie(movieTitle);

    if (movieOrException.isSuccess()) {
      return Success(movieOrException.getSuccess()!);
    }

    return Error(movieOrException.getError()!);
  }
}
