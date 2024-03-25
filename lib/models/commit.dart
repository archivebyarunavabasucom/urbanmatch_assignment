class Commit {
  final String message;
  final String author;

  Commit({required this.message, required this.author});

  factory Commit.fromJson(Map<String, dynamic> json) {
    return Commit(
      message: json['commit']['message'],
      author: json['commit']['author']['name'],
    );
  }
}
