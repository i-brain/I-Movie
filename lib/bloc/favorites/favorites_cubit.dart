import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:i_movie/data/models/movie.dart';
import 'package:i_movie/data/repositories/favorites_repository.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit({
    required this.favoritesRepository,
  }) : super(FavoritesInitial());

  final FavoritesRepository favoritesRepository;

  final List<Movie> _movieList = [];

  int _favoritesCount = 0;

  Future<void> fetchFavorites() async {
    _movieList.clear();

    emit(FavoritesLoading());

    final listOrError = await favoritesRepository.fetchFavoriteMovies();

    _favoritesCount = await favoritesRepository.getFavoritesCount();

    if (listOrError.isSuccess()) {
      _movieList.addAll(listOrError.getSuccess()!);

      emit(
        FavoritesSuccess(
          list: _movieList,
          favoritesCount: _favoritesCount,
        ),
      );
    } else {
      emit(
        FavoritesError(errorMessage: listOrError.getError()!),
      );
    }
  }

  Future<void> fetchNextFavorites() async {
    emit(
      FavoritesSuccess(
          list: _movieList,
          isNextMoviesFetching: true,
          favoritesCount: _favoritesCount),
    );

    final listOrError = await favoritesRepository.fetchFavoriteMovies(
        isFetchingNextFavorites: true);

    if (listOrError.isSuccess()) {
      _movieList.addAll(listOrError.getSuccess()!);
      emit(
        FavoritesSuccess(
          list: _movieList,
          isNextMoviesFetching: false,
          favoritesCount: _favoritesCount,
        ),
      );
    } else {
      emit(
        FavoritesSuccess(
          list: _movieList,
          isNextMoviesFetching: false,
          favoritesCount: _favoritesCount,
          fetchingNextFavoritesFailed: true,
        ),
      );
    }
  }
}
