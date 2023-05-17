import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dear_diary/src/repository/auth_repository.dart';
import 'package:http/http.dart' as http;

import '../models/post_model.dart';

class PostRepository {
  FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
  String? userId;

  PostRepository() {
    AuthRepository authRepository = AuthRepository();
    authRepository.getUser().then((value) => {userId = value.uid});
  }

  Future<void> addPost(Post post) async {
    post.date = DateTime.now().toString();
    post.userId = userId;
    await firestoreInstance.collection('posts').add(post.toMap());
  }

  Future<List<Post>> getPosts() async {
    QuerySnapshot querySnapshot = await firestoreInstance
        .collection('posts')
        .orderBy(
      'date',
          descending: true,
        )
        .get();
    List<Post> posts = [];
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      posts.add(Post.fromMap(data, id: doc.id));
    }
    return posts;
  }

  Future<List<Post>> mockPost() async {
    try {
      List<Post> posts = [];
      const url = 'https://6463211c7a9eead6faddf147.mockapi.io/api/post';
      var request = http.get(Uri.parse(url));
      var response = await request;
      var data = const JsonDecoder().convert(response.body);

      for (var post in data) {
        posts.add(Post.fromMap(post));
      }
      return posts;
    } catch (e) {
      throw Exception(e);
    }
  }
}
