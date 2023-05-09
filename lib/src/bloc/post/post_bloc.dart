import 'dart:developer';

import 'package:bloc/bloc.dart';

import '../../repository/post_repository.dart';
import 'post_event.dart';
import 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  late final PostRepository postRepository;

  PostBloc() : super(const PostState()) {
    postRepository = PostRepository();
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
