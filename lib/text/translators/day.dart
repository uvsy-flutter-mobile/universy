import 'package:universy/text/text.dart';
import 'package:universy/text/translator.dart';

class DayTextTranslator implements Translator<String> {
  String translate(String dayOfWeek) {
    return AppText.getInstance().get("enums.dayOfWeek.$dayOfWeek");
  }
}
