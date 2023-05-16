import 'package:dear_diary/src/cubit/auth/auth_cubit.dart';
import 'package:dear_diary/src/navigation/routes.dart';
import 'package:dear_diary/src/pages/widgets/animated_logo_widget.dart';
import 'package:dear_diary/src/pages/widgets/rounded_button_widget.dart';
import 'package:dear_diary/src/pages/widgets/text_box_widget.dart';
import 'package:dear_diary/src/util/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _enableSubmit = false;

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().signIn(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.home,
              (route) => false,
            );
          }
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
              ),
            );
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
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        if (state is AuthLoading) {
                          return const CircularProgressIndicator();
                        }
                        return Column(
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
                                Navigator.pushReplacementNamed(
                                    context, Routes.registerOne);
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
