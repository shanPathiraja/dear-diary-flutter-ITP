part of 'post_cubit.dart';

@immutable
abstract class PostState {
  const PostState();
}

class PostInitial extends PostState {
  const PostInitial();
}

class PostLoading extends PostState {
  const PostLoading();
}

class PostLoaded extends PostState {
  final List<Post> posts;

  const PostLoaded(this.posts);
}

class PostError extends PostState {
  final String errorMessage;

  const PostError(this.errorMessage);
}
