import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:i_movie/data/models/user.dart';
import 'package:i_movie/presentation/core/locator.dart';

class AccountDataSource {
  Future<void> updateUserPassword(String newPassword) async {
    String userId = getIt<User>().id!;

    await auth.FirebaseAuth.instance.currentUser!.updatePassword(
      newPassword,
    );

    await FirebaseFirestore.instance.collection('users').doc(userId).update(
      {
        'password': newPassword,
      },
    );
  }
}
