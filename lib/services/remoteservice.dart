import 'dart:convert';
import 'package:flutter_task_broken/model/comment.dart';
import 'package:flutter_task_broken/model/post.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  Future<List<Posts>?> getPosts() async {
    String apiUrl = 'https://jsonplaceholder.typicode.com/posts';

    var response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      List<Posts> posts =
      jsonResponse.map((data) => Posts.fromJson(data)).toList();
      return posts;
    }
    return null;
  }

  Future<List<Comments>?> getComment({
    String? commentId,
  }) async {
    String apiUrl = 'https://jsonplaceholder.typicode.com/comments';

    Map<String, String> queryParameters = {
      if (commentId != null) 'id': commentId,
    };

    var uri = Uri.parse(apiUrl).replace(queryParameters: queryParameters);

    var response = await http.get(uri);

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      List<Comments> comments =
      jsonResponse.map((data) => Comments.fromJson(data)).toList();
      return comments;
    }
    return null;
  }
}
