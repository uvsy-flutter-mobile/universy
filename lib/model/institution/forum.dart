import 'dart:convert';
import 'package:universy/model/institution/subject.dart';
import 'package:universy/model/json.dart';

class ListForumPublication {
  final List<ForumPublication> _listForumPublication;

  ListForumPublication(this._listForumPublication);

  List<ForumPublication> get listForumPublication => _listForumPublication;

  factory ListForumPublication.fromJson(Map<String, dynamic> json) {
    List<ForumPublication> publications = (json['courses'] as List ?? [])
        .map(
          (publicationJson) => ForumPublication.fromJson(publicationJson),
        )
        .toList();
    return ListForumPublication(publications);
  }
}

class ForumPublication {
  String _idPublication;
  String _title;
  String _userId;
  String _description;
  DateTime _date;
  List<String> _tags;
  int _comments;
  String _userAlias;

  String get idPublication => _idPublication;

  String get title => _title;

  String get userId => _userId;

  String get description => _description;

  DateTime get date => _date;

  List<String> get tags => _tags;

  int get comments => _comments;

  String get userAlias => _userAlias;

  ForumPublication(this._idPublication, this._title, this._userId, this._description, this._date,
      this._comments, this._tags, this._userAlias);

  factory ForumPublication.fromJson(Map<String, dynamic> json) {
    //List<String> listTags = (json['tags'] as List ?? []).map((tag) => tag.toList().toString());
    int date = json["createdAt"];
    DateTime publicationDate = DateTime.fromMillisecondsSinceEpoch(date);
    return ForumPublication(json["id"], json["title"], json['userId'], json['description'],
        publicationDate, json["comments"], [], json["userAlias"]);
  }

  @override
  Map<String, String> toJson() {
    return {
      "id": _idPublication.toString(),
      "title": _title,
      "student": _userId,
      "description": _idPublication.toString(),
      "date": _date.toString(),
    };
  }
}

class ForumPublicationRequest extends JsonConvertible {
  int _idPublication;
  String _title;
  String _userId;
  String _description;
  String _programId;
  List<String> _tags;

  int get idPublication => _idPublication;

  String get title => _title;

  String get userId => _userId;

  String get programId => _programId;

  String get description => _description;

  List<String> get tags => _tags;

  ForumPublicationRequest(
      this._title, this._userId, this._description, this._tags, this._programId);

  @override
  Map<String, dynamic> toJson() {
    var a = jsonEncode(this.tags);
    print(a);
    return {
      "title": "${this._title}",
      "description": "${this._description}",
      "userId": "${this._userId}",
      "programId": "${this._programId}",
      "tags": this._tags,
    };
  }
}

class Comment {
  int _idPublication;
  int _idComment;
  String _userAlias;
  String _userId;
  DateTime _date;
  String _description;
  int _votes;

  int get idPublication => _idPublication;

  int get idComment => _idComment;

  String get userAlias => _userAlias;

  String get userId => _userId;

  DateTime get date => _date;

  String get description => _description;

  int get votes => _votes;

  Comment(this._idPublication, this._idComment, this._userAlias, this._userId, this._date,
      this._description, this._votes);

  factory Comment.fromJson(Map<String, dynamic> json) {
    int date = json["createdAt"];
    DateTime publicationDate = DateTime.fromMillisecondsSinceEpoch(date);
    return Comment(json["publicationId"], json["id"], json["userAlias"], json["userId"],
        publicationDate, json['description'], json['votes']);
  }

  @override
  Map<String, String> toJson() {
    return {
      "id": _idPublication.toString(),
      //"student": _profile.toJson().toString(),
      "description": _description,
      "date": _date.toString(),
    };
  }
}

class Filters {
  int _selectedLevel;
  InstitutionSubject _selectedSubject;
  DateTime _dateFrom;
  DateTime _dateTo;
  List<String> _uploadTags;

  int get selectedLevel => _selectedLevel;

  InstitutionSubject get selectedSubject => _selectedSubject;

  DateTime get dateFrom => _dateFrom;

  DateTime get dateTo => _dateTo;

  List<String> get uploadTags => _uploadTags;

  Filters(
      this._selectedLevel, this._selectedSubject, this._dateFrom, this._dateTo, this._uploadTags);
}
