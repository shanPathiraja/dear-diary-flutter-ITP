import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dear_diary/src/models/post_model.dart';

import '../services/auth_service.dart';

class PostService{
  FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
  String? userId;

  PostService(){
    AuthService authService = AuthService();
    authService.getUserId().then((value) => {userId = value});
  }

  Future<void> addPost(Post post) async {
    post.date = DateTime.now().toString();
    post.userId = userId;
    await firestoreInstance.collection('posts').add(post.toMap());
  }

  Future<List<Post>> getPosts() async {
    QuerySnapshot querySnapshot = await firestoreInstance
        .collection('posts')
        .get();
    List<Post> posts = [];
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      posts.add(Post.fromMap(data, id: doc.id));
    }
    return posts;
  }

  Stream<List<Post>> getPostStream() {
    return firestoreInstance.collection('posts').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Post.fromMap(doc.data(), id: doc.id)).toList();
    });
  }
}