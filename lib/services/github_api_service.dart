import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/repo.dart';
import '../models/commit.dart';

class GithubApiService {
  Future<List<Repo>> fetchRepos() async {
    var url = Uri.parse('https://api.github.com/orgs/freecodecamp/repos');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((dynamic item) => Repo.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load repos');
    }
  }

  Future<List<Commit>> fetchCommits(String repoName) async {
    var url = Uri.parse('https://api.github.com/repos/freecodecamp/$repoName/commits');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((dynamic item) => Commit.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load commits');
    }
  }
}
