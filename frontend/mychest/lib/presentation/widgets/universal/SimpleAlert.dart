library simpleAlert;

import 'package:flutter/material.dart';
import 'package:mychest/global/colors/colorsScheme.dart';
import 'package:mychest/presentation/widgets/gradientButton.dart';


    Future<void> showSimpleAlert(BuildContext context, String message) async{
      await showGeneralDialog(
        barrierLabel: "Disclaimer",
        context: context, 
        pageBuilder: (context, animation, secondaryAnimation){
          return const Center(child: Text("qr_code"));
        },
        transitionBuilder: (context, animation, secondaryAnimation, child){
          return ScaleTransition(
            scale: Tween<double>(begin: 0.2, end: 1.0).animate(animation),
            child: AlertDialog(
              title: Text(message, style: const TextStyle(fontSize: 25, color: Colors.white),),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: pageBackground,
              actions:[
                GradientButton(
                  text: "Ok", 
                  onPressed: ()=>Navigator.pop(context),
                ),
              ]
            ),
          );
        },
      );
  }