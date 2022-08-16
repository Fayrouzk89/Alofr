class Bundles {
  Bundles(
      {required this.id,
        required this.name,
        required this.abilities,
        required this.height,
        required   this.stats,
        required  this.defaultImage});

  factory Bundles.fromJson(Map<dynamic, dynamic> json) {
    return Bundles(
        id: json['id'],
        name: json['name'],
        abilities: json['abilities'],
        height: json['height'],
        stats: json['stats'],
        defaultImage: json['sprites']['back_default']);
  }

  final int id;
  final String name;
  final List<dynamic> abilities;
  final int height;
  final List<dynamic> stats;
  final String defaultImage;
}