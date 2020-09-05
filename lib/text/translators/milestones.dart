import 'package:universy/model/student/subject.dart';

String getMilestoneDisplayName(MilestoneType milestoneType) {
  // TODO: Text
  if (milestoneType == MilestoneType.APPROVED) {
    return "Aprobada"; //AppText.getInstance().get("milestoneSubject.types.approved");
  } else if (milestoneType == MilestoneType.REGULAR) {
    return "Regular"; //AppText.getInstance().get("milestoneSubject.types.regular");
  } else if (milestoneType == MilestoneType.TAKING) {
    return "Cursando"; //AppText.getInstance().get("milestoneSubject.types.taking");
  } else {
    return "Por cursar"; //AppText.getInstance().get("milestoneSubject.types.toTake");
  }
}
