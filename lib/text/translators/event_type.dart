import 'package:universy/text/text.dart';
import 'package:universy/text/translator.dart';

class EventTypeTranslator implements Translator<String> {
  String translate(String eventType) {
    return AppText.getInstance().get("studentEvents.eventType.$eventType");
  }
}
