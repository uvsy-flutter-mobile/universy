import 'package:universy/text/text.dart';

const String APPROVED = "APPROVED";
const String REGULAR = "REGULAR";
const String TAKING = "TAKING";
const String TO_TAKE = "TO_TAKE";

const int APPROVED_INDEX = 3;
const int REGULAR_INDEX = 2;
const int TAKING_INDEX = 1;
const int TO_TAKE_INDEX = 0;

bool isTypeApproved(String milestoneType) {
  return milestoneType == APPROVED;
}

bool isTypeRegular(String milestoneType) {
  return milestoneType == REGULAR;
}

bool isTypeTaking(String milestoneType) {
  return milestoneType == TAKING;
}

String getMilestoneDisplayName(String milestoneType) {
  if (milestoneType == APPROVED) {
    return AppText.getInstance().get("milestoneSubject.types.approved");
  } else if (milestoneType == REGULAR) {
    return AppText.getInstance().get("milestoneSubject.types.regular");
  } else if (milestoneType == TAKING) {
    return AppText.getInstance().get("milestoneSubject.types.taking");
  } else {
    return AppText.getInstance().get("milestoneSubject.types.toTake");
  }
}
