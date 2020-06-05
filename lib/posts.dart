import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostsPage extends StatelessWidget {
  final String postsURL = "http://192.168.0.104/news_en.json";

  Future<List> getPosts() async {
    try {
      final res = await http.get(postsURL);
      if (res.statusCode == 200) {
        return jsonDecode(res.body)["articles"];
      } else {
        return throw "Can't get posts.";
      }
    } catch (e) {
      throw "Can't get posts.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Posts"),
      ),
      body: FutureBuilder(
        future: getPosts(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            List posts = snapshot.data;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(children: [
                  ListTile(
                    title: Text(posts[index]["title"]),
                  ),
                  ListTile(
                    title: Text(posts[index]["snippet"]),
                  ),
                ]);
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
