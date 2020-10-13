import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/model/institution/ratings.dart';
import 'package:universy/model/institution/subject.dart';
import 'package:universy/modules/institution/dashboard/subjects/header/bloc/states.dart';
import 'package:universy/services/exceptions/student.dart';
import 'package:universy/services/manifest.dart';

import 'states.dart';

class HeaderFrontCardCubit extends Cubit<SubjectHeaderState> {
  final InstitutionSubject subject;
  final RatingsService ratingsService;

  HeaderFrontCardCubit(this.subject, this.ratingsService)
      : super(LoadingState());

  Future<void> fetchRating() async {
    SubjectRating rating;
    try {
      rating = await ratingsService.getSubjectRating(subject.id);
      emit(SubjectRatingFetchedState(subject, rating));
    } on RatingNotFound {
      emit(SubjectRatingNotFound(subject));
    }
  }
}
