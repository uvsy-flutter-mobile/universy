class Professor {
  final String _name;
  final String _lastName;

  String get name => _name;

  String get lastName => _lastName;

  Professor(this._name, this._lastName);

  factory Professor.fromJson(Map<String, dynamic> json) {
    return Professor(
      json["name"],
      json["lastName"],
    );
  }

  Map<String, String> toJson() {
    return {
      "name": _name,
      "lastname": _lastName,
    };
  }
}
