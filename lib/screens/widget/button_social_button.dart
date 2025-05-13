import 'package:flutter/material.dart';

class ButtonSocialCustom extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  const ButtonSocialCustom({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        minimumSize: Size(48, 70),
        backgroundColor: Colors.white,
        elevation: 5,
      ),
      child: Image.asset(text, width: 30, height: 30),
    );
  }
}
