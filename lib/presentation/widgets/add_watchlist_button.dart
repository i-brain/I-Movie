import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_movie/bloc/favorites/favorites_cubit.dart';
import 'package:i_movie/data/models/movie.dart';
import 'package:i_movie/data/models/user.dart';
import 'package:i_movie/presentation/core/dialogs.dart';
import 'package:i_movie/presentation/core/locator.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

class AddWatchListButton extends StatefulWidget {
  const AddWatchListButton({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  State<AddWatchListButton> createState() => _AddWatchListButtonState();
}

class _AddWatchListButtonState extends State<AddWatchListButton> {
  final collectionReference = FirebaseFirestore.instance
      .collection('users')
      .doc(getIt<User>().id)
      .collection('favorites');

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: IconButton(
        splashRadius: 0.1,
        onPressed: () async {
          if (isLoading) {
            return;
          }

          if (mounted) {
            setState(() {
              isLoading = true;
            });
          }
          if (widget.movie.isFavorite) {
            await handleRemovingMovieFromFavorites();
          } else {
            await handleAddingMovieToFavorites();

            await context.read<FavoritesCubit>().fetchFavorites();
          }

          if (mounted) {
            setState(() {
              isLoading = false;
            });
          }
        },
        icon: (() {
          if (isLoading) {
            return SizedBox(
              height: 20.h,
              width: 20.w,
              child: const CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }

          if (widget.movie.isFavorite) {
            return Icon(
              Icons.remove,
              size: 30.r,
            );
          }
          return Icon(
            Icons.add,
            size: 30.r,
          );
        }()),
      ),
    );
  }

  Future<void> handleRemovingMovieFromFavorites() async {
    try {
      if (!(await doesMovieExistInFirestore())) {
        Dialogs.showFlushbar(
          color: Colors.deepOrange,
          message: 'Movie already removed from favorites.',
          context: context,
        );
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }

        return;
      }
      await removeMovieFromFirestore();

      Dialogs.showFlushbar(
        color: Colors.purple,
        message: 'Movie removed from favorites.',
        context: context,
      );
    } on SocketException {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }

      Dialogs.showFlushbar(
        context: context,
        message: 'No Internet Connection',
        color: Colors.blueGrey,
      );
    } catch (_) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });

        Dialogs.showFlushbar(
          context: context,
          message: 'Server Error Happened',
          color: Colors.blueGrey,
        );
      }
    }
  }

  Future<void> handleAddingMovieToFavorites() async {
    try {
      if (await doesMovieExistInFirestore()) {
        Dialogs.showFlushbar(
          color: Colors.deepOrange,
          message: 'Movie is already in favorites.',
          context: context,
        );
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
        return;
      }

      await saveMovieToFirestore();

      Dialogs.showFlushbar(
        context: context,
        message: 'Movie added to favorites',
        color: Colors.green,
      );
    } on SocketException {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }

      Dialogs.showFlushbar(
        context: context,
        message: 'No Internet Connection',
        color: Colors.blueGrey,
      );
    } catch (_) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });

        Dialogs.showFlushbar(
          context: context,
          message: 'Server Error Happened',
          color: Colors.blueGrey,
        );
      }
    }
  }

  Future<bool> doesMovieExistInFirestore() async {
    var querySnapshot = await collectionReference
        .where('name', isEqualTo: widget.movie.name)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

  Future<void> saveMovieToFirestore() async {
    await collectionReference.add({
      'name': widget.movie.name,
      'genre': widget.movie.genre,
      'imdb': widget.movie.imdb,
      'date': widget.movie.date,
      'imageUrl': widget.movie.imageUrl,
      'story': widget.movie.story,
      'runtime': widget.movie.runtime,
      'isFavorite': true,
      'timeStamp': DateTime.now(),
    });

    await updateCount(increment: true);

    print('saved to firestore');
  }

  Future<void> removeMovieFromFirestore() async {
    await collectionReference
        .where('name', isEqualTo: widget.movie.name)
        .get()
        .then((querySnapshot) {
      String docId = querySnapshot.docs.first.id;

      collectionReference.doc(docId).delete();
    });

    await updateCount(increment: false);
  }

  Future<void> updateCount({bool increment = true}) async {
    int currentCount = await collectionReference.doc('count').get().then(
      (documentSnapshot) {
        if (documentSnapshot.exists) {
          return documentSnapshot.data()!['count'];
        }
        return 0;
      },
    );

    int lastCount = increment ? currentCount + 1 : currentCount - 1;

    await collectionReference.doc('count').set(
      {
        'count': lastCount,
      },
    );
  }
}
