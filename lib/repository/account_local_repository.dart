import 'package:amirta_mobile/data/account/profile.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class AccountLocalRepository {
  final FlutterSecureStorage prefs;

  AccountLocalRepository(this.prefs);

  Future<void> deleteAll();

  Future<Profile?> getUser();

  Future<void> saveUser(Profile user);
}
