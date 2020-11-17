import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/model/institution/commission.dart';
import 'package:universy/model/institution/course.dart';
import 'package:universy/model/institution/subject.dart';
import 'package:universy/services/manifest.dart';

import 'states.dart';

class BoardCoursesCubit extends Cubit<BoardCoursesState> {
  final InstitutionSubject subject;
  final InstitutionService institutionService;

  BoardCoursesCubit(this.subject, this.institutionService)
      : super(LoadingState());

  Future<void> fetchCourses() async {
    List<Course> fetchedCourses =
        await institutionService.getCourses(subject.id);
    if (fetchedCourses.isNotEmpty) {
      List<Commission> fetchedCommissions =
          await institutionService.getCommissions(
        subject.programId,
      );
      Map<String, Commission> commissions = Map.fromIterable(
        fetchedCommissions,
        key: (c) => c.id,
        value: (c) => c,
      );

      List<Course> courses = fetchedCourses
          .where(
            (course) => commissions.containsKey(course.commissionId),
          )
          .toList();

      if (courses.isEmpty) {
        emit(EmptyCoursesState());
      } else {
        emit(CoursesFetchedState(subject, courses, commissions));
      }
    } else {
      emit(EmptyCoursesState());
    }
  }
}
