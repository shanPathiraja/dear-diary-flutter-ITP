import 'dart:developer';

import 'package:bloc/bloc.dart';

import '../../repository/post_repository.dart';
import 'event.dart';
import 'state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;

  PostBloc(this.postRepository) : super(const PostState()) {
    on<GetPosts>(_mapGetPostsToState);
    on<AddPost>(_mapAddPostToState);

  }

  void _mapGetPostsToState(GetPosts event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostEventStatus.loading));
    log("Post map state");
    try {
       final posts = await postRepository.getPosts();
       emit(state.copyWith(status: PostEventStatus.success, posts: posts));
    } catch (e) {
      emit(state.copyWith(status: PostEventStatus.failure));
    }
  }
  void _mapAddPostToState (AddPost event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostEventStatus.loading));
    log("Post map state");
    try {
      await postRepository.addPost(event.post);
      final posts = await postRepository.getPosts();
      emit(state.copyWith(status: PostEventStatus.success, posts: posts));
    } catch (e) {
      emit(state.copyWith(status: PostEventStatus.failure));
    }
  }


}