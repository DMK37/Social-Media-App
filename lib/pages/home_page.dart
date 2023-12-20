import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/auth/cubit/auth_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home'), actions: [
        Builder(builder: (context) {
          return IconButton(
              onPressed: () {
                context.read<AuthCubit>().logout();
                context.go('/login');
              },
              icon: const Icon(Icons.logout));
        })
      ]),
      body: Text(FirebaseAuth.instance.currentUser!.email!),
    );
  }
}
