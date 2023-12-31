import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String imagePath;
  final String providerName;
  final Function() onTap;
  const LoginButton(
      {super.key,
      required this.imagePath,
      required this.providerName,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50),
      child: TextButton(
        onPressed: onTap,
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(Theme.of(context).colorScheme.surface),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Image(image: AssetImage("images/$imagePath"), height: 30.0),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    'Sign in with $providerName',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
