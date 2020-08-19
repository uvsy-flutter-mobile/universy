import 'package:universy/model/copyable.dart';
import 'package:universy/model/json.dart';

class Institution implements Copyable<Institution>, JsonConvertible {
  String _id;
  String _name;
  String _codename;

  Institution(this._id, this._name, this._codename);

  String get codename => _codename;

  String get name => _name;

  String get id => _id;

  @override
  Institution copy() {
    return Institution.fromJson(this.toJson());
  }

  factory Institution.fromJson(Map<String, dynamic> json) {
    return Institution(
      json["id"],
      json["name"],
      json["codename"],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": _id,
      "name": _name,
      "codename": _codename,
    };
  }
}
