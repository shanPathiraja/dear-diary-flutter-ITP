import 'dart:developer';

import 'package:dear_diary/src/services/post_service.dart';
import 'package:flutter/material.dart';
import '../../models/post.dart';
import '../diary_page_page.dart';

typedef OnCreatePostSuccess = void Function();

class CreatePost extends StatefulWidget {
  final OnCreatePostSuccess onCreatePostSuccess;

  const CreatePost({super.key, required this.onCreatePostSuccess});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  bool isExpended = false;
  bool isLoading = false;

  onSubmit() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      Post post = Post(
        title: _titleController.text,
        content: _contentController.text,
      );
      PostService postService = PostService();
      postService.save(post).then((value) => {
            log("Post saved!"),
            setState(() {
              isExpended = false;
              isLoading = false;
            }),
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (BuildContext context) => const DiaryPage(),
            ),)
          });
    }
  }
  @override
  void dispose(){
    _contentController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: isExpended,
          replacement: ElevatedButton(
            onPressed: () {
              setState(() {
                isExpended = true;
              });
            },
            child: const Text('Add Post'),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            width: 400,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.indigoAccent,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      labelText: 'Title',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: TextFormField(
                      controller: _contentController,
                      minLines: 3,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.indigoAccent,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        labelText: 'Content',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some content';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: onSubmit,
                    child: const Text('Create Post'),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
