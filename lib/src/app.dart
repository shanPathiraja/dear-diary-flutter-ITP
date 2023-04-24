import 'package:dear_diary/src/pages/diary_page_page.dart';
import 'package:dear_diary/src/pages/initial_page.dart';
import 'package:dear_diary/src/pages/login_page.dart';
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
        home:  Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/blue_bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: const InitialPage(),
        )
    );
  }

}



