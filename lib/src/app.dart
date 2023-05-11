import 'package:dear_diary/src/cubit/auth/auth_cubit.dart';
import 'package:dear_diary/src/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final _navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          _navigatorKey.currentState!.pushReplacementNamed(Routes.home);
        } else if (state is Unauthenticated) {
          _navigatorKey.currentState!.pushReplacementNamed(Routes.login);
        }
      },
      child: MaterialApp(
        title: 'Dear Diary',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        navigatorKey: _navigatorKey,
        onGenerateRoute: Routes.routes,
        initialRoute: Routes.splash,
      ),
    );
  }
}
