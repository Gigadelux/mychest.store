import 'package:flutter/material.dart';
import 'package:mychest/data/models/CartItem.dart';
import 'package:mychest/main.dart';
import 'package:mychest/presentation/widgets/universal/RequestWidgetTree.dart';

class Cartpage extends StatefulWidget {
  const Cartpage({super.key});
  @override
  State<Cartpage> createState() => _CartpageState();
}

class _CartpageState extends State<Cartpage> {
  List<CartItem> cartItems = [];
  int responseCode = -1;
  String responseMessage = "";
  PageController pageController = PageController();
  int cart = -1;
  @override
  void initState() {
    super.initState();
    cart = cartId!;
    //TODO initialize cartItems here
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 25,)),
            ],
          ),
          cartItems.isEmpty && responseCode==200?
          RequestWidgetTree(
            loadingWidget: const CircularProgressIndicator(), 
            widget: PageView(
                controller: pageController,
                children: List.generate(cartItems.length, (index)=> 
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height/2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.network(cartItems[index].product.image, width: MediaQuery.of(context).size.width/3),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(cartItems[index].product.name, style: const TextStyle(fontSize: 25),),
                                Text(" ${cartItems[index].quantity}", style: TextStyle(fontSize: 25, color: Colors.grey[600]),)
                              ],
                            ),
                            const SizedBox(height: 10,),
                            Text(cartItems[index].product.price.toString(), style: const TextStyle(fontSize: 30),),
                          ],
                        )
                      ],
                    ),
                  )
              )
            ), 
            containerSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height/2), 
            responsecodeTextSize: 25, 
            errorTextSize: 20,
            responseCode: responseCode,
            responseMessage: responseMessage,
          )
          :
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Nothing to show here👀 (yet)", style: TextStyle(color: Colors.grey[600], fontSize: 26),)
            ],
          )
        ],
      ),
    );
  }
}