library editCreditCardMenu;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mychest/presentation/state_manager/providers/appProviders.dart';
import 'package:mychest/presentation/widgets/universal/alert.dart';
import 'package:unicons/unicons.dart';

Future<void> editCreditCardMenu(BuildContext context, Function onPressed, Function onCancel, WidgetRef ref)async{
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController passCodeController = TextEditingController();
  TextEditingController expireTimeController = TextEditingController();
  List<String> textfieldLabels = ["Card number", "pass code", "Expire time"];
  List<int> limits = [16, 4, 7];
  showAlert(
    context, 
    SizedBox(
      height: 200,
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(3, 
            (index)=> Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                            width: 180,
                            child: TextField(
                              maxLength: limits[index],
                              autocorrect: true,
                              style: const TextStyle(color: Colors.white, fontFamily: "Ubuntu"),
                              cursorColor: Colors.white,
                              autofocus: false,
                              minLines: 1,
                              maxLines: 1,
                              controller: index ==0? cardNumberController:index==1? passCodeController:expireTimeController,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                labelText: textfieldLabels[index],
                                labelStyle: const TextStyle(color: Color.fromARGB(255, 163, 163, 163)),
                                fillColor: const Color.fromARGB(255, 40, 40, 40),
                                border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(color: Colors.white, width: 10.0),
                                  ),
                                contentPadding: const EdgeInsets.all(0),
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                //isDense: true,
                                alignLabelWithHint: true,
                              ),       
                            ),
                          ),
            ),
          )
        ),
      ),
    ), 
    const SizedBox(
      width: 200,
      child: Row(
        children: [
          Icon(UniconsLine.credit_card, color: Colors.white, size: 40,),
          SizedBox(width: 5,),
          Text("Edit your credit card", style: TextStyle(color: Colors.white, fontSize: 20),),
        ],
      ),
    ),
    ()async{
      String cardNumber = cardNumberController.text;
      String passCode = passCodeController.text;
      String expireTime = expireTimeController.text;
      if(!validCreditCardFormat(cardNumber, passCode, expireTime)){
        Fluttertoast.showToast(msg: "Invalid card detected");
        return false;
      }
      await ref.read(ProfileNotifierProvider.notifier).setCreditCard(cardNumber, passCode, expireTime);
    },
    (){

    },
  );
}


bool validCreditCardFormat(String cardNumber, String passCode, String expireTime) {
  // Validate card number length (16 digits)
  if (cardNumber.length != 16 || !RegExp(r'^\d{16}$').hasMatch(cardNumber)) {
    return false;
  }

  // Validate passcode length (4 digits)
  if (passCode.length != 4 || !RegExp(r'^\d{4}$').hasMatch(passCode)) {
    return false;
  }

  // Validate expiration date (MM/YYYY)
  try {
    List<String> parts = expireTime.split('/');
    print(parts);
    if (parts.length != 2) return false;

    int mm = int.parse(parts[0]);
    int YYYY = int.parse(parts[1]);

    if (mm < 1 || mm > 12) return false;
    if (YYYY < DateTime.now().year) return false;
    if (YYYY == DateTime.now().year && mm < DateTime.now().month) return false;
    
  } catch (e) {
    print(e);
    return false;
  }

  return true;
}
