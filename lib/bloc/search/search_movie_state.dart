part of 'search_movie_cubit.dart';

abstract class SearchMovieState extends Equatable {
  const SearchMovieState();

  @override
  List<Object> get props => [];
}

class SearchMovieInitial extends SearchMovieState {}

class SearchMovieSucces extends SearchMovieState {
  final Movie movie;

  const SearchMovieSucces({
    required this.movie,
  });

  @override
  List<Object> get props => [movie];
}

class SearchMovieLoading extends SearchMovieState {}

class SearchMovieNotFound extends SearchMovieState {
  final String searchedWord;

  const SearchMovieNotFound({
    required this.searchedWord,
  });
  @override
  List<Object> get props => [searchedWord];
}

class SearchMovieError extends SearchMovieState {
  final String errorMessage;

  const SearchMovieError({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];
}
