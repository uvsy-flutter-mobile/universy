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
}
