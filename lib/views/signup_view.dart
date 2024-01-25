import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/auth/cubit/auth_cubit.dart';
import 'package:social_media/components/login_button.dart';
import 'package:social_media/components/my_button.dart';
import 'package:social_media/components/my_text_field.dart';

class SignUpView extends StatefulWidget {
  final String? errorMessage;
  const SignUpView({super.key, this.errorMessage});
  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final usernameController = TextEditingController();

  final firstNameController = TextEditingController();

  final lastNameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ListView(
          children: [
            const SizedBox(
              height: 50,
            ),
            const Image(
              image: AssetImage('images/photocraft.png'),
              height: 100,
              width: 100,
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              "Register",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
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
              controller: firstNameController,
              hintText: 'First Name',
              obscureText: false,
            ),
            const SizedBox(
              height: 10,
            ),
            MyTextField(
              controller: lastNameController,
              hintText: 'Last Name',
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
              height: 25,
            ),
            Builder(builder: (context) {
              return MyButton(
                onTap: () {
                  context.read<AuthCubit>().signUp(
                      emailController.text.trim(),
                      passwordController.text.trim(),
                      firstNameController.text.trim(),
                      lastNameController.text.trim(),
                      usernameController.text.trim());
                  //context.go('/');
                },
                text: "Sign Up",
              );
            }),
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
            LoginButton(
                imagePath: "google.png",
                providerName: "Google",
                onTap: () {
                  context.read<AuthCubit>().signInWithGoogle();
                }),
            const SizedBox(
              height: 10,
            ),
            LoginButton(
                imagePath: "facebook.png",
                providerName: "Facebook",
                onTap: () {
                  context.read<AuthCubit>().signInWithFacebook();
                }),
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
                    onTap: () => context.go('/login'),
                    child: const Text(
                      'Login Here',
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ))
              ],
            ),
            const SizedBox(height: 50)
          ],
        ),
      );
  }
}
