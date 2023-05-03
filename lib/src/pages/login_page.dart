import 'package:dear_diary/src/bloc/auth/auth_bloc.dart';
import 'package:dear_diary/src/bloc/auth/auth_event.dart';
import 'package:dear_diary/src/dto/auth_dto.dart';
import 'package:dear_diary/src/pages/diary_page_page.dart';
import 'package:dear_diary/src/pages/widgets/animated_logo_widget.dart';
import 'package:dear_diary/src/pages/widgets/rounded_button_widget.dart';
import 'package:dear_diary/src/pages/widgets/text_box_widget.dart';
import 'package:dear_diary/src/services/auth_service.dart';
import 'package:dear_diary/src/util/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'register_page.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _enableSubmit = false;
  bool _isLoading = false;

  @override
  void initState() {
    _authService.getCurrentUser().then((value) {
      if (value != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const DiaryPage(),
          ),
        );
      }
    });
    super.initState();
  }

  void onSignInCompleted(AuthDto value) {
    if (value.isError) {
      String title;
      String content;
      switch (value.error?.code ?? "") {
        case "user-not-found":
          title = "User Not found";
          content = "Please check your email";
          break;
        case "network-request-failed":
          title = 'network request failed';
          content = "Please check internet connection";
          break;
        case "wrong-password":
          title = 'Invalid Password';
          content = "Please check Password and try again";
          break;
        default:
          title = 'Unknown Error';
          content = "Please try again later";
          break;
      }
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(title),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(content)],
                ),
                icon: const Icon(
                  Icons.error,
                  size: 50,
                ),
                iconColor: Colors.redAccent,
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Ok"))
                ],
              ));
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const DiaryPage(),
        ),
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      // _authService
      //     .signIn(_emailController.text.trim(), _passwordController.text.trim(),
      //         context)
      //     .then(onSignInCompleted);

      context.read<AuthBloc>().add(LogInRequested(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/blue_bg.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
          child: Form(
        onChanged: () => setState(() {
          _enableSubmit = _formKey.currentState!.validate();
        }),
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(20),
          width: 350,
          height: 470,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AnimatedLogo(width: 100),
              const SizedBox(height: 20),
              CustomTextBox(
                controller: _emailController,
                labelText: "Email",
                validator: (value) => Validators.isValidEmail(value),
                obscureText: false,
              ),
              const SizedBox(height: 20),
              CustomTextBox(
                controller: _passwordController,
                obscureText: true,
                validator: (value) => Validators.isValidPassword(value),
                labelText: 'Password',
              ),
              const SizedBox(height: 20),
              Visibility(
                visible: !_isLoading,
                replacement: const CircularProgressIndicator(),
                child: Column(
                  children: [
                    RoundedButton(
                      onPressed: _enableSubmit
                          ? () {
                              onSubmit();
                            }
                          : null,
                      label: 'Login',
                    ),
                    TextButton(
                      child: const Text(
                        'Don\'t have an account?',
                        style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Register(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    ));
  }
}
