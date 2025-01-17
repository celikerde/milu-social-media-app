import 'package:flutter/material.dart';
import 'package:social_media_app/constants/routes.dart';
import 'package:social_media_app/firebase_options.dart';
import 'package:social_media_app/services/auth/auth_service.dart';
import 'package:social_media_app/services/auth/auth_user.dart';
import 'package:social_media_app/views/create_post.dart';
import 'package:social_media_app/views/login_view.dart';
import 'package:social_media_app/views/post_view.dart';
import 'package:social_media_app/views/register_view.dart';
import 'package:social_media_app/views/verify_email_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        verifyEmailRoute: (context) => const VerifyEmailView(),
        postsRoute: (context) => const PostView(),
        createPost: (context) => const CreatePost(),
      },
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user != null) {
              if (user.isEmailVerified) {
                return const PostView();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }
          default:
            return const CircularProgressIndicator(); // TODO: Handle this case.
        }
      },
    );
  }
}
