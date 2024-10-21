import 'package:flutter/material.dart';
import 'package:mychest/core/API/productsAPI.dart';
import 'package:mychest/data/models/product.dart';
import 'package:mychest/global/colors/colorsScheme.dart';
import 'package:mychest/presentation/widgets/BannerWidget.dart';
import 'package:mychest/presentation/widgets/universal/RequestWidgetTree.dart';
import 'package:mychest/presentation/widgets/universal/universalProductGrid.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

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
  int responsePopularity = -1;
  List<String> mostPopular = [];
  
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
        List<String> mostPop = await ProductsAPI().getMostPopularCategories();
        setState(() {
          mostPopular = mostPop;
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:const EdgeInsets.all(10),
                  child: responseStatus==200 && mostPopular.isNotEmpty? 
                    Row(
                      children: [
                        const Text("Most popular: ", style:TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                        ...List.generate(
                          mostPopular.length, 
                          (index)=> GradientText("#${mostPopular[index]}  ", colors: gradient, style: const TextStyle(fontSize: 20),))
                      ],
                    )
                    :
                    const Text("")
                ),
              ],
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