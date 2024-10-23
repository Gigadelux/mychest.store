import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mychest/data/models/CartItem.dart';
import 'package:mychest/data/models/creditCard.dart';
import 'package:mychest/presentation/state_manager/providers/appProviders.dart';
import 'package:mychest/presentation/widgets/editCreditCard.dart';
import 'package:mychest/presentation/widgets/gradientButton.dart';
import 'package:mychest/presentation/widgets/gradientOutlineButton.dart';
import 'package:mychest/presentation/widgets/universal/RequestWidgetTree.dart';
import 'package:unicons/unicons.dart';

class Cartpage extends ConsumerStatefulWidget {
  const Cartpage({super.key});
  @override
  ConsumerState<Cartpage> createState() => _CartpageConsumerState();
}

class _CartpageConsumerState extends ConsumerState<Cartpage> {
  List<CartItem> cartItems = [];
  int responseCode = -1;
  String responseMessage = "";
  PageController pageController = PageController();
  int cart = -1;
  double totalPrice = 0;
  CreditCard card = CreditCard.empty();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_)async{
      await ref.read(CartNotifierProvider.notifier).initialize();
      setState(() {
        cartItems = ref.read(CartNotifierProvider).getObject.cartItems;
        responseCode = ref.read(CartNotifierProvider).getStatusCode;
      });
      double priceToSet = calculatePrice();
      CreditCard actual = ref.watch(ProfileNotifierProvider).creditCard;
      setState(() {
        totalPrice = priceToSet;
        card = actual;
      });
      print("NUMERO CREDITCARD: ${card.cardNumber}");
    });
  }
  double calculatePrice(){
    double res = 0;
    for(CartItem cartItem in cartItems){
      res += cartItem.quantity*cartItem.product.price;
    }
    return res;
  }
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isMobile = mediaQuery.size.width < 600;
    TextEditingController postalCodeController = TextEditingController();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(onPressed: ()=>Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 25,)),
              const Text("Cart", style: TextStyle(fontSize: 25, color: Colors.white),)
            ],
          ),
          cartItems.isNotEmpty && responseCode==200?
          RequestWidgetTree(
            loadingWidget: const CircularProgressIndicator(), 
            widget: SizedBox(
              height: MediaQuery.of(context).size.height/2.1,
              child: ListView(
                  children: List.generate(cartItems.length, (index)=>
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height/2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(cartItems[index].product.image, width:isMobile?mediaQuery.size.width/3: MediaQuery.of(context).size.width/3)),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(cartItems[index].product.name, style: const TextStyle(fontSize: 25),),
                                  Text(" X${cartItems[index].quantity}", style: TextStyle(fontSize: 25, color: Colors.grey[600]),)
                                ],
                              ),
                              const SizedBox(height: 10,),
                              Text("${cartItems[index].product.price*cartItems[index].quantity.toDouble()} ${r"$"}", style: const TextStyle(fontSize: 30),),
                            ],
                          )
                        ],
                      ),
                    )
                )
              ),
            ), 
            containerSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height/2), 
            responsecodeTextSize: 25, 
            errorTextSize: 20,
            responseCode: responseCode,
            responseMessage: responseMessage,
          )
          :
          SizedBox(
            height: MediaQuery.of(context).size.height/1.7,
            width: MediaQuery.of(context).size.width,
                  child: Center(
                      child: Text(
                  "Nothing to show here👀 (yet)",
                  style: TextStyle(color: Colors.grey[600], fontSize: 26),
                ))),
          cartItems.isNotEmpty && responseCode==200?
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: SizedBox(
                        width: 200,
                        child: TextField(
                          autocorrect: true,
                          style: const TextStyle(color: Colors.white, fontFamily: "Ubuntu"),
                          cursorColor: Colors.white,
                          autofocus: false,
                          minLines: 1,
                          maxLines: 1,
                          controller: postalCodeController,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: const InputDecoration(
                            labelText: "Postal Code",
                            labelStyle: TextStyle(color: Color.fromARGB(255, 163, 163, 163)),
                            fillColor: Color.fromARGB(255, 40, 40, 40),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(color: Colors.white, width: 10.0),
                              ),
                            contentPadding: EdgeInsets.all(0),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            //isDense: true,
                            alignLabelWithHint: true,
                          ),       
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        const Text("Credit card", style: TextStyle(fontSize: 25, color: Colors.white),),
                        Row(
                          children: [
                            const Icon(UniconsLine.credit_card, color: Colors.white, size: 60),
                            const SizedBox(width: 14),
                            Text(card.cardNumber, style: const TextStyle(fontSize: 25, color: Colors.white),),
                            const SizedBox(width: 14),
                            GradientOutLineButton(text: "edit", onPressed: ()async{await editCreditCardMenu(context, (){setState(() {
                              card = ref.watch(ProfileNotifierProvider).creditCard;
                            });}, (){}, ref);}, height: 40, width: 70),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                GradientButton(text: "Buy", onPressed: ()async{
                  await ref.read(CartNotifierProvider.notifier).pay(postalCodeController.text);
                  if(ref.read(CartNotifierProvider).getStatusCode != 200){
                    Fluttertoast.showToast(msg: "Failed to pay");
                    print(ref.read(CartNotifierProvider).errorMessage);
                    return;
                  }
                  Fluttertoast.showToast(msg: "Thank you!🥳");
                  Navigator.pop(context);
                }, height: 40,width: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Total", style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),),
                    Text(" $totalPrice", style: const TextStyle(fontSize: 20, color: Color.fromARGB(170, 255, 255, 255), fontWeight: FontWeight.w100),),
                  ],
                )
              ],
            ):const Text("")
        ],
      ),
    );
  }
}