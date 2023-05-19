import 'dart:developer';

import 'package:bloc/bloc.dart';

import '../../db/repository/post_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomePageBloc extends Bloc<PostEvent, HomePageState> {
  late final PostRepository postRepository;

  HomePageBloc() : super(HomePageState.initialState) {
    postRepository = PostRepository();
    on<GetPosts>(_mapGetPostsToState);
    on<AddPost>(_mapAddPostToState);
  }

  void _mapGetPostsToState(GetPosts event, Emitter<HomePageState> emit) async {
    emit(state.clone(isLoading: true));
    log("Post map state");
    try {
      final posts = await postRepository.getPosts();
      emit(state.clone(posts: posts, isLoading: false));
    } catch (e) {
      emit(state.clone(errorMessage: e.toString(), isLoading: false));
    }
  }

  void _mapAddPostToState(AddPost event, Emitter<HomePageState> emit) async {
    emit(state.clone(isLoading: true));
    log("Post map state");
    try {
      await postRepository.addPost(event.post);
      final posts = await postRepository.getPosts();
      emit(state.clone(posts: posts, isLoading: false));
    } catch (e) {
      emit(state.clone(errorMessage: e.toString(), isLoading: false));
    }
  }
}
