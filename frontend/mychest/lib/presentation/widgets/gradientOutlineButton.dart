import 'package:flutter/material.dart';
import 'package:mychest/global/colors/colorsScheme.dart';

class GradientOutLineButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final double width;
  final double height;
  const GradientOutLineButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.height,
    required this.width
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(colors: gradient),
            ),
          ),
          Center(
            child: Container(
              width: width-5,
              height: height-5,
              decoration: BoxDecoration(
                color: pageBackground,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(text, style: const TextStyle(color: Colors.white, fontFamily: "Ubuntu", fontWeight: FontWeight.bold),),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}