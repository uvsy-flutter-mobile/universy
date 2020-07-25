import 'package:universy/text/text.dart';
import 'package:universy/text/translator.dart';

class CourseRateTagsTranslator implements Translator<String> {
  @override
  String translate(String tag) {
    return AppText.getInstance().get("course.rates.tags.$tag");
  }
}
