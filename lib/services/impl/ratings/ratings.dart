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
    _instance = null;
  }

  @override
  Future<CourseRating> getCourseRating(String courseId) async {
    try {
      var career = await ratingsApi.getCourseRating(courseId);
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
  Future<StudentCourseRating> getStudentCourseRating(String courseId) async {
    try {
      String userId = await DefaultAccountService.instance().getUserId();
      var career = await ratingsApi.getStudentCourseRating(userId, courseId);
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
  Future<void> saveStudentCourseRating(StudentCourseRating courseRating) async {
    try {
      String userId = await DefaultAccountService.instance().getUserId();
      var payload = StudentCourseRatingPayload(
          courseRating.overall,
          courseRating.difficulty,
          courseRating.wouldTakeAgain,
          courseRating.tags);
      await ratingsApi.saveStudentCourseRating(
          userId, courseRating.courseId, payload);
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
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
