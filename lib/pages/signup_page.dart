import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/auth/cubit/auth_cubit.dart';
import 'package:social_media/auth/cubit/auth_state.dart';
import 'package:social_media/components/my_button.dart';
import 'package:social_media/components/my_text_field.dart';
import 'package:social_media/components/square_tile.dart';
import 'package:social_media/router_config.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPagePageState();
}

class _SignUpPagePageState extends State<SignUpPage> {
  final usernameController = TextEditingController();

  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthenticatedState) {
            context.go('/');
          }
        },
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UnauthenticatedState) {
              return SafeArea(
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
                      controller: nameController,
                      hintText: 'name',
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
                    Builder(builder: (context) {
                      return MyButton(
                        onTap: () {
                          context.read<AuthCubit>().signUp(
                              emailController.text,
                              passwordController.text,
                              usernameController.text,
                              nameController.text);
                          AppRouter().router.go('/');
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Builder(builder: (context) {
                          return SquareTile(
                            imagePath: 'google.png',
                            onTap: () {
                              context.read<AuthCubit>().signInWithGoogle();
                            },
                          );
                        }),
                        const SizedBox(
                          width: 25,
                        ),
                        SquareTile(
                          imagePath: 'facebook.png',
                          onTap: () {
                            context.read<AuthCubit>().signInWithFacebook();
                          },
                        )
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
                            onTap: () => context.go('/login'),
                            child: const Text(
                              'Login Here',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                    const SizedBox(height: 50)
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ), // replace with your widget
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
