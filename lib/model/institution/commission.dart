import 'package:universy/constants/strings.dart';

class Commission {
  final String id;
  final String name;
  final String programId;
  final int level;

  Commission(this.id, this.name, this.programId, this.level);

  factory Commission.fromJson(Map<String, dynamic> json) {
    return Commission(
      json["id"],
      json["name"],
      json["programId"],
      json["level"],
    );
  }

  factory Commission.empty(String id) {
    return Commission(id, EMPTY_STRING, EMPTY_STRING, 0);
  }
}
