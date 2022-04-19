// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(
      String? email, String? password, String? userName, bool isLogin) submitFn;

  const AuthForm(
    this.submitFn, {
    Key? key,
  }) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final formKey = GlobalKey<FormState>();
  String? _email;
  String? _userName;
  String? _password;
  var _isLogin = true;

  void _trySubmit() {
    final isValid = formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      formKey.currentState!.save();
      widget.submitFn(
        _email!.trim(),
        _password!.trim(),
        _userName!.trim(),
        _isLogin,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    key: const ValueKey('email'),
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (val) {
                      _email = val;
                    },
                    validator: (value) {
                      if (value!.isEmpty || !value.contains("@")) {
                        return 'Please enter a valid email...';
                      }
                      return null;
                    },
                    decoration:
                        const InputDecoration(labelText: "Email address"),
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: const ValueKey('userName'),
                      onSaved: (val) {
                        _userName = val;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter user name...';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(labelText: "Username"),
                    ),
                  TextFormField(
                    key: const ValueKey('password'),
                    onSaved: (val) {
                      _password = val;
                    },
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 6) {
                        return 'password must be at least 6 characters long...';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(labelText: "Password"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    onPressed: _trySubmit,
                    child: Text(_isLogin ? "Login" : "SignUp"),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    child: Text(_isLogin
                        ? "Create new account"
                        : "I have already an account"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
