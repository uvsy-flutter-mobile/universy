import 'package:flutter_tags/flutter_tags.dart';
import 'package:universy/model/account/profile.dart';

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
  int _idPublication;
  String _title;
  Profile _profile;
  String _description;
  DateTime _date;
  List<Comment> _comments;
  List<String> _tags;

  int get idPublication => _idPublication;

  String get title => _title;

  Profile get profile => _profile;

  String get description => _description;

  DateTime get date => _date;

  List<Comment> get comments => _comments;

  List<String> get tags => _tags;


  ForumPublication(this._idPublication, this._title, this._profile, this._description, this._date,
      this._comments,this._tags);

  factory ForumPublication.fromJson(Map<String, dynamic> json) {
    List<Comment> listComment = (json['comments'] as List ?? []).map((comment) => Comment.fromJson(comment)).toList();
    List<String> listTags = (json['tags'] as List ?? []).map((tag) => tag.toList());
    Profile profile = Profile.fromJson(json['student']);
    return ForumPublication(json["id"], json["title"], profile, json['description'], json['date'],
        listComment,listTags);
  }

  @override
  Map<String, String> toJson() {
    return {
      "id": _idPublication.toString(),
      "title": _title,
      "student": _profile.toJson().toString(),
      "description": _idPublication.toString(),
      "date": _date.toString(),
      "comments": _comments.map((comment) => comment.toJson()).toList().toString(),
    };
  }
}

class Comment {
  int _idPublication;
  Profile _profile;
  String _description;
  DateTime _date;

  int get idPublication => _idPublication;

  Profile get profile => _profile;

  String get description => _description;

  DateTime get date => _date;

  Comment(this._idPublication, this._profile, this._description, this._date);

  factory Comment.fromJson(Map<String, dynamic> json) {
    Profile profile = Profile.fromJson(json['student']);
    return Comment(json["id"], profile, json['description'], json['date']);
  }

  @override
  Map<String, String> toJson() {
    return {
      "id": _idPublication.toString(),
      "student": _profile.toJson().toString(),
      "description": _description,
      "date": _date.toString(),
    };
  }
}

class Filters {
  int _selectedLevel;
  String _selectedType;
  DateTime _dateFrom;
  DateTime _dateTo;
  List<String> _uploadTags;

  int get selectedLevel => _selectedLevel;

  String get selectedType => _selectedType;

  DateTime get dateFrom => _dateFrom;

  DateTime get dateTo => _dateTo;

  Filters(this._selectedLevel, this._selectedType, this._dateFrom, this._dateTo, this._uploadTags);
}
