import 'package:dear_diary/src/view/initial_page/auth_bloc/auth_bloc.dart';
import 'package:dear_diary/src/view/initial_page/auth_bloc/auth_event.dart';
import 'package:dear_diary/src/widget/routes/routes.dart';
import 'package:dear_diary/src/widget/themes/custom_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc()..add(AppStarted()),
      child: MaterialApp(
        title: 'Dear Diary',
        theme: CustomThemes.lightTheme(context),
        onGenerateRoute: Routes.routes,
        initialRoute: Routes.splash,
      ),
    );
  }
}
