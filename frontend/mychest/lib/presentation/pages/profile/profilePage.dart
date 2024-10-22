import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:mychest/data/models/profile.dart';
import 'package:mychest/global/colors/colorsScheme.dart';
import 'package:mychest/presentation/state_manager/providers/appProviders.dart';
import 'package:mychest/presentation/widgets/gradientOutlineButton.dart';

class ProfilePage extends ConsumerStatefulWidget {
  final Profile profile;
  final Function logoutFunction;
  const ProfilePage({Key? key, required this.profile, required this.logoutFunction}) : super(key: key);

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageConsumerState();
}

class _ProfilePageConsumerState extends ConsumerState<ProfilePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_)async{
      await ref.read(ProfileNotifierProvider.notifier).initialize();
    });
    super.initState();
  }
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
            child: Text(widget.profile.email, style: TextStyle(color: Colors.grey[600], fontSize: 22, fontFamily: "Ubuntu", fontWeight: FontWeight.w300),),
          ),
          const SizedBox(height: 30,),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Orders:', style: TextStyle(color: Colors.white, fontSize: 22, fontFamily: "Ubuntu", fontWeight: FontWeight.w100),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 300,
              child:widget.profile.orderBuckets.isNotEmpty? ListView.builder(
                itemBuilder: 
                  (context, index)=> SizedBox(
                    child: Column(
                      children: [
                        Text(
                          widget.profile.orderBuckets[index].createdAt,
                          style: const TextStyle(color: Colors.white),
                        ),
                        ...List.generate(
                          widget.profile.orderBuckets[index].keys.length, 
                          (index)=> Text(
                            widget.profile.orderBuckets[index].keys[index].activationKey, 
                            style: const TextStyle(color: Colors.white),
                          )
                        ),
                      ],
                    ),
                  )
              ):
              SizedBox(
                height: 300,
                child: Center(
                  child: Text('Nothing to show here... yet👀', style: TextStyle(color: Colors.grey[600], fontSize: 18, fontFamily: "Ubuntu", fontWeight: FontWeight.w100),),
                ),
              ),
            ),
          ),
          GradientOutLineButton(text: "Logout", onPressed: ()async{await widget.logoutFunction();Navigator.pop(context);}, height: 50, width: 100)
        ],
      ),
    );
  }
}