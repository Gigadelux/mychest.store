import 'package:flutter/material.dart';
import 'package:mychest/data/models/enums/product_type.dart';
import 'package:mychest/data/models/product.dart';
import 'package:mychest/global/colors/colorsScheme.dart';
import 'package:mychest/presentation/pages/subpages/productPage.dart';

class Productwidget extends StatefulWidget {
  final double width,height;
  final Product product;
  const Productwidget({Key? key, required this.height,required this.width, required this.product}) : super(key: key);

  @override
  State<Productwidget> createState() => _ProductwidgetState();
}

class _ProductwidgetState extends State<Productwidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductPage(product: widget.product))),
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: DecorationImage(
                image: NetworkImage(widget.product.image), // Replace with the actual image path
                fit: BoxFit.cover,
              ),
            ),
            child: Align(
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
                    iconTypes[widget.product.type],
                    Text("${widget.product.price}"r"$", style: const TextStyle(fontWeight: FontWeight.bold),),
                    Text(" ${widget.product.quantity} left")
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10,bottom: 10),
          child: Text(widget.product.name),
        ),
      ],
    );
  }
}