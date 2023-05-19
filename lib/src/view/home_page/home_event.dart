import 'package:dear_diary/src/db/models/post_model.dart';
import 'package:equatable/equatable.dart';

abstract class PostEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetPosts extends PostEvent {
 @override
  List<Object> get props => [];
}
class AddPost extends PostEvent {
  final Post post;

  AddPost({required this.post});

  @override
  List<Object> get props => [post];
}