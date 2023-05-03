import 'package:dear_diary/src/pages/login_page.dart';
import 'package:dear_diary/src/pages/widgets/animated_logo_widget.dart';
import 'package:dear_diary/src/pages/widgets/register_step_one_widget.dart';
import 'package:dear_diary/src/pages/widgets/register_step_two_widget.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import 'diary_page_page.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email = '';
  bool isEmailSubmitted = false;
  bool isLoading = false;
  final AuthService _authService = AuthService();

  void onSubmitEmail(String email) {
    setState(() {
      this.email = email;
      isEmailSubmitted = true;
    });
  }

  void onSubmitPassword(String password) async {
    setState(() {
      isLoading = true;
    });
    _authService.signUp(email, password).then((authData) => {
          if (authData.isError)
            {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Registration Failed"),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [Text("Please try again")],
                  ),
                  icon: const Icon(
                    Icons.error,
                    size: 50,
                  ),
                  iconColor: Colors.redAccent,
                  actions: [
                    MaterialButton(
                      child: const Text("Ok"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
              setState(() {
                isLoading = false;
                isEmailSubmitted = false;
              }),
            }
          else
            {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const DiaryPage(),
                ),
              )
            }
        });
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: 350,
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AnimatedLogo(
                      width: 100,
                    ),
                    Visibility(
                      visible: isEmailSubmitted,
                      replacement: RegisterStep1(
                        onSubmitEmail: onSubmitEmail,
                      ),
                      child: RegisterStep2(
                        onSubmitPassword: onSubmitPassword,
                        isLoading: isLoading,
                      ),
                    ),
                    Visibility(
                      visible: !isLoading,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Login(),
                            ),
                          );
                        },
                        child: const Text(
                          'Already have an account? Login here',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
