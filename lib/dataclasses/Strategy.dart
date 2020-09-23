class Strategy {
  String name;
  String description;

  Strategy({
    this.name,
    this.description,
  });

  factory Strategy.fromJson(Map<String, dynamic> json) {
    return Strategy(
        name: json["name"] as String,
        description: json["description"] as String,);
  }
}
