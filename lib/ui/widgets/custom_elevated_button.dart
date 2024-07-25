import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String textButton;
  final Color? backgroundColor;
  final  void Function()? onPressed;

  const CustomElevatedButton({super.key,required this.onPressed,required this.textButton,this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child:Text(
        textButton,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
