import 'package:dear_diary/src/pages/widgets/rounded_button_widget.dart';
import 'package:dear_diary/src/pages/widgets/text_box_widget.dart';
import 'package:flutter/material.dart';

import '../../util/validators.dart';

class RegisterStep1 extends StatefulWidget {
  final Function(String) onSubmitEmail;

  const RegisterStep1({super.key, required this.onSubmitEmail});

  @override
  State<RegisterStep1> createState() => _RegisterStep1State();
}

class _RegisterStep1State extends State<RegisterStep1> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isSubmitEnable = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
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
            validator: (value) => Validators.isValidEmail(value),
            labelText: 'Email',
            obscureText: false,
          ),
          const SizedBox(height: 20),
          RoundedButton(
            label: "Continue",
            onPressed: _isSubmitEnable ? () {
              widget.onSubmitEmail(_emailController.text);
            } : null,
          )
        ],
      ),
    );
  }
}
