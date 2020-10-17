import 'package:universy/constants/strings.dart';
import 'package:universy/model/institution/coursing_period.dart';
import 'package:universy/text/translators/month.dart';
import 'package:universy/util/object.dart';
import 'package:universy/util/strings.dart';

class PeriodRangeFormatter {
  static const String IN_BETWEEN_SIGN = "-";
  final CoursingPeriod _period;

  PeriodRangeFormatter(this._period);

  String format() {
    if (notNull(_period)) {
      String beginMonth = MonthTextTranslator().translate(_period.beginMonth);
      String endMonth = MonthTextTranslator().translate(_period.endMonth);
      if (notNullOrEmpty(beginMonth) && notNullOrEmpty(endMonth)) {
        return "$beginMonth - $endMonth";
      }
    }
    return EMPTY_STRING;
  }
}
