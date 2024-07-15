import 'package:flutter/material.dart';
import 'package:social_media_app/constants/routes.dart';
import 'package:social_media_app/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify email'),
        centerTitle: true,
      ),
      body: Column(children: [
        const Text("Email Verification is send. Please verify your account"),
        FittedBox(
          fit: BoxFit.cover,
          child: const Text(
              'If verification link is not accessed to you, press the button below.'),
        ),
        TextButton(
          onPressed: () async {
            AuthService.firebase().sendEmailVerification();
          },
          child: Text('Send email verification'),
        ),
        TextButton(
          onPressed: () async {
            AuthService.firebase().logOut();
            Navigator.of(context)
                .pushNamedAndRemoveUntil(registerRoute, (route) => false);
          },
          child: Text('Restart'),
        ),
      ]),
    );
  }
}
