import 'package:optional/optional.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universy/storage/manifest.dart';
import 'package:universy/util/logger.dart';
import 'package:universy/util/object.dart';

const String CURR_PROGRAM_ID = "CURR_PROGRAM_ID";

class DefaultStudentCareerStorage extends StudentCareerStorage {
  static StudentCareerStorage _instance;

  DefaultStudentCareerStorage._internal();

  factory DefaultStudentCareerStorage.instance() {
    if (isNull(_instance)) {
      _instance = DefaultStudentCareerStorage._internal();
    }
    return _instance;
  }

  @override
  Future<Optional<String>> getCurrentProgram() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return Optional.ofNullable(prefs.getString(CURR_PROGRAM_ID));
    } catch (e) {
      Log.getLogger().error("Error fetching current program id");
      return Optional.empty();
    }
  }

  @override
  Future<void> setCurrentProgram(String programId) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(CURR_PROGRAM_ID, programId);
    } catch (e) {
      Log.getLogger().error("Error fetching current program id");
    }
  }
}
