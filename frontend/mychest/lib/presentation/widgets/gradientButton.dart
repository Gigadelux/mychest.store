import 'package:flutter/material.dart';
import 'package:mychest/global/colors/colorsScheme.dart';

class GradientButton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  final double? width;
  final double? height;
  const GradientButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.height,
    this.width
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(colors: gradient),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(text, style: const TextStyle(color: Colors.white, fontFamily: "Ubuntu", fontWeight: FontWeight.bold),),
          ),
        ),
      ),
    );
  }
}