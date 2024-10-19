import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mychest/data/models/profile.dart';
import 'package:mychest/global/colors/colorsScheme.dart';
import 'package:mychest/presentation/widgets/gradientOutlineButton.dart';

class ProfilePage extends StatelessWidget {
  final Profile profile;
  final Function logoutFunction;
  const ProfilePage({Key? key, required this.profile, required this.logoutFunction}) : super(key: key);
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(profile.email, style: const TextStyle(color: Colors.white, fontSize: 22, fontFamily: "Ubuntu", fontWeight: FontWeight.w300),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: ListView.builder(
                itemBuilder: 
                  (context, index)=> SizedBox(
                    child: Column(
                      children: [
                        Text(
                          profile.orderBuckets[index].createdAt,
                          style: const TextStyle(color: Colors.white),
                        ),
                        ...List.generate(
                          profile.orderBuckets[index].keys.length, 
                          (index)=> Text(
                            profile.orderBuckets[index].keys[index].activationKey, 
                            style: const TextStyle(color: Colors.white),
                          )
                        ),
                      ],
                    ),
                  )
              ),
            ),
          ),
          GradientOutLineButton(text: "Logout", onPressed: (){logoutFunction;}, height: 50, width: 100)
        ],
      ),
    );
  }
}