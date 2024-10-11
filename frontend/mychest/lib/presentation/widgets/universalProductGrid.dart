import 'package:flutter/material.dart';
import 'package:mychest/data/models/product.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class Universalproductgrid extends StatefulWidget {
  List<Product> products;
  Universalproductgrid({super.key, required this.products});

  @override
  State<Universalproductgrid> createState() => _UniversalproductgridState();
}

class _UniversalproductgridState extends State<Universalproductgrid> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveGridList(
    horizontalGridSpacing: 16, // Horizontal space between grid items
    verticalGridSpacing: 16, // Vertical space between grid items
    horizontalGridMargin: 50, // Horizontal space around the grid
    verticalGridMargin: 50, // Vertical space around the grid
    minItemWidth: 300, // The minimum item width (can be smaller, if the layout constraints are smaller)
    minItemsPerRow: 2, // The minimum items to show in a single row. Takes precedence over minItemWidth
    maxItemsPerRow: 5, // The maximum items to show in a single row. Can be useful on large screens
    listViewBuilderOptions: ListViewBuilderOptions(), // Options that are getting passed to the ListView.builder() function
    children: const [

    ], // The list of widgets in the list
);
  }
}