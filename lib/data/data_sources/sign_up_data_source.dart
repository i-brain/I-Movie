import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:i_movie/data/models/user.dart';
import 'package:i_movie/presentation/core/hive_service.dart';

class SignUpDataSource {
  fb.FirebaseAuth auth = fb.FirebaseAuth.instance;

  final collectionRef = FirebaseFirestore.instance.collection('users');

  Future<void> registerUser(User user) async {
    fb.UserCredential credential = await auth.createUserWithEmailAndPassword(
        email: user.email, password: user.password);

    User newUser = User(
      email: user.email,
      password: user.password,
      id: credential.user!.uid,
      username: user.username,
    );

    await collectionRef.doc(newUser.id).set({
      'username': user.username,
      'email': user.email,
      'password': user.password,
      'id': user.id,
    });

    await HiveService.saveUserInfo(newUser);
  }
}
