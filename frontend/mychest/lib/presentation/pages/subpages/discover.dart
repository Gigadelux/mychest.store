import 'package:flutter/material.dart';
import 'package:mychest/data/models/product.dart';
import 'package:mychest/global/colors/colorsScheme.dart';
import 'package:mychest/presentation/widgets/universal/universalProductGrid.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  List<Product> products = [];
  Widget? banner;
  List<Widget> loadedWidgets = [];
  @override
  void initState() {
    super.initState();
    //TODO here retrieval of banner and featured Products
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding:EdgeInsets.all(10),
                child: Text("Featured", style:TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25))
              ),
              Universalproductgrid(products: products)
            ],
          ),
        ),
      ),
    );
  }
}