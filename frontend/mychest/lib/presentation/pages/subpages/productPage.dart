import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mychest/data/models/enums/product_type.dart';
import 'package:mychest/data/models/product.dart';
import 'package:mychest/presentation/state_manager/TokenNotifier.dart';
import 'package:mychest/presentation/state_manager/providers/appProviders.dart';
import 'package:mychest/presentation/widgets/gradientButton.dart';

class ProductPage extends ConsumerStatefulWidget {
  final Product product;
  const ProductPage({Key? key, required this.product}) : super(key: key);

  @override
  ConsumerState<ProductPage> createState() => _ProductPageConsumerState();
}

class _ProductPageConsumerState extends ConsumerState<ProductPage> {

  List<Widget> resposiveWidgets(){
    return [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.network(
                  widget.product.image, 
                  width: MediaQuery.of(context).size.width/3,
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
                Column(
                  children: [
                    Row(children: [
                      iconTypes[widget.product.type],
                    Text(widget.product.name, style: TextStyle(color: Colors.grey[600], fontSize: 18, fontWeight: FontWeight.bold),),
                    ],),
                    Text(widget.product.name, style: const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
                    const SizedBox(height: 15,),
                    Row(children: [
                    Text("${widget.product.price}", style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),
                    Text(" - ${widget.product.quantity} left", style: TextStyle(color: Colors.grey[600], fontSize: 30, fontWeight: FontWeight.w100),),
                    ],),
                    const SizedBox(height: 8,),
                    GradientButton(text: "Add to cart", onPressed: addToCart)
                  ],
                )
              ],
            ),
          ];
      }
  Future<void> addToCart()async{
    bool authenticated = ref.watch(TokenNotifierProvider) == null || ref.watch(TokenNotifierProvider)!.isEmpty;
    if(!authenticated){
      Fluttertoast.showToast(msg: "Login first🥺", toastLength: Toast.LENGTH_SHORT);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isMobile = mediaQuery.size.width < 600;
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height-20,
        width: MediaQuery.of(context).size.width-20,
        child: Column(
          children: [
            isMobile?
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: resposiveWidgets(),
            ):
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: resposiveWidgets(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 8,),
                Column(
                  children: [
                    Row(
                      children: [
                        Text('Platforms: ', style: TextStyle(color: Colors.grey[600], fontSize: 20, fontWeight: FontWeight.w200),),
                        Text(widget.product.platforms, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),              
                      ],
                    ),
                    const SizedBox(height: 8,),
                    const Text("Description: ", style: TextStyle(color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold),),
                    const SizedBox(height: 8,),
                    Text(widget.product.description, style: TextStyle(color: Colors.grey[500], fontSize: 20, fontWeight: FontWeight.normal),),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}