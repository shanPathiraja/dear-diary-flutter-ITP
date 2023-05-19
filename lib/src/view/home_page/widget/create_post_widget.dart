import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../db/models/post_model.dart';
import '../home_bloc.dart';
import '../home_event.dart';
import '../home_state.dart';

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
  late HomePageBloc _homePageBloc;
  bool isExpended = false;

  onSubmit(HomePageBloc bloc) {
    if (_formKey.currentState!.validate()) {
      Post post = Post(
        title: _titleController.text,
        content: _contentController.text,
      );
      bloc.add(AddPost(post: post));
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
    _homePageBloc = BlocProvider.of<HomePageBloc>(context);
    final body = Column(
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
                  BlocBuilder<HomePageBloc, HomePageState>(
                      builder: (context, state) {
                    if (state.isLoading) {
                      return const CircularProgressIndicator();
                    }
                    return ElevatedButton(
                      onPressed: () => onSubmit(_homePageBloc),
                      child: const Text('Submit'),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ],
    );
    return MultiBlocListener(listeners: [
      BlocListener<HomePageBloc, HomePageState>(
          listenWhen: (previous, current) => !current.isLoading,
          listener: (context, state) {
            setState(() {
              isExpended = false;
            });
          }),
    ], child: body);
  }
}
