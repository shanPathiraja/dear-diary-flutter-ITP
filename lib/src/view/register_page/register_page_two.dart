import 'package:dear_diary/src/widget/animated_logo_widget.dart';
import 'package:dear_diary/src/widget/rounded_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../util/validators.dart';
import '../../widget/routes/routes.dart';
import '../initial_page/auth_bloc/auth_bloc.dart';
import '../initial_page/auth_bloc/auth_event.dart';
import '../initial_page/auth_bloc/auth_state.dart';

class RegisterStepTwoArgs {
  final String email;

  const RegisterStepTwoArgs({required this.email});
}

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
  late AuthBloc _authBloc;

  void onSubmitPassword(AuthBloc bloc) async {
    bloc.add(
      RegisterRequested(
        email: widget.email,
        password: _passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _authBloc = BlocProvider.of<AuthBloc>(context);

    final body = Scaffold(
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
                          ),
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          validator: Validators.isValidPassword,
                        ),
                        const SizedBox(height: 20),
                        BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                          if (state.isLoading) {
                            return const CircularProgressIndicator();
                          }
                          return Column(
                            children: [
                              RoundedButton(
                                label: "Register",
                                onPressed: _isSubmitEnabled
                                    ? () {
                                        onSubmitPassword(_authBloc);
                                      }
                                    : null,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushReplacementNamed(Routes.login);
                                },
                                child: const Text(
                                  'Already have an account? Login here',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    return MultiBlocListener(listeners: [
      BlocListener<AuthBloc, AuthState>(
        listenWhen: (previous, current) => current.user != null,
        listener: (context, state) {
          Navigator.of(context).pushReplacementNamed(Routes.home);
        },
      ),
      BlocListener<AuthBloc, AuthState>(
          listenWhen: (previous, current) =>
              previous.isLoading &&
              current.errorMessage != null &&
              current.errorTitle != null,
          listener: (context, state) {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text(state.errorTitle!),
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text(state.errorMessage!)],
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
          }),
    ], child: body);
  }
}
