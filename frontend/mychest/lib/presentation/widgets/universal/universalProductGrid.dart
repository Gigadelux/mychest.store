import 'package:flutter/material.dart';
import 'package:mychest/data/models/product.dart';
import 'package:mychest/presentation/widgets/productWidget.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class Universalproductgrid extends StatelessWidget {
  final List<Product> products;
  const Universalproductgrid({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height:  MediaQuery.of(context).size.height/2,
      child: ResponsiveGridList(
      horizontalGridSpacing: 16, // Horizontal space between grid items
      verticalGridSpacing: 16, // Vertical space between grid items
      horizontalGridMargin: 50, // Horizontal space around the grid
      verticalGridMargin: 50, // Vertical space around the grid
      minItemWidth: 300, // The minimum item width (can be smaller, if the layout constraints are smaller)
      minItemsPerRow: 2, // The minimum items to show in a single row. Takes precedence over minItemWidth
      maxItemsPerRow: 5, // The maximum items to show in a single row. Can be useful on large screens
      listViewBuilderOptions: ListViewBuilderOptions(), // Options that are getting passed to the ListView.builder() function
      children: List.generate(products.length, (index)=>Productwidget(height: 150, width: 200, product: products[index])), // The list of widgets in the list
      ),
    );
  }
}