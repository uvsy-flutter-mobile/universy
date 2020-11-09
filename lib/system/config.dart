import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:universy/system/assets.dart';

class SystemConfig {
  static const String CLIENT_ID = "clientId";
  static const String DB_PATH = "dbPath";
  static const String STAGE = "stage";
  static const String USER_POOL_ID = "userPoolId";

  static final SystemConfig _instance = SystemConfig._internal();

  Map<String, dynamic> config;

  SystemConfig._internal();

  factory SystemConfig.instance() {
    return _instance;
  }

  Future<String> _loadConfigFile() async {
    return await rootBundle.loadString(Assets.CONFIG_FILE);
  }

  Future<void> load() async {
    try {
      String jsonString = await _loadConfigFile();
      config = json.decode(jsonString);
    } catch (e) {
      throw Exception("Problem loading config/config.json. "
          "Maybe the file is not present");
    }
  }

  String clientId() => config[CLIENT_ID];

  String dbPath() => config[DB_PATH];

  String getStage() => config[STAGE];

  String userPoolId() => config[USER_POOL_ID];
}
