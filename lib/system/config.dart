import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:universy/system/assets.dart';

class SystemConfig {
  static const String STAGE = "stage";
  static const String DB_PATH = "dbPath";

  static const String STUDENT_API = "studentEndpoint";
  static const String ACCOUNT_API = "accountEndpoint";
  static const String INSTITUTION_API = "institutionEndpoint";
  static const String STUDENT_API_KEY = "studentKey";
  static const String ACCOUNT_API_KEY = "accountKey";
  static const String INSTITUTION_API_KEY = "institutionKey";

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

  String getApiStudentURL() {
    return config[STUDENT_API];
  }

  String getApiStudentKey() {
    return config[STUDENT_API_KEY];
  }

  String getStage() {
    return config[STAGE];
  }

  String dbPath() {
    return config[DB_PATH];
  }
}
