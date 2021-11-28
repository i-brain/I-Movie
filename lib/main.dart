import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:i_movie/bloc/account/account_cubit.dart';
import 'package:i_movie/presentation/account/account_page.dart';

import 'package:i_movie/presentation/core/const.dart';
import 'package:i_movie/presentation/core/locator.dart';

import 'package:i_movie/presentation/core/router.dart';
import 'package:i_movie/presentation/widgets/splash_screen.dart';

import 'bloc/favorites/favorites_cubit.dart';
import 'bloc/random_movie/random_movie_cubit.dart';
import 'bloc/search/search_movie_cubit.dart';
import 'data/repositories/account_repository.dart';
import 'data/repositories/favorites_repository.dart';
import 'data/repositories/random_movie_repository.dart';
import 'data/repositories/search_movie_repository.dart';
import 'presentation/core/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await HiveService.initilazieHive();

  setupLocator();

  runApp(const IMovieApp());
}

class IMovieApp extends StatefulWidget {
  const IMovieApp({Key? key}) : super(key: key);

  @override
  State<IMovieApp> createState() => _IMovieAppState();
}

class _IMovieAppState extends State<IMovieApp> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => getIt<RandomMovieRepository>(),
        ),
        RepositoryProvider(
          create: (context) => getIt<SearchMovieRepository>(),
        ),
        RepositoryProvider(
          create: (context) => getIt<FavoritesRepository>(),
        ),
        RepositoryProvider(
          create: (context) => getIt<AccountRepository>(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => RandomMovieCubit(
              movieRepository:
                  RepositoryProvider.of<RandomMovieRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => SearchMovieCubit(
              searchMovieRepository:
                  RepositoryProvider.of<SearchMovieRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => FavoritesCubit(
              favoritesRepository:
                  RepositoryProvider.of<FavoritesRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => AccountCubit(
              accountRepository:
                  RepositoryProvider.of<AccountRepository>(context),
            ),
          ),
        ],
        child: ScreenUtilInit(
          designSize: const Size(360, 690),
          builder: () => MaterialApp(
            theme: ThemeData(
              appBarTheme: AppBarTheme(
                  backgroundColor: Colors.black,
                  titleTextStyle:
                      TextStyle(color: Colors.white, fontSize: 20.sp),
                  centerTitle: true),
            ),
            onGenerateRoute: MyRouter.onGenerateRoute,
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
          ),
        ),
      ),
    );
  }
}
