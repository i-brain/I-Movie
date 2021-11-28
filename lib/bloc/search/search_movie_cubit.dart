import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:i_movie/data/models/movie.dart';
import 'package:i_movie/data/repositories/search_movie_repository.dart';

part 'search_movie_state.dart';

class SearchMovieCubit extends Cubit<SearchMovieState> {
  SearchMovieCubit({
    required this.searchMovieRepository,
  }) : super(SearchMovieInitial());

  final SearchMovieRepository searchMovieRepository;

  Future<void> searchMovie(String movieTitle) async {
    emit(SearchMovieLoading());
    var movieOrError = await searchMovieRepository.searchMovie(movieTitle);

    if (movieOrError.isSuccess()) {
      emit(
        SearchMovieSucces(
          movie: movieOrError.getSuccess()!,
        ),
      );
    } else {
      if (movieOrError.getError()!.isEmpty) {
        emit(
          SearchMovieNotFound(
            searchedWord: movieTitle,
          ),
        );
      } else {
        emit(
          SearchMovieError(
            errorMessage: movieOrError.getError()!,
          ),
        );
      }
    }
  }
}
