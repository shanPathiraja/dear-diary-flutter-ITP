import 'package:dear_diary/src/util/validators.dart';
import 'package:dear_diary/src/widget/animated_logo_widget.dart';
import 'package:dear_diary/src/widget/rounded_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widget/routes/routes.dart';
import '../initial_page/auth_bloc/auth_bloc.dart';
import '../initial_page/auth_bloc/auth_event.dart';
import '../initial_page/auth_bloc/auth_state.dart';

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
  bool _isLoading = false;
  late AuthBloc _authBloc;

  void onSubmit(AuthBloc authBloc) {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      authBloc.add(LogInRequested(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim()));
    }
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
              TextFormField(
                controller: _emailController,
                validator: (value) => Validators.isValidEmail(value),
                obscureText: false,
                decoration: const InputDecoration(
                  labelText: "Email",
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                validator: (value) => Validators.isValidPassword(value),
                decoration: const InputDecoration(
                  labelText: "Password",
                ),
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
                              onSubmit(_authBloc);
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
                        Navigator.of(context)
                            .pushReplacementNamed(Routes.registerOne);
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
      BlocListener<AuthBloc, AuthState>(
        listenWhen: (previous, current) =>
            previous.isLoading != current.isLoading,
        listener: (context, state) {
          setState(() {
            _isLoading = state.isLoading;
          });
        },
      )
    ], child: body);
  }
}
