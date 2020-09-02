import 'package:universy/business/correlatives/validator.dart';

abstract class OnNewCommand {
  CorrelativeValidation checkCorrelative();

  void perform(DateTime milestoneDate);
}

abstract class OnUpdateCommand {
  void perform(DateTime milestoneDate);
}

abstract class OnDeleteCommand {
  void perform();
}
