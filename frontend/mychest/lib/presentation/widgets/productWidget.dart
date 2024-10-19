import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mychest/data/models/enums/product_type.dart';
import 'package:mychest/data/models/product.dart';
import 'package:mychest/global/colors/colorsScheme.dart';
import 'package:mychest/presentation/pages/subpages/productPage.dart';

class Productwidget extends StatelessWidget {
  final double width,height;
  final Product product;
  const Productwidget({Key? key, required this.height,required this.width, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: (){ 
            if(product.quantity > 0) {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductPage(product: product)));
            } else {
              Fluttertoast.showToast(msg: "Product sold out...",toastLength: Toast.LENGTH_SHORT);
            }
          },
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: DecorationImage(
                image: NetworkImage(product.image), // Replace with the actual image path
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: gradient
                      ),
                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30))
                    ),
                    child: Row(
                      children: [
                        iconTypes[product.type],
                        Text("${product.price}"r"$", style: const TextStyle(fontWeight: FontWeight.bold),),
                        Text(" ${product.quantity} left")
                      ],
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.topCenter,
                  child: Text("SOLD OUT!", style: TextStyle(fontSize: 25),),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10,bottom: 10),
          child: Text(product.name),
        ),
      ],
    );
  }
}