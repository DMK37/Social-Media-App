import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/auth/cubit/auth_cubit.dart';
import 'package:social_media/auth/cubit/auth_state.dart';
import 'package:social_media/components/my_button.dart';
import 'package:social_media/components/my_text_field.dart';
import 'package:social_media/components/square_tile.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

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
                          context.read<AuthCubit>().login(
                              emailController.text, passwordController.text);
                        },
                        text: "Sign In",
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
                              });
                        }),
                        const SizedBox(
                          width: 25,
                        ),
                        SquareTile(
                            imagePath: 'facebook.png',
                            onTap: () {
                              context.read<AuthCubit>().signInWithFacebook();
                            })
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Not a member?'),
                        const SizedBox(
                          width: 4,
                        ),
                        Builder(builder: (context) {
                          return GestureDetector(
                              onTap: () => context.go('/signup'),
                              child: const Text(
                                'Register now',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ));
                        })
                      ],
                    ),
                    const SizedBox(height: 50)
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
