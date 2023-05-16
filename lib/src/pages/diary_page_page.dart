import 'package:dear_diary/src/cubit/post/post_cubit.dart';
import 'package:dear_diary/src/pages/widgets/app_bar_widget.dart';
import 'package:dear_diary/src/pages/widgets/battery_level_widget.ts.dart';
import 'package:dear_diary/src/pages/widgets/post_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/auth/auth_cubit.dart';
import '../navigation/routes.dart';
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
    return Scaffold(
      appBar: const CustomAppBar(
        text: "Dear Diary",
      ),
      backgroundColor: Colors.blueAccent,
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is Unauthenticated) {
            Navigator.of(context).pushReplacementNamed(Routes.login);
          }
        },
        child: BlocProvider<PostCubit>(
          create: (context) => PostCubit()..getPosts(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const BatteryLevel(),
                const CreatePost(),
                BlocBuilder<PostCubit, PostState>(
                  builder: (context, state) {
                    if (state is PostLoaded) {
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
