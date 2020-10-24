import 'package:universy/text/text.dart';
import 'package:universy/text/translator.dart';

class MonthTextTranslator implements Translator<String> {
  String translate(String month) {
    return AppText.getInstance().get("enums.month.$month");
  }
}
