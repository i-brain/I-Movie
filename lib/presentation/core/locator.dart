import 'package:get_it/get_it.dart';
import 'package:i_movie/data/data_sources/random_movie_data_source.dart';
import 'package:i_movie/data/models/user.dart';
import 'package:i_movie/data/repositories/account_repository.dart';
import 'package:i_movie/data/repositories/favorites_repository.dart';
import 'package:i_movie/data/repositories/login_repository.dart';
import 'package:i_movie/data/repositories/random_movie_repository.dart';
import 'package:i_movie/data/repositories/search_movie_repository.dart';

import '../../data/data_sources/search_movie_data_source.dart';
import '../../data/repositories/sign_up_repository.dart';
import 'hive_service.dart';

GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerSingleton<RandomMovieDataSource>(RandomMovieDataSource());

  getIt.registerSingleton<SearchMovieDataSource>(SearchMovieDataSource());

  getIt.registerSingleton<RandomMovieRepository>(RandomMovieRepository());

  getIt.registerSingleton<SearchMovieRepository>(SearchMovieRepository());

  getIt.registerSingleton<SignUpRepository>(SignUpRepository());

  getIt.registerSingleton<LoginRepository>(LoginRepository());

  getIt.registerSingleton<FavoritesRepository>(FavoritesRepository());

  getIt.registerSingleton<AccountRepository>(AccountRepository());
}

void registerCurrentUserSingleton(String userEmail) async {
  User currentUser = await hive.box('auth').get(userEmail);

  getIt.registerSingleton<User>(
    User(
      email: currentUser.email,
      password: currentUser.password,
      username: currentUser.username,
      id: currentUser.id,
    ),
  );

  print(currentUser.email);
}
