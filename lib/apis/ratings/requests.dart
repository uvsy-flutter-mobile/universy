import 'package:universy/model/json.dart';
import 'package:universy/model/student/subject.dart';

class StudentSubjectRatingPayload extends JsonConvertible {
  final int rating;

  StudentSubjectRatingPayload(this.rating);

  @override
  Map<String, dynamic> toJson() {
    return {
      "rating": rating,
    };
  }
}
