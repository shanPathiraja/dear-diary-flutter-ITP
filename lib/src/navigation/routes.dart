import 'package:dear_diary/src/pages/diary_page_page.dart';
import 'package:dear_diary/src/pages/initial_page.dart';
import 'package:dear_diary/src/pages/login_page.dart';
import 'package:dear_diary/src/pages/register_page.dart';
import 'package:dear_diary/src/pages/register_page_two.dart';
import 'package:flutter/material.dart';

import '../pages/post_display_page.dart';

class Routes {
  static const splash = '/';
  static const login = '/login';
  static const registerOne = '/register_one';
  static const registerTwo = '/register_two';
  static const home = '/home';
  static const postDisplay = 'postDisplay';

  static Route routes(RouteSettings settings) {
    MaterialPageRoute buildRoute(Widget widget) {
      return MaterialPageRoute(
          builder: (context) => widget, settings: settings);
    }

    switch (settings.name) {
      case splash:
        return buildRoute(const InitialPage());
      case login:
        return buildRoute(const Login());
      case registerOne:
        return buildRoute(const Register());
      case registerTwo:
        final args = settings.arguments as RegisterStepTwoArgs;
        return buildRoute(RegisterStepTwo(email: args.email));
      case home:
        return buildRoute(const DiaryPage());
      case postDisplay:
        final args = settings.arguments as PostDisplayArgs;
        return buildRoute(PostDisplay(post: args.post));
      default:
        throw Exception('Invalid route: ${settings.name}');
    }
  }
}
