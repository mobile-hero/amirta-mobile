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
  
  final _keyUser = "user";

  Future<Profile?> getUser() async {
    if (await prefs.containsKey(key: _keyUser)) {
      final json = await prefs.read(key: _keyUser);
      return Profile.fromJson(jsonDecode(json!));
    }
    return null;
  }

  Future<void> saveUser(Profile user) {
    return prefs.write(key: _keyUser, value: jsonEncode(user.toJson()));
  }
}
