import 'package:dear_diary/src/pages/diary_page_page.dart';
import 'package:dear_diary/src/pages/initial_page.dart';
import 'package:dear_diary/src/pages/login_page.dart';
import 'package:dear_diary/src/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/auth/auth_bloc.dart';
import 'bloc/auth/auth_event.dart';
import 'bloc/auth/auth_state.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Dear Diary',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:RepositoryProvider(
          create: (context)=> AuthRepository(),
          child: BlocProvider(
            create: (context)=> AuthBloc(context.read<AuthRepository>())..add(AppStarted()),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/blue_bg.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state.status == AuthStatus.authenticated) {
                    return const DiaryPage();
                  } else if (state.status == AuthStatus.unauthenticated) {
                    return const Login();
                  } else {
                    return const Center(
                      child: InitialPage(),
                    );
                  }
                },
              ),
            ),
          ),
        ),
    );
  }

}



