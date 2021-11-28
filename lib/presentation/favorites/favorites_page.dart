import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_movie/bloc/favorites/favorites_cubit.dart';
import 'package:i_movie/data/models/user.dart';
import 'package:i_movie/presentation/core/dialogs.dart';
import 'package:i_movie/presentation/core/locator.dart';
import 'package:i_movie/presentation/favorites/widgets/favorite_loading_card.dart';
import 'package:i_movie/presentation/favorites/widgets/favorite_movie_card.dart';
import 'package:i_movie/presentation/favorites/widgets/favorite_movie_list.dart';
import 'package:i_movie/presentation/widgets/no_internet_widget.dart';
import 'package:i_movie/presentation/widgets/refresh_button.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage>
    with AutomaticKeepAliveClientMixin {
  final userId = getIt<User>().id;

  late final _scrollController = ScrollController();

  var isFetching = false;

  int favoritesCount = 0;

  @override
  void initState() {
    _handleFetchNextFavorites();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final size = MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: context.read<FavoritesCubit>().fetchFavorites,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Favorites'),
          leading: const SizedBox(),
        ),
        backgroundColor: Colors.black,
        body: CustomScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: 20.h,
              ),
            ),
            BlocConsumer<FavoritesCubit, FavoritesState>(
              listener: (context, state) {
                if (state is FavoritesSuccess &&
                    state.fetchingNextFavoritesFailed) {
                  Dialogs.showSnackBar(
                      context: context,
                      message: 'Check your internet connection',
                      color: Colors.black);
                }
              },
              builder: (context, state) {
                print(state);

                if (state is FavoritesSuccess) {
                  if (state.list.isEmpty) {
                    return SliverToBoxAdapter(
                      child: SizedBox(
                        height: (size.height * 0.7),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.favorite,
                              size: 200.r,
                              color: Colors.white,
                            ),
                            Text(
                              'No favorites saved',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 25.sp),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                  final List<Widget> list = [];

                  for (var index = 0; index < state.list.length; index++) {
                    list.add(
                      InkWell(
                        onTap: () => _onTap(context, index),
                        child: FavoriteMovieCard(
                          movie: state.list[index],
                        ),
                      ),
                    );
                  }

                  if (state.isNextMoviesFetching &&
                      state.favoritesCount != state.list.length) {
                    if (state.list.length % 2 == 0) {
                      list.add(const FavoriteLoadingCard());
                    }

                    list.add(const FavoriteLoadingCard());
                  }

                  return SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => list[index],
                      childCount: list.length,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: size.height / 1100,
                      crossAxisSpacing: 6,
                      mainAxisSpacing: 16,
                    ),
                  );
                }
                if (state is FavoritesError) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: SizedBox(
                        height: 0.7 * size.height,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const NoInternetWidget(),
                            SizedBox(
                              height: 50.h,
                            ),
                            RefreshButton(
                              onPressed:
                                  context.read<FavoritesCubit>().fetchFavorites,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }

                return SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => const FavoriteLoadingCard(),
                    childCount: 6,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: size.height / 1100,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 16,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            FavoriteMovieList(
          pageController: PageController(initialPage: index),
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  void _handleFetchNextFavorites() {
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent * 0.5) {
        if (isFetching) {
          return;
        }
        isFetching = true;
        await context.read<FavoritesCubit>().fetchNextFavorites();
        isFetching = false;
      }
    });
  }

  @override
  bool get wantKeepAlive => true;
}
