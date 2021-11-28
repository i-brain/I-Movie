import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:i_movie/data/models/movie.dart';
import 'package:i_movie/data/repositories/random_movie_repository.dart';

part 'random_movie_state.dart';

class RandomMovieCubit extends Cubit<RandomMovieState> {
  RandomMovieCubit({
    required this.movieRepository,
  }) : super(RandomMovieInitial());

  final RandomMovieRepository movieRepository;

  List<Movie> movieList = [];

  Future<void> fetchMovies() async {
    movieList.clear();
    emit(RandomMovieLoading());
    var listOrException = await movieRepository.getRandomMovieList();
    if (listOrException.isSuccess()) {
      movieList.addAll(listOrException.getSuccess()!.toList());
      emit(RandomMovieSuccess(movieList: movieList));
    } else {
      emit(RandomMovieError(
          errorMessage: listOrException.getError().toString()));
    }
  }

  Future<void> fetchNextMovies() async {
    emit(RandomMovieSuccess(movieList: movieList, isNextMoviesFetching: true));
    var listOrException = await movieRepository.getRandomMovieList();
    if (listOrException.isSuccess()) {
      movieList.addAll(
        listOrException.getSuccess()!.toList(),
      );
      emit(
        RandomMovieSuccess(
          movieList: movieList,
          isNextMoviesFetching: false,
        ),
      );
    } else {
      emit(
        RandomMovieSuccess(
          movieList: movieList,
          isNextMoviesFetching: false,
          fetchingNextMoviesFailed: true,
        ),
      );
    }
  }
}
