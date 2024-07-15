import 'package:flutter/material.dart';
import 'package:social_media_app/constants/routes.dart';
import 'package:social_media_app/services/auth/auth_exceptions.dart';
import 'package:social_media_app/services/auth/auth_service.dart';

import 'package:social_media_app/utilities/show_error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Register'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _email,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: 'Please enter an email address',
                    suffixIcon: IconButton(
                      onPressed: _email.clear,
                      icon: Icon(Icons.clear),
                    ),
                    border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _password,
                obscureText: true,
                autocorrect: false,
                enableSuggestions: false,
                decoration: const InputDecoration(
                  hintText: 'Please enter an password',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;
                try {
                  await AuthService.firebase().createUser(
                    email: email,
                    password: password,
                  );
                  AuthService.firebase().sendEmailVerification();
                  Navigator.of(context).pushNamed(verifyEmailRoute);
                } on WeakPasswordAuthException {
                  showErrorDialog(
                    context,
                    'Weak Password',
                  );
                } on InvalidEmailAuthException {
                  showErrorDialog(
                    context,
                    'Invalid email',
                  );
                } on EmailAlreadyInUseAuthException {
                  showErrorDialog(
                    context,
                    'Email already in use',
                  );
                } on GenericAuthException {
                  showErrorDialog(context, 'Registration failed');
                }
              },
              child: const Text('Register!'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  loginRoute,
                  (route) => false,
                );
              },
              child: const Text('You have an account? Login here!'),
            )
          ],
        ));
  }
}
