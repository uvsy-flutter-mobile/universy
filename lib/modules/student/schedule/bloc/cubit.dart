import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/business/schedule_scratch/career_years.dart';
import 'package:universy/business/schedule_scratch/course_list_generator.dart';
import 'package:universy/business/subjects/classifier/result.dart';
import 'package:universy/business/subjects/classifier/year_classifier.dart';
import 'package:universy/model/institution/commission.dart';
import 'package:universy/model/institution/course.dart';
import 'package:universy/model/institution/subject.dart';
import 'package:universy/model/student/schedule.dart';
import 'package:universy/services/exceptions/student.dart';
import 'package:universy/services/impl/student/career.dart';
import 'package:universy/services/manifest.dart';
import 'package:universy/util/object.dart';

import 'states.dart';

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
      var scheduleScratches = await _scheduleService.getScratches(programId);

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
    await _scheduleService.createScratch(studentScheduleScratch);
    this.fetchScratches();
  }

  Future<void> updateScratch(
      StudentScheduleScratch studentScheduleScratch) async {
    print("updateScratch");
    /* await _scheduleService.updateScratch(studentScheduleScratch);*/
    this.fetchScratches();
  }

  Future<void> deleteScratch(String scratchId) async {
    print("deleteScratch");
    /*await _scheduleService.deleteScratch(scratchId);*/
  }

  void createViewScratchSchedule(
      StudentScheduleScratch studentScheduleScratch) async {
    try {
      emit(LoadingState());
      var programId = await _studentCareerService.getCurrentProgram();
      var institutionSubjects =
          await _institutionService.getSubjects(programId);
      var commissions = await _institutionService.getCommissions(programId);

      var scratchCourses =
          await _generateScratchCourses(institutionSubjects, commissions);

      ProgramYearsClassifier programYearsClassifier = ProgramYearsClassifier();
      List<int> levels =
          programYearsClassifier.yearsOfCareer(institutionSubjects);

      emit(CreateScratchState(
          studentScheduleScratch, scratchCourses, levels, institutionSubjects));
    } on CurrentProgramNotFound {
      emit(CareerNotCreatedState());
    }
  }

  void editViewScratchSchedule(
      StudentScheduleScratch studentScheduleScratch) async {
    try {
      emit(LoadingState());
      var programId = await _studentCareerService.getCurrentProgram();
      var institutionSubjects =
          await _institutionService.getSubjects(programId);
      var commissions = await _institutionService.getCommissions(programId);
      ProgramYearsClassifier programYearsClassifier = ProgramYearsClassifier();
      List<int> levels =
          programYearsClassifier.yearsOfCareer(institutionSubjects);

      var scratchCourses =
          await _generateScratchCourses(institutionSubjects, commissions);

      emit(EditScratchState(
          studentScheduleScratch, scratchCourses, levels, institutionSubjects));
    } on CurrentProgramNotFound {
      emit(CareerNotCreatedState());
    }
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
