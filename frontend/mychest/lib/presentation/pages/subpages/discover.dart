import 'package:flutter/material.dart';
import 'package:mychest/core/API/productsAPI.dart';
import 'package:mychest/data/models/product.dart';
import 'package:mychest/global/colors/colorsScheme.dart';
import 'package:mychest/presentation/widgets/BannerWidget.dart';
import 'package:mychest/presentation/widgets/universal/RequestWidgetTree.dart';
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
  int responseStatus = -1;
  String? responseMessage;
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_)async{
        Map response = await ProductsAPI().getFeaturedProducts();
        if(response['status'] == 200){
          List<Product> prods = response['featuredProducts'];
          setState(() {
            products = prods;
          });
        }
        setState(() {
          responseStatus = response['status'];
          responseMessage = response['message'];
        });
      }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Bannerwidget(),
            ),
            Padding(
              padding:const EdgeInsets.all(10),
              child: responseMessage==null? 
                const Text("Featured", style:TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25))
                :
                const Text("")
            ),
            RequestWidgetTree(
              loadingWidget: const CircularProgressIndicator(), 
              widget: Universalproductgrid(products: products), 
              containerSize: Size(MediaQuery.of(context).size.width, 500), 
              responsecodeTextSize: 30, 
              errorTextSize: 25,
              responseCode: responseStatus,
              responseMessage: responseMessage,
            )
          ],
        ),
      ),
    );
  }
}