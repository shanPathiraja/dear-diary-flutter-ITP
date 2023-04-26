import 'package:dear_diary/src/pages/login_page.dart';
import 'package:dear_diary/src/pages/widgets/animated_logo_widget.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'diary_page_page.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<StatefulWidget> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  final AuthService _authService = AuthService();

  @override
  void initState() {
    _authService.getCurrentUser().then((value) {
      Future.delayed(const Duration(seconds: 5)).then((value) => {
            if (value != null)
              {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const DiaryPage(),
                  ),
                ),
              }
            else
              {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const Login(),
                  ),
                ),
              }
          });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
         AnimatedLogo(width: 200,),
          Text(
            "Dear Diary",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
          )
        ],
      ),
    )));
  }
}
