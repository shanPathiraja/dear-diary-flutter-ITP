import 'package:dear_diary/src/models/post_model.dart';
import 'package:dear_diary/src/pages/widgets/app_bar_widget.dart';
import 'package:dear_diary/src/pages/widgets/battery_level_widget.ts.dart';
import 'package:dear_diary/src/pages/widgets/post_card_widget.dart';
import 'package:dear_diary/src/services/post_service.dart';
import 'package:flutter/material.dart';
import 'widgets/create_post_widget.dart';

class DiaryPage extends StatefulWidget {
  const DiaryPage({Key? key}) : super(key: key);

  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  List<Post> _posts = [];

  bool _isLoading = true;
  final PostService _postService = PostService();

  @override
  void initState() {
    super.initState();
    _postService.getPosts().then((p) => {
          setState(() {
            _posts = p;
            _isLoading = false;
          })
        });
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const BatteryLevel(),
            CreatePost(
              onCreatePostSuccess: () {
                setState(() {
                  _isLoading = false;
                });
              },
            ),
            Visibility(
                visible: !_isLoading,
                replacement: const CircularProgressIndicator(),
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: _posts.map((e) => PostCard(post: e)).toList(),
                ))
          ],
        ),
      ),
    );
  }
}
