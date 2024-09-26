import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mychest/global/colors/colorsScheme.dart';
import 'package:mychest/presentation/pages/subpages/discover.dart';
import 'package:mychest/presentation/pages/profile/loginPage.dart';
import 'package:mychest/presentation/pages/profile/profilePage.dart';
import 'package:mychest/presentation/state_manager/providers/appProviders.dart';
import 'package:unicons/unicons.dart';
import 'package:scaffold_responsive/scaffold_responsive.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageConsumerState();
}

class _HomePageConsumerState extends ConsumerState<HomePage> {
  bool userAuthenticated = false;
  final TextEditingController textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  final ResponsiveMenuController menuController = ResponsiveMenuController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      //await ref.read(ProfileNotifierProvider.notifier).initialize();
    });
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isMobile = mediaQuery.size.width < 600;
    return Scaffold(
      endDrawer: const ProfilePage(),
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      backgroundColor: pageBackground,
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        shadowColor: Colors.white,
        elevation: 0,
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.asset("assets/logo.jpg", width: 50, height: 50,),
        ),
        title: Container(
          width: isMobile?MediaQuery.of(context).size.width/2: MediaQuery.of(context).size.width/3,
          height: 35,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 40, 40, 40),
            borderRadius: BorderRadius.circular(10),

          ),
          child: Center(
            child: TextField(
              autocorrect: true,
              style: const TextStyle(color: Colors.white, fontFamily: "Ubuntu"),
              cursorColor: Colors.white,
              autofocus: false,
              focusNode: _focusNode,
              minLines: 1,
              maxLines: 1,
              controller: textEditingController,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                labelText: _isFocused?"":"Search your treasure",
                labelStyle: const TextStyle(color: Color.fromARGB(255, 163, 163, 163)),
                fillColor: const Color.fromARGB(255, 40, 40, 40),
                prefixIcon: const Icon(UniconsLine.search_alt, color: Colors.white,),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide.none, // Remove default border
                  ),
                contentPadding: const EdgeInsets.all(0),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                isDense: true,
                alignLabelWithHint: true,
                
              ),
                         
            ),
          ),
        ),
        actions: [
          Padding(
            padding:isMobile?const EdgeInsets.all(0): const EdgeInsets.all(20),
            child: IconButton(onPressed: (){}, icon: const Icon(UniconsLine.shopping_cart_alt, color: Colors.white,size: 30,))),
          TextButton(
            onPressed: (){
              if(!ref.watch(ProfileNotifierProvider).isEmpty()) {
                _scaffoldKey.currentState!.openEndDrawer();
              } else {
                Navigator.push(context, CupertinoPageRoute(builder: (context)=>const Login()));
              }
            }, //Opens drawer
            child: Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(colors: gradient),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: pageBackground
                  ),
                  child: const Icon(UniconsLine.user, size: 30, color: Colors.white,),
                              ),
                ),
              ],
            ),
          ),
        ],
        flexibleSpace: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: gradient
                    ),
                  ),
                ),
              )
              ]),
        backgroundColor: pageBackground,
      ),
      body: const DiscoverPage(),
    );
  }
}