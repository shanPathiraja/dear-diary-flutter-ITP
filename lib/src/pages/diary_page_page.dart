import 'package:dear_diary/src/bloc/post/event.dart';
import 'package:dear_diary/src/pages/widgets/app_bar_widget.dart';
import 'package:dear_diary/src/pages/widgets/battery_level_widget.ts.dart';
import 'package:dear_diary/src/pages/widgets/post_card_widget.dart';
import 'package:dear_diary/src/repository/post_repository.dart';
import 'package:dear_diary/src/repository/post_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/post/bloc.dart';
import '../bloc/post/state.dart';
import 'widgets/create_post_widget.dart';

class DiaryPage extends StatefulWidget {
  const DiaryPage({Key? key}) : super(key: key);

  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) => PostRepository(postService: PostService()),
            child: BlocProvider<PostBloc>(
        create: (context)=> PostBloc(context.read<PostRepository>())..add(GetPosts()),
              child: Scaffold(
                appBar: const CustomAppBar(
                  text: "Dear Diary",
                ),
                backgroundColor: Colors.blueAccent,
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      const BatteryLevel(),
                      CreatePost(),
                      BlocBuilder<PostBloc, PostState>(
                        builder: (context, state) {
                          print(state);
                          if (state.status != PostEventStatus.loading) {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.posts.length,
                              itemBuilder: (context, index) {
                                return PostCard(
                                  post: state.posts[index],

                                );
                              },
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
    ),
    
    );
  }
}
