import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/model/institution/subject.dart';
import 'package:universy/model/student/ratings.dart';
import 'package:universy/modules/institution/dashboard/subjects/header/bloc/back/states.dart';
import 'package:universy/modules/institution/dashboard/subjects/header/bloc/front/cubit.dart';
import 'package:universy/modules/institution/dashboard/subjects/header/bloc/states.dart';
import 'package:universy/services/exceptions/student.dart';
import 'package:universy/services/manifest.dart';

class HeaderBackCardCubit extends Cubit<SubjectHeaderState> {
  final InstitutionSubject subject;
  final RatingsService ratingsService;
  final HeaderFrontCardCubit frontCardCubit;
  final Function flipCard;

  HeaderBackCardCubit(
      this.subject, this.ratingsService, this.frontCardCubit, this.flipCard)
      : super(LoadingState());

  Future<void> fetchRating() async {
    try {
      StudentSubjectRating rating =
          await ratingsService.getStudentSubjectRating(subject.id);
      emit(StudentRatingFetchedState(rating));
    } on RatingNotFound {
      emit(StudentRatingNotFoundState());
    }
  }

  Future<void> saveRating(int rating) async {
    await ratingsService.saveStudentSubjectRating(subject.id, rating);
    await fetchRating();
    updateFrontCard();
  }

  Future<void> updateFrontCard() async {
    flip();
    await Future.delayed(Duration(seconds: 6));
    frontCardCubit.fetchRating();
  }

  void flip() {
    flipCard();
  }
}
