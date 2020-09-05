import 'package:flutter/material.dart';
import 'package:universy/business/correlatives/validator.dart';
import 'package:universy/model/subject.dart';

class SubjectIconResolver {
  final CorrelativesValidator correlativesValidator;

  SubjectIconResolver(this.correlativesValidator);

  IconData getSubjectIcon(Subject subject) {
    if (subject.isApproved()) {
      return Icons.done_all;
    } else if (subject.isRegular()) {
      return Icons.done;
    } else if (subject.isTaking()) {
      return Icons.import_contacts;
    } else if (canTake(subject)) {
      return Icons.lock_open;
    } else {
      return Icons.lock;
    }
  }

  bool canTake(Subject subject) {
    var correlativeValidation = correlativesValidator.canTake(subject);
    return correlativeValidation?.isValid ?? false;
  }
}
