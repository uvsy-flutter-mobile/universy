import 'package:universy/model/account/profile.dart';
import 'package:universy/model/account/token.dart';
import 'package:universy/model/account/user.dart';
import 'package:universy/model/institution/career.dart';
import 'package:universy/model/institution/institution.dart';
import 'package:universy/model/institution/program.dart';
import 'package:universy/model/institution/queries.dart';
import 'package:universy/model/institution/ratings.dart';
import 'package:universy/model/institution/subject.dart';
import 'package:universy/model/student/career.dart';
import 'package:universy/model/student/notes.dart';
import 'package:universy/model/student/ratings.dart';
import 'package:universy/model/student/session.dart';
import 'package:universy/model/student/subject.dart';
import 'package:universy/model/subject.dart';

/// Base Service
abstract class Service {
  void dispose();
}

/// Student Services
abstract class AccountService extends Service {
  Future<Token> getAuthToken();

  Future<String> getUserId();

  Future<bool> isLoggedIn();

  Future<void> logIn(User user);

  Future<void> signUp(User user);

  Future<void> confirmUser(User user, String code);

  Future<void> resendConfirmationCode(User user);

  Future<void> changePassword(User user, String newPassword);

  Future<void> forgotPassword(User user);

  Future<void> confirmPassword(User user, String newPassword);

  Future<void> logOut();
}

abstract class ProfileService extends Service {
  Future<Profile> getProfile();

  Future<void> updateProfile(Profile profile);

  Future<void> createProfile(Profile profile);

  Future<void> checkAliasProfile(Profile profile, String newAlias);
}

abstract class StudentCareerService extends Service {
  Future<String> getCurrentProgram();

  Future<void> setCurrentProgram(String programId);

  Future<List<StudentCareer>> getCareers();

  Future<StudentCareer> getCareer(String programId);

  Future<void> createCareer(String programId, int beingYear);

  Future<List<StudentSubject>> getSubjects(String programId);

  Future<void> updateSubject(Subject subject);
}

abstract class SessionService extends Service {
  Future<Session> getSession();
}

/// Institution Services
abstract class InstitutionService extends Service {
  Future<List<Institution>> getInstitutions();

  Future<List<InstitutionCareer>> getCareers(Institution institution);

  Future<List<InstitutionProgram>> getPrograms(InstitutionCareer career);

  Future<List<InstitutionProgramInfo>> getProgramsInfo(List<String> programIds);

  Future<List<InstitutionSubject>> getSubjects(String programId);
}

/// Ratings Service
abstract class RatingsService extends Service {
  Future<CourseRating> getCourseRating(String courseId);

  Future<SubjectRating> getSubjectRating(String subjectId);

  Future<StudentCourseRating> getStudentCourseRating(String courseId);

  Future<StudentSubjectRating> getStudentSubjectRating(String subjectId);

  Future<void> saveStudentCourseRating(StudentCourseRating courseRating);

  Future<void> saveStudentSubjectRating(StudentSubjectRating subjectRating);
}

/// Student Notes Services
abstract class StudentNotesService extends Service {
  Future<List<StudentNote>> getNotes();

  Future<StudentNote> getNote(String noteId);

  Future<void> createNote(String title, String description);

  Future<void> updateNote(String noteId, String title, String description);

  Future<void> deleteNote(String noteId);

  Future<void> batchDeleteNotes(List<StudentNote> notes);
}
