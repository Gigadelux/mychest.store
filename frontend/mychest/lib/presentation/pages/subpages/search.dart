import 'package:flutter/material.dart';
import 'package:mychest/core/API/productsAPI.dart';
import 'package:mychest/data/models/product.dart';
import 'package:mychest/global/colors/colorsScheme.dart';
import 'package:mychest/presentation/widgets/universal/RequestWidgetTree.dart';
import 'package:mychest/presentation/widgets/universal/universalProductGrid.dart';

class SearchPage extends StatefulWidget {
  final String toSearch;
  const SearchPage({Key? key, required this.toSearch}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Product> products = [];
  List<Product> categoryProducts = [];
  int responseCode = -1;
  int responseCodeCategory = -1;
  String responseErrorMessage = "";
  String responseErrorMessageCategory = "";
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_)async{
        Map response = await ProductsAPI().searchProductsByName(widget.toSearch);
        print("ZIOPERA normalSearch ${response['status']}");
        if(response['status'] == 200){
          List<Product> prods = response['products'];
          setState(() {
            products = prods;
          });
        }
        setState(() {
          responseCode = response['status'];
        });
        Map responseCategory = await ProductsAPI().searchProductsByCategoryName(widget.toSearch);
        print("ZIOPERA categorySearch ${responseCategory['status']}");
        if(responseCategory['status'] == 200){
          List<Product> prods = responseCategory['productsCategory'];
          setState(() {
            categoryProducts = prods;
          });
        }
        setState(() {
          responseCodeCategory = responseCategory['status'];
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("  Results:", style: TextStyle(color: Colors.white, fontFamily: "Ubuntu", fontWeight: FontWeight.w700),),
            RequestWidgetTree(
              loadingWidget: const CircularProgressIndicator(), 
              widget: Universalproductgrid(products: products), 
              containerSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height/2), 
              responseCode: responseCode,
              responseMessage: responseErrorMessage,
              responsecodeTextSize: 25, 
              errorTextSize: 20
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("  From category:", style: TextStyle(color: Colors.white, fontFamily: "Ubuntu", fontWeight: FontWeight.w700),),
                RequestWidgetTree(
                  loadingWidget: const CircularProgressIndicator(), 
                  widget: Universalproductgrid(products: categoryProducts), 
                  containerSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height/2), 
                  responseCode: responseCodeCategory,
                  responseMessage: responseErrorMessageCategory,
                  responsecodeTextSize: 25, 
                  errorTextSize: 20
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}