import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/business/subjects/classifier/correlative_classifier.dart';
import 'package:universy/constants/strings.dart';
import 'package:universy/model/institution/subject.dart';
import 'package:universy/services/manifest.dart';

import 'states.dart';

class BoardCorrelativesCubit extends Cubit<BoardCorrelativesState> {
  final InstitutionSubject subject;
  final InstitutionService institutionService;
  final SubjectCorrelativeClassifier classifier =
      SubjectCorrelativeClassifier();

  BoardCorrelativesCubit(this.subject, this.institutionService)
      : super(LoadingState());

  Future<void> getCorrelatives() async {
    if (subject.correlatives.isNotEmpty) {
      List<InstitutionSubject> subjects = await institutionService.getSubjects(
        subject.programId,
      );
      Map<String, InstitutionSubject> subjectIdMap = Map.fromIterable(
        subjects,
        key: (s) => s.id,
        value: (s) => s,
      );

      var classification = classifier.classify(subject);
      List<CorrelativeItem> toTake = getItems(
        classification.correlativesToTake,
        subjectIdMap,
      );
      List<CorrelativeItem> toApprove = getItems(
        classification.correlativesToApprove,
        subjectIdMap,
      );
      emit(CorrelativesFetchedState(toTake, toApprove));
    } else {
      emit(EmptyCorrelativesState());
    }
  }

  List<CorrelativeItem> getItems(List<Correlative> correlatives,
      Map<String, InstitutionSubject> subjectIdMap) {
    return correlatives
        .where((c) => subjectIdMap.containsKey(c.correlativeSubjectId))
        .map((c) => CorrelativeItem(
            subjectIdMap[c.correlativeSubjectId]?.name ?? N_A,
            subjectIdMap[c.correlativeSubjectId]?.level ?? 0,
            c.correlativeCondition))
        .toList();
  }
}
