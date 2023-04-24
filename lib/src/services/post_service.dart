import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/post_model.dart';
import 'auth_service.dart';

class PostService {
  String collectionPath = "posts";
  FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
  String? userId;

  PostService() {
    AuthService authService = AuthService();
    authService.getUserId().then((value) => {userId = value});
  }

  Future<List<Post>> getPosts() async {
    QuerySnapshot querySnapshot = await firestoreInstance
        .collection(collectionPath)
        .where('userId', isEqualTo: userId)
        .get();
    List<Post> posts = [];
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      posts.add(Post.fromMap(data, id: doc.id));
    }
    return posts;
  }

  Future<void> save(Post post) async {
    post.date = DateTime.now().toString();
    post.userId = userId;
    if (post.id == null) {
      await firestoreInstance.collection('posts').add(post.toMap());
    } else {
      await firestoreInstance
          .collection('posts')
          .doc(post.id)
          .update(post.toMap());
    }
  }
}
