import 'package:dear_diary/src/navigation/routes.dart';
import 'package:dear_diary/src/pages/login_page.dart';
import 'package:dear_diary/src/pages/register_page_two.dart';
import 'package:dear_diary/src/pages/widgets/animated_logo_widget.dart';
import 'package:dear_diary/src/pages/widgets/rounded_button_widget.dart';
import 'package:dear_diary/src/pages/widgets/text_box_widget.dart';
import 'package:flutter/material.dart';

import '../util/validators.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isSubmitEnable = false;

  void onSubmitEmail() {
    Navigator.pushNamed(
      context,
      Routes.registerTwo,
      arguments: RegisterStepTwoArgs(email: _emailController.text.trim()),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
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
                    Form(
                      key: _formKey,
                      onChanged: () => setState(() {
                        _isSubmitEnable = _formKey.currentState!.validate();
                      }),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          CustomTextBox(
                            controller: _emailController,
                            validator: (value) =>
                                Validators.isValidEmail(value),
                            labelText: 'Email',
                            obscureText: false,
                          ),
                          const SizedBox(height: 20),
                          RoundedButton(
                            label: "Continue",
                            onPressed: _isSubmitEnable
                                ? () {
                                    onSubmitEmail();
                                  }
                                : null,
                          ),
                          TextButton(
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
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
