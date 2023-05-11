import 'package:dear_diary/src/pages/widgets/animated_logo_widget.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
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
    )));
  }
}
