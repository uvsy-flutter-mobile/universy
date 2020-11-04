import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/business/schedule_scratch/course_list_generator.dart';
import 'package:universy/model/institution/commission.dart';
import 'package:universy/model/institution/course.dart';
import 'package:universy/model/institution/subject.dart';
import 'package:universy/model/student/schedule.dart';
import 'package:universy/services/exceptions/student.dart';
import 'package:universy/services/impl/student/career.dart';
import 'package:universy/services/manifest.dart';
import 'package:universy/util/object.dart';

import 'states.dart';

const List<int> LEVELS = [1, 2, 3, 4, 5]; //TODO: add this behaviour to service?

class ScheduleCubit extends Cubit<ScheduleState> {
  final StudentScheduleService _scheduleService;
  final StudentCareerService _studentCareerService;
  final InstitutionService _institutionService;

  ScheduleCubit(
    this._scheduleService,
    this._institutionService,
    this._studentCareerService,
  ) : super(LoadingState());

  Future<void> fetchScratches() async {
    try {
      emit(LoadingState());
      var programId =
          await DefaultStudentCareerService.instance().getCurrentProgram();
      /* var scheduleScratches = await _scheduleService.getScratches(programId);*/
      List<StudentScheduleScratch> scheduleScratches = [
        StudentScheduleScratch(
            'scheduleScratchId',
            'Primer cuatrimestre muy largo y totalmente execsivo',
            DateTime.now(),
            DateTime.now(),
            [],
            DateTime.now(),
            DateTime.now()),
        StudentScheduleScratch('scheduleScratchId', 'name,', DateTime.now(),
            DateTime.now(), [], DateTime.now(), DateTime.now()),
      ];
      if (scheduleScratches.isNotEmpty) {
        emit(DisplayScratchesState(scheduleScratches));
      } else {
        emit(EmptyScratches());
      }
    } on CurrentProgramNotFound {
      emit(CareerNotCreatedState());
    }
  }

  Future<void> createScratch(
      StudentScheduleScratch studentScheduleScratch) async {
    /*await _scheduleService.createScratch(studentScheduleScratch);*/
  }

  Future<void> updateScratch(
      StudentScheduleScratch studentScheduleScratch) async {
    /* await _scheduleService.updateScratch(studentScheduleScratch);*/
  }

  Future<void> deleteScratch(String scratchId) async {
    /*await _scheduleService.deleteScratch(scratchId);*/
  }

  void createViewScratchSchedule(
      StudentScheduleScratch studentScheduleScratch) async {
    //TODO: Add error handling
    emit(LoadingState());
    var programId = await _studentCareerService.getCurrentProgram();
    var institutionSubjects = await _institutionService.getSubjects(programId);
    var commissions = await _institutionService.getCommissions(programId);

    var scratchCourses =
        await _generateScratchCourses(institutionSubjects, commissions);

    emit(CreateScratchState(
        studentScheduleScratch, scratchCourses, LEVELS, institutionSubjects));
  }

  void editViewScratchSchedule(
      StudentScheduleScratch studentScheduleScratch) async {
    //TODO: Add error handling
    emit(LoadingState());
    var programId = await _studentCareerService.getCurrentProgram();
    var institutionSubjects = await _institutionService.getSubjects(programId);
    var commissions = await _institutionService.getCommissions(programId);

    var scratchCourses =
        await _generateScratchCourses(institutionSubjects, commissions);

    emit(EditScratchState(
        studentScheduleScratch, scratchCourses, LEVELS, institutionSubjects));
  }

  //TODO: Move this to a service
  Future<List<ScheduleScratchCourse>> _generateScratchCourses(
    List<InstitutionSubject> subjects,
    List<Commission> commissions,
  ) async {
    List<ScheduleScratchCourse> scratchCourses = [];
    subjects.forEach((InstitutionSubject subject) async {
      var courses = await _institutionService.getCourses(subject.id);
      courses.forEach((Course course) {
        var generator =
            ScheduleScratchCourseListGenerator(subjects, commissions, course);
        var scratchCourseListFragment = generator.generate();
        if (notNull(scratchCourseListFragment)) {
          scratchCourses.addAll(scratchCourseListFragment);
        }
      });
    });

    return scratchCourses;
  }
}
