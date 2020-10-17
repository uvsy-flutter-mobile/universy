import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/model/institution/couse.dart';
import 'package:universy/model/institution/ratings.dart';
import 'package:universy/model/student/ratings.dart';
import 'package:universy/services/exceptions/student.dart';
import 'package:universy/services/manifest.dart';

import 'states.dart';

class CourseRatingCubit extends Cubit<CourseRatingState> {
  final Course course;
  final RatingsService ratingService;

  CourseRatingCubit(this.course, this.ratingService)
      : super(CourseRatingInitialState());

  Future<StudentCourseRating> fetchStudentRating() async {
    try {
      return await ratingService.getStudentCourseRating(course.courseId);
    } on RatingNotFound {
      return StudentCourseRating.empty(course.courseId);
    }
  }

  Future<void> saveStudentRating(StudentCourseRating rating) async {
    await ratingService.saveStudentCourseRating(rating);
    reFetchRating();
  }

  Future<void> reFetchRating() async {
    await Future.delayed(Duration(seconds: 6));
    await fetchRating();
  }

  Future<void> fetchRating() async {
    try {
      CourseRating rating =
          await ratingService.getCourseRating(course.courseId);
      emit(CourseRatingReceivedState(rating));
    } on RatingNotFound {
      emit(CourseRatingNotExistingState());
    }
  }
}
