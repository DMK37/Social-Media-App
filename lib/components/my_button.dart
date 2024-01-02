import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key, required this.onTap, required this.text});
  final Function()? onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return 
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        child: TextButton(
          onPressed: onTap,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.tertiary),
            shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
          ),
          child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,  vertical: 7),
                child: Text(text,
                    style: Theme.of(context).textTheme.titleMedium),
              ),
          
        ),
      )
    ;
  }
}
