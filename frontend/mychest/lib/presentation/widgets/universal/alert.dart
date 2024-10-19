library alert;

import 'package:flutter/material.dart';
import 'package:mychest/global/colors/colorsScheme.dart';
import 'package:mychest/presentation/widgets/gradientButton.dart';


    Future<void> showAlert(BuildContext context, Widget toShow, Widget title, Function onPressed) async{
      await showGeneralDialog(
        barrierLabel: "Disclaimer",
        context: context, 
        pageBuilder: (context, animation, secondaryAnimation){
          return const Center(child: Text("qr_code"));
        },
        transitionBuilder: (context, animation, secondaryAnimation, child){
          return ScaleTransition(
            scale: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
            child: AlertDialog(
              title: title,
              content: toShow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: pageBackground,
              actions:[ 
                GradientButton(
                  text: "Ok", 
                  onPressed: (){
                    onPressed;
                    Navigator.pop(context);
                  }
                ),
              ]
            ),
          );
        },
      );
  }