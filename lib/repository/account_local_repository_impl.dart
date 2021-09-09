import 'dart:convert';

import 'package:amirta_mobile/data/account/profile.dart';
import 'package:amirta_mobile/repository/account_local_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AccountLocalRepositoryImpl extends AccountLocalRepository {
  AccountLocalRepositoryImpl(FlutterSecureStorage prefs) : super(prefs);

  @override
  Future<void> deleteAll() async {
    return prefs.deleteAll();
  }

  Future<Profile?> getUser() async {
    if (await prefs.containsKey(key: "user")) {
      final json = await prefs.read(key: "user");
      return Profile.fromJson(jsonDecode(json!));
    }
    return null;
  }

  Future<void> saveUser(Profile user) {
    return prefs.write(key: "user", value: jsonEncode(user.toJson()));
  }
}
