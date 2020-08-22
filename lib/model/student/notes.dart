import 'package:universy/constants/strings.dart';

class StudentNote {
  final String _title;
  final String _description;
  final String _noteId;
  final DateTime _updatedAt;
  final DateTime _createdAt;

  StudentNote(this._noteId, this._title, this._description, this._updatedAt,
      this._createdAt);

  factory StudentNote.empty() {
    return StudentNote(EMPTY_STRING, EMPTY_STRING, EMPTY_STRING, DateTime.now(),
        DateTime.now());
  }

  String get title => _title;

  String get description => _description;

  String get noteId => _noteId;

  DateTime get updatedAt => _updatedAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentNote &&
          runtimeType == other.runtimeType &&
          _title == other._title &&
          _description == other._description &&
          _updatedAt == other._updatedAt &&
          _createdAt == other._createdAt &&
          _noteId == other._noteId;

  @override
  int get hashCode =>
      _title.hashCode ^
      _description.hashCode ^
      _noteId.hashCode ^
      _createdAt.hashCode ^
      _updatedAt.hashCode;

  factory StudentNote.fromJson(Map<String, dynamic> json) {
    var updatedAt = DateTime.fromMillisecondsSinceEpoch(json["updatedAt"]);
    var createdAt = DateTime.fromMillisecondsSinceEpoch(json["createdAt"]);
    return StudentNote(
      json["noteId"],
      json["title"],
      json["description"],
      updatedAt,
      createdAt,
    );
  }
}
