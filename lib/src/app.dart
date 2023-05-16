import 'package:dear_diary/src/navigation/routes.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dear Diary',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: Routes.routes,
      initialRoute: Routes.splash,
    );
  }
}
