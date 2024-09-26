import 'package:flutter/material.dart';
import 'package:mychest/global/colors/colorsScheme.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("  Results:", style: TextStyle(color: Colors.white, fontFamily: "Ubuntu", fontWeight: FontWeight.w700),)
          ],
        ),
      ),
    );
  }
}