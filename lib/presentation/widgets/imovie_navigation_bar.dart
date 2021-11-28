import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_movie/bloc/favorites/favorites_cubit.dart';
import 'package:i_movie/bloc/random_movie/random_movie_cubit.dart';

import 'package:i_movie/presentation/account/account_page.dart';
import 'package:i_movie/presentation/core/dialogs.dart';
import 'package:i_movie/presentation/favorites/favorites_page.dart';
import 'package:i_movie/presentation/home/home_page.dart';
import 'package:i_movie/presentation/search/search_page.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

class IMovieNavigationBar extends StatefulWidget {
  const IMovieNavigationBar({Key? key}) : super(key: key);

  @override
  _IMovieNavigationBarState createState() => _IMovieNavigationBarState();
}

class _IMovieNavigationBarState extends State<IMovieNavigationBar> {
  int _pageIndex = 0;
  late PageController _pageController;

  List<Widget> tabPages = [
    const HomePage(),
    const SearchPage(),
    const FavoritesPage(),
    AccountPage()
  ];

  @override
  void initState() {
    super.initState();

    context.read<RandomMovieCubit>().fetchMovies();
    context.read<FavoritesCubit>().fetchFavorites();
    _pageController = PageController(initialPage: _pageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Dialogs.showInfoDialog(
          context: context,
          message: 'Do you want to exit?',
          onConfirm: SystemNavigator.pop,
        );
        return Future.delayed(Duration.zero, () => true);
      },
      child: Scaffold(
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.black,
          ),
          child: BottomNavigationBar(
            currentIndex: _pageIndex,
            onTap: onTabTapped,
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            selectedFontSize: 12.sp,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: 'Search'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'Favorites'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Me'),
            ],
          ),
        ),
        body: SafeArea(
          child: PageView(
            children: tabPages,
            onPageChanged: onPageChanged,
            controller: _pageController,
          ),
        ),
      ),
    );
  }

  void onPageChanged(int page) {
    setState(() {
      _pageIndex = page;
    });
  }

  void onTabTapped(int index) {
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }
}
