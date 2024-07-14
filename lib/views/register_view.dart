import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media_app/constants/routes.dart';
import 'package:social_media_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

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
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Column(
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
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                        final user = FirebaseAuth.instance.currentUser;
                        await user?.sendEmailVerification();
                        Navigator.of(context).pushNamed(verifyEmailRoute);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'invalid-email') {
                          showErrorDialog(
                            context,
                            'Invalid email',
                          );
                        } else if (e.code == "weak-password") {
                          showErrorDialog(
                            context,
                            'Weak password',
                          );
                        } else if (e.code == "email-already-in-use") {
                          showErrorDialog(
                            context,
                            'Email already in use',
                          );
                        } else {
                          showErrorDialog(
                            context,
                            "Error ${e.code}",
                          );
                        }
                      } catch (e) {
                        showErrorDialog(
                          context,
                          e.toString(),
                        );
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
              );
            default:
              return CircularProgressIndicator(); // TODO: Handle this case.
          }
        },
      ),
    );
  }
}
