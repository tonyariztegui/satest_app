// /lib/widgets/common_widgets/sign_in_form.dart

import 'package:flutter/material.dart';

class SignInForm extends StatefulWidget {
  final Function(String, String) onSignIn;
  final String? errorMessage;

  const SignInForm({Key? key, required this.onSignIn, this.errorMessage}) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _identifierController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _identifierController,
          decoration: const InputDecoration(labelText: 'Email or Username'),
          keyboardType: TextInputType.emailAddress,
        ),
        TextField(
          controller: _passwordController,
          decoration: const InputDecoration(labelText: 'Password'),
          obscureText: true,
        ),
        const SizedBox(height: 20),
        if (_isLoading) const CircularProgressIndicator(),
        if (widget.errorMessage != null)
          Text(widget.errorMessage!, style: const TextStyle(color: Colors.red)),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _isLoading
              ? null
              : () {
                  setState(() {
                    _isLoading = true;
                  });
                  widget.onSignIn(
                    _identifierController.text,
                    _passwordController.text,
                  ).whenComplete(() {
                    setState(() {
                      _isLoading = false;
                    });
                  });
                },
          child: const Text('Sign In'),
        ),
      ],
    );
  }
}
