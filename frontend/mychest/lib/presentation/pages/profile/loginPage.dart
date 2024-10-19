import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mychest/core/API/app_userAPI.dart';
import 'package:mychest/core/API/cartAPI.dart';
import 'package:mychest/global/colors/colorsScheme.dart';
import 'package:mychest/presentation/state_manager/providers/appProviders.dart';
import 'package:mychest/presentation/widgets/gradientButton.dart';
import 'package:mychest/presentation/widgets/gradientOutlineButton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicons/unicons.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class Login extends ConsumerStatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  ConsumerState<Login> createState() => _LoginConsumerState();
}

class _LoginConsumerState extends ConsumerState<Login> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isMobile = mediaQuery.size.width < 600;
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return Scaffold(
      backgroundColor: pageBackground,
      body: Column(
        children: [
          if(isMobile)
            ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset("assets/logo.jpg", width: 70, height: 70,),
                  ),
                  const SizedBox(width: 40,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(onPressed: ()=> Navigator.pop(context), icon: const Icon(UniconsLine.multiply, color: Colors.white, size: 40,)),
                  )
                ],
              ),
            ]
          else
            ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(onPressed: ()=> Navigator.pop(context), icon: const Icon(UniconsLine.multiply, color: Colors.white, size: 40,)),
                  )
                ],
              ),
            ],
          SizedBox(height: MediaQuery.of(context).size.height/6,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      const Text("Welcome to ", style: TextStyle(color: Colors.white, fontFamily: "Ubuntu", fontSize: 27),),
                      GradientText("MyChest!", colors: gradient, style: const TextStyle(color: Colors.white, fontFamily: "Ubuntu", fontSize: 27),)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: SizedBox(
                      width: 300,
                      child: TextField(
                        autocorrect: true,
                        style: const TextStyle(color: Colors.white, fontFamily: "Ubuntu"),
                        cursorColor: Colors.white,
                        autofocus: false,
                        minLines: 1,
                        maxLines: 1,
                        controller: emailController,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: const InputDecoration(
                          labelText: "email",
                          labelStyle: TextStyle(color: Color.fromARGB(255, 163, 163, 163)),
                          fillColor: Color.fromARGB(255, 40, 40, 40),
                          prefixIcon: Icon(UniconsLine.envelope, color: Colors.white,),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(color: Colors.white, width: 10.0),
                            ),
                          contentPadding: EdgeInsets.all(0),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          //isDense: true,
                          alignLabelWithHint: true,
                        ),       
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 30),
                    child: SizedBox(
                      width: 300,
                      child: TextField(
                        autocorrect: true,
                        controller: passwordController,
                        style: const TextStyle(color: Colors.white, fontFamily: "Ubuntu"),
                        cursorColor: Colors.white,
                        autofocus: false,
                        minLines: 1,
                        maxLines: 1,
                        textAlignVertical: TextAlignVertical.center,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: "password",
                          labelStyle: TextStyle(color: Color.fromARGB(255, 163, 163, 163)),
                          fillColor: Color.fromARGB(255, 40, 40, 40),
                          prefixIcon: Icon(UniconsLine.lock, color: Colors.white,),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(color: Colors.white, width: 10.0),
                            ),
                          contentPadding: EdgeInsets.all(0),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          //isDense: true,
                          alignLabelWithHint: true,
                        ),       
                      ),
                    ),
                  ),
                  loading?
                  const CircularProgressIndicator(color: Colors.white,):
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        GradientButton(
                          text: "Login", 
                          onPressed: ()async{
                            setState(() {
                              loading = true;
                            });
                            Map res = await AppUserAPI().login(emailController.text, passwordController.text);                          
                            Map cartRes = await CartAPI().createCart(res['token']);
                            if(cartRes['status']!=200){
                              Fluttertoast.showToast(msg: cartRes['message']);
                            }
                            if(res['status']==200){
                              try{
                                await ref.read(TokenNotifierProvider.notifier).setToken(res['token']);
                                await ref.read(ProfileNotifierProvider.notifier).initialize();
                                Navigator.pop(context);
                              }catch(e){
                                ref.read(TokenNotifierProvider.notifier).destroy();
                                ref.read(ProfileNotifierProvider.notifier).destroy();
                                Fluttertoast.showToast(msg: "Sorry unknown error🥺");
                                return;
                              }
                            }else{
                              Fluttertoast.showToast(msg: res['message']);
                            }
                          }, height: 50, width: 100,),
                        GradientOutLineButton(
                          text: "Sign up", 
                          onPressed: ()async{
                            Map response = await AppUserAPI().newUser(emailController.text, passwordController.text);
                            int? cartId = response['cartId'];
                            Map res = await AppUserAPI().login(emailController.text, passwordController.text);
                            if(res['status']!=200 || response['status']!=200){
                              Fluttertoast.showToast(msg: response['message']);
                              return;
                            }
                            if(cartId==null){
                              Fluttertoast.showToast(msg: response['message']);
                              return;
                            }
                            final prefs = await SharedPreferences.getInstance();
                            prefs.setInt("cartId", cartId);
                            try{
                                await ref.read(TokenNotifierProvider.notifier).setToken(res['token']);
                                await ref.read(ProfileNotifierProvider.notifier).initialize();
                                Navigator.pop(context);
                              }catch(e){
                                ref.read(TokenNotifierProvider.notifier).destroy();
                                ref.read(ProfileNotifierProvider.notifier).destroy();
                                Fluttertoast.showToast(msg: "Sorry unknown error🥺");
                                return;
                              }
                          }, height: 50, width: 100)
                      ],
                    ),
                  )
                ],
              ),
              if(isMobile)
                ...[]
              else
                ...[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset("assets/logo.jpg", width: MediaQuery.of(context).size.height/2),
                      ),
                    ],
                  )
                ]
            ],
          ),
        ],
      ),
    );
  }
}