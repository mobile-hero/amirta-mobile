import 'package:amirta_mobile/data/account/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AccountLocalRepository {
  final SharedPreferences prefs;

  AccountLocalRepository(this.prefs);
  
  Future<bool> deleteAll();

  Profile? getUser();
  
  Future<bool> saveUser(Profile user);
}
