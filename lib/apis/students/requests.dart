import 'package:universy/model/json.dart';

class UpdateProfileRequest extends JsonConvertible {
  final String name;
  final String lastName;
  final String alias;

  UpdateProfileRequest(this.name, this.lastName, this.alias);

  @override
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "lastName": lastName,
      "alias": alias,
    };
  }
}

class CreateNoteRequest extends JsonConvertible {
  final String title;
  final String description;

  CreateNoteRequest(this.title, this.description);

  @override
  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
    };
  }
}

class UpdateNoteRequest extends JsonConvertible {
  final String title;
  final String description;

  UpdateNoteRequest(this.title, this.description);

  @override
  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
    };
  }
}
