import 'package:flutter/material.dart';
import 'package:perfect/services/auth_service.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController emailCotroller = TextEditingController();
  TextEditingController passwordCotroller = TextEditingController();
  TextEditingController nameCotroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Signup')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameCotroller,
              decoration: const InputDecoration(
                labelText: 'Nom',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            // TextField(decoration: const InputDecoration(labelText: 'name')),
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
                setState(() {
                  AuthService().createUser(
                    nameCotroller.text,
                    emailCotroller.text,
                    passwordCotroller.text,
                  );
                });
                // Handle signup logic here
              },
              child: const Text('Créer un compte'),
            ),
          ],
        ),
      ),
    );
  }
}
