import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Home'),
          actions: [IconButton(onPressed: logout, icon: Icon(Icons.logout))]),
      body: Text(FirebaseAuth.instance.currentUser!.email!),
    );
  }
}
