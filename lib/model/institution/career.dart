import 'package:universy/model/copyable.dart';
import 'package:universy/model/json.dart';

class InstitutionCareer
    implements Copyable<InstitutionCareer>, JsonConvertible {
  String _id;
  String _name;
  String _codename;

  InstitutionCareer(this._id, this._name, this._codename);

  String get codename => _codename;

  String get name => _name;

  String get id => _id;

  @override
  InstitutionCareer copy() {
    return InstitutionCareer.fromJson(this.toJson());
  }

  factory InstitutionCareer.fromJson(Map<String, dynamic> json) {
    return InstitutionCareer(
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
