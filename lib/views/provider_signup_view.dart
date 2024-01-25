import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/auth/cubit/auth_cubit.dart';
import 'package:social_media/components/my_button.dart';
import 'package:social_media/components/my_text_field.dart';

class ProviderSignUpView extends StatefulWidget {
  const ProviderSignUpView({super.key});

  @override
  State<ProviderSignUpView> createState() => _ProviderSignUpView();
}

class _ProviderSignUpView extends State<ProviderSignUpView> {
  final usernameController = TextEditingController();

  final firstNameController = TextEditingController();

  final lastNameController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
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
          Builder(builder: (context) {
            return MyButton(
              onTap: () {
                context.read<AuthCubit>().continueProviderSignUp(
                    firstNameController.text.trim(),
                    lastNameController.text.trim(),
                    usernameController.text.trim());
              },
              text: "Sign Up",
            );
          }),
          const SizedBox(height: 50)
        ],
      ),
    ));
  }
}
