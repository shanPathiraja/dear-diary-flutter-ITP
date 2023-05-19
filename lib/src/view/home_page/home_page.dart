import 'package:dear_diary/src/view/home_page/widget/battery_level_widget.ts.dart';
import 'package:dear_diary/src/view/home_page/widget/post_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widget/app_bar_widget.dart';
import '../../widget/routes/routes.dart';
import '../initial_page/auth_bloc/auth_bloc.dart';
import '../initial_page/auth_bloc/auth_state.dart';
import 'home_bloc.dart';
import 'home_state.dart';
import 'widget/create_post_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    final body = Scaffold(
      appBar: const CustomAppBar(
        text: "Dear Diary",
      ),
      backgroundColor: Colors.blueAccent,
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const BatteryLevel(),
            const CreatePost(),
            BlocBuilder<HomePageBloc, HomePageState>(
              buildWhen: (pre, current) => !identical(pre.posts, current.posts),
              builder: (context, state) {
                if (state.posts.isNotEmpty) {
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
                    child: Text("No Posts"),
                  );
                }
              },
            ),
          ],
        ),
      )),
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listenWhen: (previous, current) =>
              !current.isLoading && current.user == null,
          listener: (context, state) {
            Navigator.of(context).pushReplacementNamed(Routes.login);
          },
        ),
      ],
      child: body,
    );
  }
}
