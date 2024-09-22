import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mychest/global/colors/colorsScheme.dart';
import 'package:mychest/presentation/widgets/gradientOutlineButton.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> { //TODO THIS IS ONLY FOR DEMO, REDO WHEN STATEMANAGER IS ACTIVE (riverpod)
  List<String> chests = ["Favourite skins", "Gta V"];
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: pageBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Profile", style: TextStyle(color: Colors.white, fontFamily: "Ubuntu", fontSize: 24, fontWeight: FontWeight.bold),),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LottieBuilder.asset("assets/user.json", width: 40, height: 40,repeat: false,),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("mirco.delux@gmail.com", style: TextStyle(color: Colors.white, fontSize: 22, fontFamily: "Ubuntu", fontWeight: FontWeight.w300),),
          ),
          GradientOutLineButton(text: "Logout", onPressed: (){}, height: 50, width: 100)
          // Row(
          //   children: [
          //     const Padding(
          //       padding: EdgeInsets.only(top: 20, bottom: 10, right: 8),
          //       child: Text("My Chests", style: TextStyle(color: Colors.white, fontSize: 24, fontFamily: "Ubuntu", fontWeight: FontWeight.bold),),
          //     ),
          //     IconButton(onPressed: (){}, icon: const Icon(UniconsLine.ellipsis_v, color: Color.fromARGB(122, 255, 255, 255), size: 20,))
          //   ],
          // ),
          // if(chests.isEmpty)
          //   const Text("There are no chests here👀, try adding one!", style: TextStyle(color: Colors.white, fontSize: 22, fontFamily: "Ubuntu", fontWeight: FontWeight.w300)),
          // SizedBox(
          //   height: MediaQuery.of(context).size.height/3,
          //   child: ListView.builder(
          //     itemCount: chests.length,
          //     itemBuilder: (context, index)=>
          //       ListTile(
          //         onTap: (){},
          //         leading: Image.asset("assets/chestIcon.png", width: 40,),
          //         title: Text(chests[index], style: const TextStyle(color: Colors.white, fontSize: 22, fontFamily: "Ubuntu", fontWeight: FontWeight.w300)),
          //       )
          //   ),
          // ),
        ],
      ),
    );
  }
}