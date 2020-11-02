/*import 'package:flutter/material.dart';
import 'package:safeevents/http_services.dart';
import 'package:safeevents/UserModel.dart';

final HttpService httpService = HttpService();

class PostsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Posts"),
      ),
      body: FutureBuilder(
        future: httpService.getPosts(),
        builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
          if (snapshot.hasData) {
            List<Post> posts = snapshot.data;

            return ListView(
              children: posts
                  .map((Post post) => ListTile(
                        title: Text(post.cookie),
                        subtitle: Text(post.timeout.toString()),
                      ))
                  .toList(),
            );
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }
}
*/
