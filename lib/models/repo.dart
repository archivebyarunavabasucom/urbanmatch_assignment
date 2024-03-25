class Repo {
  final String name;
  final String description;

  Repo({required this.name, required this.description});

  factory Repo.fromJson(Map<String, dynamic> json) {
    return Repo(
      name: json['name'],
      description: json['description'] ?? 'No description available.',
    );
  }
}
