import 'package:universy/apis/errors.dart';
import 'package:universy/apis/ratings/requests.dart';
import 'package:universy/model/institution/ratings.dart';
import 'package:universy/model/student/ratings.dart';
import 'package:universy/services/exceptions/service.dart';
import 'package:universy/services/exceptions/student.dart';
import 'package:universy/services/impl/student/account.dart';
import 'package:universy/services/manifest.dart';
import 'package:universy/util/logger.dart';
import 'package:universy/util/object.dart';
import 'package:universy/apis/ratings/api.dart' as ratingsApi;

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
  Future<StudentSubjectRating> getStudentSubjectRating(String subjectId) async {
    try {
      String userId = await DefaultAccountService.instance().getUserId();
      var career = await ratingsApi.getStudentSubjectRating(userId, subjectId);
      return career.orElseThrow(() => RatingNotFound());
    } on NotFound catch (e) {
      Log.getLogger().error(e);
      throw RatingNotFound();
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }

  @override
  Future<SubjectRating> getSubjectRating(String subjectId) async {
    try {
      var career = await ratingsApi.getSubjectRating(subjectId);
      return career.orElseThrow(() => RatingNotFound());
    } on NotFound catch (e) {
      Log.getLogger().error(e);
      throw RatingNotFound();
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }

  @override
  Future<void> saveStudentCourseRating(StudentCourseRating courseRating) {
    // TODO: implement saveStudentCourseRating
    throw UnimplementedError();
  }

  @override
  Future<void> saveStudentSubjectRating(String subjectId, int rating) async {
    try {
      String userId = await DefaultAccountService.instance().getUserId();
      var payload = StudentSubjectRatingPayload(rating);
      await ratingsApi.saveStudentSubjectRating(userId, subjectId, payload);
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }
}
