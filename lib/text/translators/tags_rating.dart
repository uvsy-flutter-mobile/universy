import 'package:universy/text/text.dart';
import 'package:universy/text/translator.dart';

class TagsRatingTranslator implements Translator<String> {
  @override
  String translate(String tag) {
    return AppText.getInstance().get("enums.tags.$tag");
  }
}
