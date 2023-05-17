import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/post_model.dart';
import '../../repository/post_repository.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  final PostRepository _postRepository = PostRepository();
  bool _isDisposed = false;

  PostCubit() : super(const PostInitial());

  Future<void> getPosts() async {
    emit(const PostLoading());
    try {
      final posts = await _postRepository.mockPost();
      print(posts);
      emit(PostLoaded(posts));
    } catch (e) {
      if (!_isDisposed) {
        emit(const PostError("Error getting posts"));
      }
    }
  }

  Future<void> addPost({required Post post}) async {
    emit(const PostLoading());
    try {
      await _postRepository.addPost(post);
      final posts = await _postRepository.getPosts();
      emit(PostLoaded(posts));
    } catch (e) {
      emit(const PostError("Error adding post"));
    }
  }

  @override
  Future<void> close() {
    _isDisposed = true;
    return super.close();
  }
}
