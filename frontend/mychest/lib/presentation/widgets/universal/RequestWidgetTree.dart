import 'package:flutter/material.dart';

class RequestWidgetTree extends StatelessWidget {
  final Widget loadingWidget;
  final Widget widget;
  final int responseCode;
  final String? responseMessage;
  final Size containerSize;
  final double responsecodeTextSize;
  final double errorTextSize;

  const RequestWidgetTree({
    Key? key,
    required this.loadingWidget,
    required this.widget,
    this.responseCode = -1,
    this.responseMessage,
    required this.containerSize,
    required this.responsecodeTextSize,
    required this.errorTextSize
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(responseCode == -1){
      return loadingWidget;
    }
    else if(responseCode == 200){
      return widget;
    }
    else{
      return SizedBox(
        width: containerSize.width,
        height: containerSize.height,
        child: Column(
          children: [
            Text('ERROR $responseCode', style: TextStyle(color: Colors.white, fontSize: responsecodeTextSize),),
            Text(responseMessage??'', style: TextStyle(color: Colors.white, fontSize: errorTextSize),)
          ],
        ),
      );
    }
  }
}