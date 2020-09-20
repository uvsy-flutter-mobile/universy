import 'package:universy/model/institution/ratings.dart';
import 'package:universy/model/student/ratings.dart';
import 'package:universy/services/manifest.dart';
import 'package:universy/util/object.dart';

class DefaultRatingsService extends RatingsService {
  static RatingsService _instance;

  DefaultRatingsService._internal();

  factory DefaultRatingsService.instance() {
    if (isNull(_instance)) {
      _instance = DefaultRatingsService._internal();
    }
    return _instance;
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  Future<CourseRating> getCourseRating(String courseId) {
    // TODO: implement getCourseRating
    throw UnimplementedError();
  }

  @override
  Future<StudentCourseRating> getStudentCourseRating(String courseId) {
    // TODO: implement getStudentCourseRating
    throw UnimplementedError();
  }

  @override
  Future<StudentSubjectRating> getStudentSubjectRating(String subjectId) {
    // TODO: implement getStudentSubjectRating
    throw UnimplementedError();
  }

  @override
  Future<SubjectRating> getSubjectRating(String subjectId) {
    // TODO: implement getSubjectRating
    throw UnimplementedError();
  }

  @override
  Future<void> saveStudentCourseRating(StudentCourseRating courseRating) {
    // TODO: implement saveStudentCourseRating
    throw UnimplementedError();
  }

  @override
  Future<void> saveStudentSubjectRating(StudentSubjectRating subjectRating) {
    // TODO: implement saveStudentSubjectRating
    throw UnimplementedError();
  }
}
