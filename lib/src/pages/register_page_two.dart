import 'package:dear_diary/src/bloc/auth/auth_state.dart';
import 'package:dear_diary/src/pages/diary_page_page.dart';
import 'package:dear_diary/src/pages/login_page.dart';
import 'package:dear_diary/src/pages/widgets/animated_logo_widget.dart';
import 'package:dear_diary/src/pages/widgets/rounded_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_event.dart';
import '../util/validators.dart';

class RegisterStepTwo extends StatefulWidget {
  final String email;

  const RegisterStepTwo({super.key, required this.email});

  @override
  State<RegisterStepTwo> createState() => _RegisterStepTwoState();
}

class _RegisterStepTwoState extends State<RegisterStepTwo> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  bool _isSubmitEnabled = false;

  void onSubmitPassword() async {
    context.read<AuthBloc>().add(
          RegisterRequested(
            email: widget.email,
            password: _passwordController.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const DiaryPage(),
              ),
            );
          }
          if (state is AuthError) {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text(state.title),
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text(state.message)],
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
          }
        },
        child: Container(
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
                        _isSubmitEnabled = _formKey.currentState!.validate();
                      }),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          TextFormField(
                            obscureText: true,
                            controller: _passwordController,
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                color: Colors.black,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            validator: Validators.isValidPassword,
                          ),
                          const SizedBox(height: 20),
                          RoundedButton(
                            label: "Register",
                            onPressed: _isSubmitEnabled
                                ? () {
                                    onSubmitPassword();
                                  }
                                : null,
                          ),
                        ],
                      ),
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
