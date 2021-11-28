import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_movie/bloc/login/login_cubit.dart';
import 'package:i_movie/presentation/core/const.dart';
import 'package:i_movie/data/repositories/login_repository.dart';
import 'package:i_movie/presentation/log_in/log_in_page.dart';
import 'package:i_movie/presentation/sign_up/sign_up_page.dart';
import 'package:i_movie/presentation/widgets/imovie_navigation_bar.dart';

import '../../bloc/sign_up/sign_up_cubit.dart';

import '../../data/repositories/sign_up_repository.dart';
import 'locator.dart';

class MyRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRouteName:
        return MaterialPageRoute(
          builder: (context) => const IMovieNavigationBar(),
        );

      case loginRouteName:
        return MaterialPageRoute(
          builder: (context) => RepositoryProvider(
            create: (context) => getIt<LoginRepository>(),
            child: BlocProvider(
              create: (context) => LoginCubit(
                repository: RepositoryProvider.of<LoginRepository>(context),
              ),
              child: LogInPage(),
            ),
          ),
        );
      case signUpRouteName:
        return MaterialPageRoute(
          builder: (context) => RepositoryProvider(
            create: (context) => getIt<SignUpRepository>(),
            child: BlocProvider(
              create: (context) => SignUpCubit(
                repository: RepositoryProvider.of<SignUpRepository>(context),
              ),
              child: SignUpPage(),
            ),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => RepositoryProvider(
            create: (context) => getIt<LoginRepository>(),
            child: BlocProvider(
              create: (context) => LoginCubit(
                repository: RepositoryProvider.of<LoginRepository>(context),
              ),
              child: LogInPage(),
            ),
          ),
        );
    }
  }
}
