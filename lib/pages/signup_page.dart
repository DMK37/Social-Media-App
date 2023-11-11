import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media/auth/display_message.dart';
import 'package:social_media/components/my_button.dart';
import 'package:social_media/components/my_text_field.dart';
import 'package:social_media/components/square_tile.dart';

class SignUpPage extends StatefulWidget {
  final void Function()? onTap;

  const SignUpPage({super.key, required this.onTap});

  @override
  State<SignUpPage> createState() => _SignUpPagePageState();
}

class _SignUpPagePageState extends State<SignUpPage> {
  final usernameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  void registerUserIn() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    if (passwordController.text != confirmPasswordController.text) {
      Navigator.pop(context);
      displayMessage("Passwords don't match", context);
    } else {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        if (context.mounted) {
          Navigator.pop(context);
        }
      } on FirebaseAuthException catch (e) {
        if (context.mounted) {
          Navigator.pop(context);
          displayMessage(e.code, context);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: ListView(
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
              textAlign: TextAlign.center,
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
              controller: emailController,
              hintText: 'Email',
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
            MyTextField(
              controller: confirmPasswordController,
              hintText: 'Confirm Password',
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
              onTap: registerUserIn,
              text: "Sign Up",
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
            const SizedBox(
              height: 50,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SquareTile(imagePath: 'https://i.imgur.com/8nRB4Mw.png'),
                SizedBox(
                  width: 25,
                ),
                SquareTile(imagePath: 'https://i.imgur.com/1UQNIgS.png')
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account?'),
                const SizedBox(
                  width: 4,
                ),
                GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      'Login Here',
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
