import 'package:dear_diary/src/view/home_page/home_page_provider.dart';
import 'package:dear_diary/src/view/login_page/login_page.dart';
import 'package:dear_diary/src/view/post_display_page/post_display_page.dart';
import 'package:dear_diary/src/view/register_page/register_page.dart';
import 'package:dear_diary/src/view/register_page/register_page_two.dart';
import 'package:dear_diary/src/view/splash_page/initial_page.dart';
import 'package:flutter/material.dart';

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
        return buildRoute(HomePageProvider());
      case postDisplay:
        final args = settings.arguments as PostDisplayArgs;
        return buildRoute(PostDisplay(post: args.post));
      default:
        throw Exception('Invalid route: ${settings.name}');
    }
  }
}
