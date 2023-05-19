import 'package:dear_diary/src/db/models/post_model.dart';
import 'package:dear_diary/src/widget/app_bar_widget.dart';
import 'package:flutter/material.dart';

class PostDisplayArgs {
  final Post post;

  const PostDisplayArgs({required this.post});
}

class PostDisplay extends StatefulWidget {
  final Post post;

  const PostDisplay({super.key, required this.post});

  @override
  State<PostDisplay> createState() => _PostDisplayState();
}

class _PostDisplayState extends State<PostDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: widget.post.getTitle() ?? "no-title",
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/blue_bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Text(
              widget.post.getTitle() ?? "no-title",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              widget.post.getContent() ?? "no-content",
              style: const TextStyle(fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }
}
