import 'package:hive_flutter/hive_flutter.dart';
import 'package:i_movie/data/models/user.dart';

final hive = Hive;

class HiveService {
  static Future<void> initilazieHive() async {
    await hive.initFlutter();
    hive.registerAdapter<User>(UserAdapter());

    await hive.openBox('search').then((box) {
      if (!box.containsKey('list')) {
        box.put('list', []);
      }
    });

    await hive.openBox('auth');
  }

  static Future<void> saveUserInfo(User user) async {
    await hive.box('auth').put(user.email, user);
  }
}
