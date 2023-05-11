import 'package:dear_diary/src/cubit/post/post_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/post_model.dart';

typedef OnCreatePostSuccess = void Function();

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  bool isExpended = false;

  onSubmit() {
    if (_formKey.currentState!.validate()) {
      Post post = Post(
        title: _titleController.text,
        content: _contentController.text,
      );
      context.read<PostCubit>().addPost(post: post);
      _titleController.clear();
      _contentController.clear();
      setState(() {
        isExpended = false;
      });
    }
  }

  @override
  void dispose() {
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
