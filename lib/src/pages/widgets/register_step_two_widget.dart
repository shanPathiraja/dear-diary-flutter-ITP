import 'package:dear_diary/src/pages/widgets/rounded_button_widget.dart';
import 'package:flutter/material.dart';

class RegisterStep2 extends StatefulWidget {
  final Function(String) onSubmitPassword;
  final bool isLoading;

  const RegisterStep2({super.key, required this.onSubmitPassword, required this.isLoading});

  @override
  State<RegisterStep2> createState() => _RegisterStep2State();
}

class _RegisterStep2State extends State<RegisterStep2> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  bool _isSubmitEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Form(
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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
           Visibility(
             visible: widget.isLoading,
              replacement:RoundedButton(
                label: "Register",
                onPressed: _isSubmitEnabled
                    ? () {
                  widget.onSubmitPassword(_passwordController.text);
                }
                    : null,
              ) ,
              child: const CircularProgressIndicator())

        ],
      ),
    );
  }
}
