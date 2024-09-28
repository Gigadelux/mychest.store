import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mychest/presentation/pages/HomePage.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child:MychestMain()));
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
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
