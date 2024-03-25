import 'package:flutter/material.dart';
import '../models/commit.dart';
import '../services/github_api_service.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class CommitListScreen extends StatefulWidget {
  final String repoName;

  CommitListScreen({Key? key, required this.repoName}) : super(key: key);

  @override
  _CommitListScreenState createState() => _CommitListScreenState();
}

class _CommitListScreenState extends State<CommitListScreen> {
  late Future<List<Commit>> futureCommits;

  @override
  void initState() {
    super.initState();
    futureCommits = GithubApiService().fetchCommits(widget.repoName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.repoName} commits'),
      ),
      body: FutureBuilder<List<Commit>>(
        future: futureCommits,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length + 1, // Add one for the header
              itemBuilder: (BuildContext context, int index) {
                // Check if the index is for the header
                if (index == 0) {
                  // Header widget
                  return Container(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Commit History',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  );
                }
                // Adjust index to account for header
                final commitIndex = index - 1;
                return ListTile(
                  leading: Icon(FeatherIcons.gitCommit),
                  title: Text(snapshot.data![commitIndex].message),
                  subtitle: Text('Author: ${snapshot.data![commitIndex].author}'),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          // Display a loading spinner while waiting for the data
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
