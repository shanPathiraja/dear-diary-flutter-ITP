import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? id;
  String? title;
  String? content;
  String? date;
  String? userId;

  Post({this.title, this.content});

  Post.fromMap(Map<String, dynamic> map, {this.id}) {
    title = map['title'];
    content = map['content'];
    date = map['date'];
    userId = map['userId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'date': date,
      'userId': userId,
    };
  }

  getTitle() {
    return title;
  }

  getContent() {
    return content;
  }
}
