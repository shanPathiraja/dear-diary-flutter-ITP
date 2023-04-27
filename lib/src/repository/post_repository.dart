
import 'package:dear_diary/src/repository/post_service.dart';
import 'package:flutter/cupertino.dart';

import '../models/post_model.dart';

class PostRepository {
  final PostService postService;

  PostRepository({@required required this.postService});

  Future<void> addPost(Post post) async {
    return await postService.addPost(post);
  }

  Future<List<Post>> getPosts() async {
    return await postService.getPosts();
  }
}