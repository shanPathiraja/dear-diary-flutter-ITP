import 'package:dear_diary/src/pages/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:dear_diary/src/models/post_model.dart';

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
        text: widget.post.getTitle(),
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
              widget.post.getTitle(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              widget.post.getContent(),
              style: const TextStyle(fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }
}
