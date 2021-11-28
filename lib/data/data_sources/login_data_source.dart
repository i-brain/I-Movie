import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:i_movie/data/models/user.dart';

class LoginDataSource {
  fb.FirebaseAuth auth = fb.FirebaseAuth.instance;

  Future<void> loginUser(User user) async {
    await auth.signInWithEmailAndPassword(
        email: user.email, password: user.password);
  }
}
