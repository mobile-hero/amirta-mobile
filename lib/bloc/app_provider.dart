import 'dart:io';

import 'package:amirta_mobile/data/account/profile.dart';
import 'package:amirta_mobile/repository/account_local_repository.dart';
import 'package:amirta_mobile/repository/account_repository.dart';
import 'package:amirta_mobile/repository/repository_config.dart';
import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppProvider {
  final Dio dio;
  final RepositoryConfig repositoryConfig;
  final DeviceInfoPlugin deviceInfo;
  final AccountLocalRepository accountLocalRepository;
  final AccountRepository accountRepository;

  AppProvider({
    required this.dio,
    required this.repositoryConfig,
    required this.deviceInfo,
    required this.accountLocalRepository,
    required this.accountRepository,
  }) {
    dio.interceptors.addAll(repositoryConfig.interceptors);
  }

  String _version = "version";

  String get version => _version;

  Profile? _user;

  Profile? get user => _user;

  Future<int> setUser(Profile user) async {
    await accountLocalRepository.saveUser(user);
    return setupAll();
  }
  
  setVersion(String version) async {
    _version = version;
    repositoryConfig.setVersion(version);
    return setupAll();
  }

  _setupHeaderiOS() async {
    final iosInfo = await deviceInfo.iosInfo;
    final deviceId = iosInfo.identifierForVendor;
    repositoryConfig.setDeviceId(deviceId);
  }

  _setupHeaderAndroid() async {
    final androidInfo = await deviceInfo.androidInfo;
    final deviceId = androidInfo.androidId;
    repositoryConfig.setDeviceId(deviceId);
  }

  _setupHeaderToken() {
    final user = accountLocalRepository.getUser();
    if (user != null) {
      _user = user;
      repositoryConfig.setToken(user.sessid!);
    }
  }

  Future<int> setupAll() async {
    if (Platform.isAndroid) {
      await _setupHeaderAndroid();
    } else if (Platform.isIOS) {
      await _setupHeaderiOS();
    }
    _setupHeaderToken();
    repositoryConfig.setupInterceptor();
    dio.interceptors.clear();
    dio.interceptors.addAll(repositoryConfig.interceptors);

    if (_user != null) {
      return Future.delayed(Duration(seconds: 1), () => 1);
    } else {
      return Future.delayed(Duration(seconds: 1), () => 0);
    }
  }

  Future<int> clearData() async {
    await accountLocalRepository.deleteAll();
    return setupAll();
  }
}

extension StarvoProviderHelper on BuildContext {
  AppProvider starvoProvider() {
    return Provider.of<AppProvider>(this, listen: false);
  }
}
