part of 'random_movie_cubit.dart';

abstract class RandomMovieState extends Equatable {
  const RandomMovieState();

  @override
  List<Object> get props => [];
}

class RandomMovieInitial extends RandomMovieState {}

class RandomMovieSuccess extends RandomMovieState {
  const RandomMovieSuccess({
    required this.movieList,
    this.isNextMoviesFetching = false,
    this.fetchingNextMoviesFailed = false,
  });

  final List<Movie> movieList;
  final bool isNextMoviesFetching;

  final bool fetchingNextMoviesFailed;

  @override
  List<Object> get props => [
        movieList,
        isNextMoviesFetching,
        fetchingNextMoviesFailed,
      ];
}

class RandomMovieLoading extends RandomMovieState {}

class RandomMovieError extends RandomMovieState {
  const RandomMovieError({
    this.errorMessage = 'Unknown error happened.',
  });

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
