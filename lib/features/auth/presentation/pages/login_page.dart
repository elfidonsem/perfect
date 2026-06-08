import 'package:flutter/material.dart';
import 'package:perfect/features/auth/presentation/pages/home_page.dart';
import 'package:perfect/services/auth_service.dart';
import 'package:sign_in_button/sign_in_button.dart';

import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailCotroller = TextEditingController();
  TextEditingController passwordCotroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailCotroller,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: passwordCotroller,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle login logic here
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 16),
            SignInButton(
              .google,
              onPressed: () {
                setState(() async {
                  await AuthService().signInWithGoogle();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                });
              },
            ),
            // Add a button to navigate to the signup page
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                // Navigate to the signup page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignupPage()),
                );
              },
              child: const Text('Don\'t have an account? Sign up'),
            ),
          ],
        ),
      ),
    );
  }
}
