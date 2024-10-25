import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mychest/data/models/enums/product_type.dart';
import 'package:mychest/data/models/product.dart';
import 'package:mychest/global/colors/colorsScheme.dart';
import 'package:mychest/presentation/state_manager/providers/appProviders.dart';
import 'package:mychest/presentation/widgets/gradientButton.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class ProductPage extends ConsumerStatefulWidget {
  final Product product;
  const ProductPage({Key? key, required this.product}) : super(key: key);

  @override
  ConsumerState<ProductPage> createState() => _ProductPageConsumerState();
}

class _ProductPageConsumerState extends ConsumerState<ProductPage> {
  int productQuantity = 0;

  List<Widget> resposiveWidgets(bool isMobile){
    return [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    widget.product.image, 
                    width:isMobile? MediaQuery.of(context).size.width-30 : MediaQuery.of(context).size.width/3,
                    errorBuilder: (context, error, stackTrace) => Text('error loading image ${error.toString()}', style: const TextStyle(color: Colors.white),),
                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Center(
                          child: LinearProgressIndicator(
                          value: 
                            loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                              : null,
                          ),
                        );
                      }
                    },
                  ),
                ),
                Column(
                  children: [
                    Row(children: [
                      iconTypes[widget.product.type],
                    Text(widget.product.name, style: TextStyle(color: Colors.grey[600], fontSize: 18, fontWeight: FontWeight.bold),),
                    ],),
                    Row(
                      children: [
                        Text(widget.product.name, style: const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
                      ],
                    ),
                    const SizedBox(height: 15,),
                    Row(children: [
                    Text("${widget.product.price}", style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),
                    Text(" - ${widget.product.quantity} left", style: TextStyle(color: Colors.grey[600], fontSize: 30, fontWeight: FontWeight.w100),),
                    ],),
                    const SizedBox(height: 8,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(onPressed: ()=>setState(() {
                            if(productQuantity>0) {
                              productQuantity = productQuantity-1;
                            }
                          }), icon: const Icon(Icons.remove_rounded, color: Colors.white,size: 22,)),
                          const SizedBox(width: 8,),
                          GradientText("$productQuantity", style: const TextStyle(color: Colors.white, fontSize: 22),colors: gradient,),
                          const SizedBox(width: 8,),
                          IconButton(onPressed: (){
                            if(widget.product.quantity>productQuantity) {
                              setState(() {
                                productQuantity = productQuantity+1;
                              });
                            }
                          }, icon: const Icon(Icons.add_rounded, color: Colors.white,size: 22,)),
                        ]),
                    ),
                    const SizedBox(height: 10,),
                    GradientButton(text: "Add to cart", onPressed: addToCart)
                    ]),
          ];
      }
  Future<void> addToCart()async{
    bool authenticated = !(ref.watch(TokenNotifierProvider) == null || ref.watch(TokenNotifierProvider)!.isEmpty);
    if(!authenticated){
      Fluttertoast.showToast(msg: "Login first🥺", toastLength: Toast.LENGTH_SHORT);
      return;
    }
    try{
      await ref.read(CartNotifierProvider.notifier).addItem(widget.product.name, productQuantity);
    }catch(e){print(e);}
    if(ref.watch(CartNotifierProvider).getStatusCode!=200){
      print(ref.watch(CartNotifierProvider).errorMessage);
      Fluttertoast.showToast(msg: 'Error adding cart');
      return;
    }else{
      Fluttertoast.showToast(msg: 'Added x$productQuantity 🥳');
    }
    setState(() {
      productQuantity = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isMobile = mediaQuery.size.width < 600;
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: SizedBox(
              height: isMobile?MediaQuery.of(context).size.height-100:MediaQuery.of(context).size.height/1.8,
              width: MediaQuery.of(context).size.width-20,
              child: Column(
                children: [
                  isMobile?
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: resposiveWidgets(isMobile),
                  ):
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: resposiveWidgets(isMobile),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: isMobile? null: MediaQuery.of(context).size.width/6-10,
                              ),
                              Text('Platforms: ', style: TextStyle(color: Colors.grey[600], fontSize: 20, fontWeight: FontWeight.w200),),
                              Text(widget.product.platforms, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),              
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: isMobile? null: MediaQuery.of(context).size.width/6-10,
                              ),
                              SizedBox(
                                width: isMobile? MediaQuery.of(context).size.width-20:null,
                                child: Text(widget.product.description, style: TextStyle(color: Colors.grey[500], fontSize: 20, fontWeight: FontWeight.normal),)
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(onPressed: ()=>Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white,size: 30,)))
        ],
      ),
    );
  }
}