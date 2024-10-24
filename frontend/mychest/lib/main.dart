import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mychest/global/colors/colorsScheme.dart';
import 'package:mychest/presentation/pages/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

late int? cartId;
late bool isTokenValid;

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child:MychestMain()));
  final prefs = await SharedPreferences.getInstance();
  cartId = prefs.getInt("cartId");
}

class MychestMain extends StatelessWidget {
  const MychestMain({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyChest.store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        //fontFamily: 'Ubuntu',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          bodySmall: TextStyle(color: Colors.white),
          headlineLarge: TextStyle(color: Colors.white),
          headlineMedium: TextStyle(color: Colors.white),
          headlineSmall: TextStyle(color: Colors.white),
        ),
        scaffoldBackgroundColor: pageBackground,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
