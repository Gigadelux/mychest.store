import 'package:flutter/material.dart';
import 'package:gpt_markdown/custom_widgets/markdow_config.dart';
import 'package:mychest/core/API/AiAssistant.dart';
import 'package:mychest/global/colors/colorsScheme.dart';
import 'package:mychest/presentation/widgets/gradientButton.dart';
import 'package:gpt_markdown/gpt_markdown.dart';

class MiniChatBot extends StatefulWidget {
  const MiniChatBot({super.key});

  @override
  _MiniChatBotState createState() => _MiniChatBotState();
}

class _MiniChatBotState extends State<MiniChatBot> {
  // Variables to control the size of the container
  double _width = 0;
  double _height = 0;
  bool loading = true;
  String botMessage = "";
  bool aiLoading = false;
  

  void _toggleContainer() {
    setState(() {
      // Toggle between expanded and collapsed states
      if (_width == 0) {
        _width = 150;
        _height = 250;
      } else {
        _width = 0;
        _height = 0;
      }
    });
  }

  generateReccomend()async{
    setState(() {
      loading = true;
    });
    String res = "";
    Map response =await Aiassistant().reccomend();
    if(response['status']==200){
      res = response['botMessage'];
    }else{
      res = response['message'];
    }
    print(res);
    setState(() {
      loading = false;
      botMessage = res;
    });
  }

  refreshReccomend()async{
    setState(() {
      loading = true;
    });
    String res = "";
    Map response =await Aiassistant().refreshReccomend(botMessage);
    if(response['status']==200){
      res = response['botMessage'];
    }else{
      res = response['message'];
    }
    setState(() {
      loading = false;
      botMessage = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // AnimatedContainer that animates width and height changes
        AnimatedContainer(
          duration: const Duration(milliseconds: 300), // Duration of the animation
          width: _width,
          height: _height,
          decoration: BoxDecoration(
            color: Colors.white, // Background color of the container
            borderRadius: BorderRadius.circular(10), // Rounded corners
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 30,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                    gradient: LinearGradient(colors: gradient)
                  ),
                  child:const Center(
                    child: Text(
                    'Gaming assistant🎮',
                    style: TextStyle(color: Colors.white, fontSize: 14),),
                  ),
                ),
              ),
              !loading? 
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 200,
                    width: 140,
                    child: ListView(
                      children: [
                        TexMarkdown(
                          botMessage,
                          style: TextStyle(color: pageBackground),
                        ),
                        const SizedBox(height: 50,)
                      ],
                    ),
                  ),
                )
                :
              Center(child: CircularProgressIndicator(color: pageBackground,)
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 40,
                  width: 100,
                  child: GradientButton(text: "Others", onPressed: ()async{
                    if(loading) return;
                    await refreshReccomend();
                  })),
              )
            ],
          ),
        ),
        const SizedBox(height: 20),
        // Button to toggle the container
        FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: ()async{
          _toggleContainer();
          if(aiLoading) return;
          await generateReccomend();
          setState(() {
            aiLoading = true;
          });
        },
        child: ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              colors: gradient, // Gradient for the icon
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds);
          },
          child: const Icon(Icons.auto_awesome, color: Colors.white, size: 30,)),
      ),
      ],
    );
  }
}