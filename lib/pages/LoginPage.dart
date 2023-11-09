import 'package:flutter/material.dart';
import 'package:social_media/components/MyButton.dart';
import 'package:social_media/components/MyTextField.dart';
import 'package:social_media/components/SquareTile.dart';

class LoginPage extends StatelessWidget {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  LoginPage({super.key});

  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            const Icon(
              Icons.lock,
              size: 100,
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              "Welcome Back!",
              style: TextStyle(color: Colors.grey[700], fontSize: 16),
            ),
            const SizedBox(
              height: 25,
            ),
            MyTextField(
              controller: usernameController,
              hintText: 'Username',
              obscureText: false,
            ),
            const SizedBox(
              height: 10,
            ),
            MyTextField(
              controller: passwordController,
              hintText: 'Password',
              obscureText: true,
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Forgot Your Password?',
                      style: TextStyle(color: Colors.grey[600]))
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            MyButton(
              onTap: signUserIn,
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: [
                  Expanded(
                      child: Divider(
                    color: Colors.grey[400],
                    thickness: 0.5,
                  )),
                  Text(
                    'Or Continue With',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  Expanded(
                      child: Divider(
                    color: Colors.grey[400],
                    thickness: 0.5,
                  ))
                ],
              ),
            ),
            Row(children: [SquareTile(imagePath: 'lib/images/google.png'),
            SquareTile(imagePath: 'lib/images/apple.png')],)
          ],
        ),
      ),
    );
  }
}
