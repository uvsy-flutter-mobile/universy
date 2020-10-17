class Commission {
  final String id;
  final String name;
  final String programId;
  final int level;

  Commission._(this.id, this.name, this.programId, this.level);

  factory Commission.fromJson(Map<String, dynamic> json) {
    return Commission._(
      json["id"],
      json["name"],
      json["programId"],
      json["level"],
    );
  }
}
