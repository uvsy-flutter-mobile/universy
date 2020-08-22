import 'package:universy/util/object.dart';

class TextSearchComparator {
  String mainText;

  TextSearchComparator(this.mainText);

  bool isQueryInText(String query) {
    if (notNull(query) && notNull(mainText)) {
      var formattedOriginalText = _formatTextToStandardForm(mainText);
      var formattedQuery = _formatTextToStandardForm(query);
      return formattedOriginalText.contains(formattedQuery);
    }
    return false;
  }

  String _formatTextToStandardForm(String text) {
    text = text.toLowerCase();
    return _removeAccentMarks(text);
  }

  String _removeAccentMarks(String text) {
    return text
        .replaceAll("á", "a")
        .replaceAll("é", "e")
        .replaceAll("í", "i")
        .replaceAll("ó", "o")
        .replaceAll("ú", "u");
  }
}
