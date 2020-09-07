import 'package:universy/text/text.dart';
import 'package:universy/text/translator.dart';

class EventTypeDescriptionTranslator implements Translator<String> {
  String translate(String eventType) {
    return AppText.getInstance().get("student.calendar.eventType.$eventType");
  }
}
