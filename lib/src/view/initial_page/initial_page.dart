import 'package:dear_diary/src/widget/animated_logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widget/routes/routes.dart';
import 'auth_bloc/auth_bloc.dart';
import 'auth_bloc/auth_state.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<StatefulWidget> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final body = Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              AnimatedLogo(
                width: 200,
              ),
              Text(
                "Dear Diary",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
              )
            ],
          ),
        ),
      ),
    );

    return MultiBlocListener(listeners: [
      BlocListener<AuthBloc, AuthState>(
        listenWhen: (previous, current) =>
            !current.isLoading && current.user != null,
        listener: (context, state) {
          Navigator.of(context).pushReplacementNamed(Routes.home);
        },
      ),
      BlocListener<AuthBloc, AuthState>(
        listenWhen: (previous, current) =>
            !current.isLoading && current.user == null,
        listener: (context, state) {
          Navigator.of(context).pushReplacementNamed(Routes.login);
        },
      ),
    ], child: body);
  }
}
