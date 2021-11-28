import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:i_movie/data/models/movie.dart';
import 'package:i_movie/data/models/user.dart';
import 'package:i_movie/presentation/core/locator.dart';

class FavoritesDataSource {
  final _collectionReference = FirebaseFirestore.instance.collection('users');

  late DocumentSnapshot _lastdocumentSnapshot;
  Future<List<Movie>> fetchFavoritesFromFirestore({
    bool isFetchingNextFavorites = false,
  }) async {
    var userId = getIt<User>().id;

    final List<Movie> movieList = [];

    QuerySnapshot<Map<String, dynamic>> querySnapshot;

    if (isFetchingNextFavorites) {
      querySnapshot = await _collectionReference
          .doc(userId)
          .collection('favorites')
          .orderBy('timeStamp', descending: true)
          .startAfterDocument(_lastdocumentSnapshot)
          .limit(10)
          .get();
    } else {
      querySnapshot = await _collectionReference
          .doc(userId)
          .collection('favorites')
          .orderBy('timeStamp', descending: true)
          .limit(10)
          .get();
    }

    if (querySnapshot.docs.isNotEmpty) {
      _lastdocumentSnapshot = querySnapshot.docs[querySnapshot.docs.length - 1];
    }

    for (var documentSnap in querySnapshot.docs) {
      print(documentSnap.data());

      movieList.add(
        Movie.fromFirstoreJson(documentSnap.data()),
      );
    }

    return movieList;
  }

  Future<int> getFavoriteMoviesCount() async {
    var userId = getIt<User>().id;

    return _collectionReference
        .doc(userId)
        .collection('favorites')
        .doc('count')
        .get()
        .then((documentSnapshot) {
      if (documentSnapshot.exists) {
        return documentSnapshot.data()!['count'];
      }
      return 0;
    });
  }
}
