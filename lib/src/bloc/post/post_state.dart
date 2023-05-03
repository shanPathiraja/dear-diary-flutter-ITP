import 'package:dear_diary/src/models/post_model.dart';
import 'package:equatable/equatable.dart';

enum PostEventStatus {
  initial,
  loading,
  success,
  failure,
}

class PostState extends Equatable {
  final PostEventStatus status;
  final List<Post> posts;

  const PostState({
    this.status = PostEventStatus.initial,
    this.posts = const <Post>[],
  });

  @override
  List<Object?> get props => [status, posts];

  PostState copyWith({
    PostEventStatus? status,
    List<Post>? posts,
  }) {
    return PostState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
    );
  }
}
