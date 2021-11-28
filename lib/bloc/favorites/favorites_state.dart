part of 'favorites_cubit.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

class FavoritesInitial extends FavoritesState {}

class FavoritesSuccess extends FavoritesState {
  final List<Movie> list;

  final bool isNextMoviesFetching;

  final int favoritesCount;

  final bool fetchingNextFavoritesFailed;

  const FavoritesSuccess({
    required this.list,
    this.isNextMoviesFetching = false,
    required this.favoritesCount,
    this.fetchingNextFavoritesFailed = false,
  });

  @override
  List<Object> get props => [list, isNextMoviesFetching];
}

class FavoritesLoading extends FavoritesState {}

class FavoritesError extends FavoritesState {
  final String errorMessage;

  const FavoritesError({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];
}
