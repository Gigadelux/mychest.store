library alert;

import 'package:flutter/material.dart';
import 'package:mychest/global/colors/colorsScheme.dart';
import 'package:mychest/presentation/widgets/gradientButton.dart';


    Future<void> showAlert(BuildContext context, Widget toShow, Widget title, Function onPressed, Function onCancel) async{
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
              title: title,
              content: toShow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: pageBackground,
              actions:[ 
                GradientButton(
                  text: "Cancel", 
                  onPressed: (){
                    onCancel();
                    Navigator.pop(context);
                  }
                ), 
                GradientButton(
                  text: "Ok", 
                  onPressed: ()async{
                    bool? hasToPop = await onPressed();
                    if(hasToPop == null || !hasToPop) {
                      Navigator.pop(context);
                    }
                  }
                ),
              ]
            ),
          );
        },
      );
  }