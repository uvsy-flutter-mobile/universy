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
  int _votes;
  String _idVoteUser;
  bool _isReported;

  String get idPublication => _idPublication;

  String get title => _title;

  String get userId => _userId;

  String get description => _description;

  DateTime get date => _date;

  List<String> get tags => _tags;

  int get comments => _comments;

  String get userAlias => _userAlias;

  int get votes => _votes;

  String get idVoteUser => _idVoteUser;

  bool get isReported => _isReported;

  set votes(int value) {
    _votes = value;
  }

  set idVoteUser(String value) {
    _idVoteUser = value;
  }

  ForumPublication(this._idPublication, this._title, this._userId, this._description, this._date,
      this._comments, this._tags, this._userAlias, this._votes, this._idVoteUser, this._isReported);

  factory ForumPublication.fromJson(Map<String, dynamic> json) {
    List<String> listTags = (json['tags'] as List ?? []).map((tag) => tag.toString()).toList();
    int date = json["createdAt"];
    DateTime publicationDate = DateTime.fromMillisecondsSinceEpoch(date);
    return ForumPublication(
        json['id'],
        json['title'],
        json['userId'],
        json['description'],
        publicationDate,
        json['comments'],
        listTags,
        json['userAlias'],
        json['votes'],
        json['userVoteId'],
        json['reported']);
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
    return {
      "title": "${this._title}",
      "description": "${this._description}",
      "userId": "${this._userId}",
      "programId": "${this._programId}",
      "tags": this._tags,
    };
  }
}

class ForumPublicationUpdateRequest extends JsonConvertible {
  String _idPublication;
  String _title;
  String _description;
  List<String> _tags;

  String get idPublication => _idPublication;

  String get title => _title;

  String get description => _description;

  List<String> get tags => _tags;

  ForumPublicationUpdateRequest(this._title, this._description, this._tags, this._idPublication);

  @override
  Map<String, dynamic> toJson() {
    return {
      "title": "$_title",
      "description": "$_description",
      "tags": this.tags,
    };
  }
}

class Comment extends JsonConvertible {
  String _idPublication;
  String _idComment;
  String _userAlias;
  String _userId;
  DateTime _date;
  String _content;
  int _votes;
  String _voteId;
  bool _isReported;

  String get idPublication => _idPublication;

  String get idComment => _idComment;

  String get userAlias => _userAlias;

  String get userId => _userId;

  DateTime get date => _date;

  String get content => _content;

  int get votes => _votes;

  String get voteId => _voteId;

  bool get isReported => _isReported;

  Comment(this._idPublication, this._idComment, this._userAlias, this._userId, this._date,
      this._content, this._votes, this._voteId, this._isReported);

  factory Comment.fromJson(Map<String, dynamic> json) {
    int date = json["createdAt"];
    DateTime publicationDate = DateTime.fromMillisecondsSinceEpoch(date);
    bool reported = (json['reported'] == null) ? false : true;
    return Comment(json["publicationId"], json["id"], json["userAlias"], json["userId"],
        publicationDate, json['content'], json['votes'], json['userVoteId'], reported);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": _idPublication.toString(),
      "description": _content,
      "date": _date.toString(),
    };
  }
}

class CommentRequest extends JsonConvertible {
  String _userId;
  String _idPublication;
  String _content;

  String get userId => _userId;

  String get idPublication => _idPublication;

  String get content => _content;

  @override
  Map<String, String> toJson() {
    return {
      "userId": this._userId,
      "content": this._content,
      "publicationId": this._idPublication,
    };
  }

  CommentRequest(this._userId, this._content, this._idPublication);
}

class VotePublicationRequest extends JsonConvertible {
  String _userId;
  String _idPublication;

  String get userId => _userId;

  String get idPublication => _idPublication;

  @override
  Map<String, String> toJson() {
    return {
      "userId": this._userId,
      "publicationId": this._idPublication,
    };
  }

  VotePublicationRequest(this._userId, this._idPublication);
}

class VoteCommentRequest extends JsonConvertible {
  String _userId;
  String _idComment;

  String get userId => _userId;

  String get idComment => _idComment;

  @override
  Map<String, String> toJson() {
    return {
      "userId": this._userId,
      "commentId": this._idComment,
    };
  }

  VoteCommentRequest(this._userId, this._idComment);
}
