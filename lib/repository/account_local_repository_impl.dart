import 'dart:convert';

import 'package:amirta_mobile/data/account/profile.dart';
import 'package:amirta_mobile/repository/account_local_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountLocalRepositoryImpl extends AccountLocalRepository {
  AccountLocalRepositoryImpl(SharedPreferences prefs) : super(prefs);

  @override
  Future<bool> deleteAll() async {
    return prefs.clear();
  }

  Profile? getUser() {
    if (prefs.containsKey("user")) {
      final json = prefs.getString("user")!;
      return Profile.fromJson(jsonDecode(json));
    }
    return null;
  }

  Future<bool> saveUser(Profile user) {
    return prefs.setString("user", jsonEncode(user.toJson()));
  }
}
