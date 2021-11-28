import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:i_movie/bloc/favorites/favorites_cubit.dart';
import 'package:i_movie/presentation/home/widgets/tik_tok_widget.dart';

class FavoriteMovieList extends StatelessWidget {
  const FavoriteMovieList({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesSuccess) {
            return PageView.builder(
              controller: pageController,
              itemCount: state.list.length,
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              onPageChanged: (value) async {
                if (value > state.list.length - 4 &&
                    state.isNextMoviesFetching == false) {
                  await context.read<FavoritesCubit>().fetchNextFavorites();
                }
              },
              itemBuilder: (context, index) {
                return GestureDetector(
                    onHorizontalDragEnd: (details) {
                      if (!details.primaryVelocity!.isNegative) {
                        Navigator.pop(context);
                      }
                    },
                    child: TikTokWidget(movie: state.list[index]));
              },
            );
          }
          return const Center(
            child: SpinKitDoubleBounce(
              color: Colors.pink,
            ),
          );
        },
      ),
    );
    ;
  }
}
