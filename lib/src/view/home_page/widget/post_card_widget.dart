import 'package:flutter/material.dart';

import '../../../db/models/post_model.dart';
import '../../../widget/routes/routes.dart';
import '../../post_display_page/post_display_page.dart';

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.postDisplay,
            arguments: PostDisplayArgs(post: post));
      },
      child: Card(
        color: Colors.white.withOpacity(0.4),
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
            padding: const EdgeInsets.all(15),
            child: Align(
              child: Column(
                children: [
                  Text(
                    post.getTitle()??"",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    post.getContentTruncated(75) ?? "",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  TextButton(
                      onPressed: () => {}, child: const Text('see more')),
                ],
              ),
            )),
      ),
    );
  }
}
