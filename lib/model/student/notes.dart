import 'package:universy/constants/strings.dart';
import 'package:universy/model/copyable.dart';

class StudentNote implements Copyable<StudentNote> {
  final String _noteId;
  String title;
  String description;
  final DateTime _updatedAt;
  final DateTime _createdAt;

  StudentNote(this._noteId, this.title, this.description, this._updatedAt,
      this._createdAt);

  factory StudentNote.empty() {
    return StudentNote(EMPTY_STRING, EMPTY_STRING, EMPTY_STRING, DateTime.now(),
        DateTime.now());
  }

  String get noteId => _noteId;

  DateTime get updatedAt => _updatedAt;

  DateTime get createdAt => _createdAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentNote &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          description == other.description &&
          _updatedAt == other._updatedAt &&
          _createdAt == other._createdAt &&
          _noteId == other._noteId;

  @override
  int get hashCode =>
      title.hashCode ^
      description.hashCode ^
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

  @override
  StudentNote copy() {
    return StudentNote(
        _noteId,
        title,
        description,
        DateTime.fromMillisecondsSinceEpoch(_updatedAt.millisecondsSinceEpoch),
        DateTime.fromMillisecondsSinceEpoch(_createdAt.millisecondsSinceEpoch));
  }
}
