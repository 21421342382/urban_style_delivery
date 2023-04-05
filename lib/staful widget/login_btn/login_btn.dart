import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:urban_style_delivery/pages/account/otp/otp_verification.dart';

import '../../constrants/colors.dart';
import '../../controllers/login/login.dart';

class login_button extends StatefulWidget {
  const login_button({Key? key}) : super(key: key);

  @override
  State<login_button> createState() => _login_buttonState();
}

class _login_buttonState extends State<login_button> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()async{
        var res = login_controller().validate();
        print(res);
        if(res == "validated"){
          setState(() {
            login_controller.animate = true;
          });
          await FirebaseAuth.instance.verifyPhoneNumber(
            phoneNumber: '${login_controller.country_code.text}${login_controller.phone.text}',
            verificationCompleted: (PhoneAuthCredential credential) {},
            verificationFailed: (FirebaseAuthException e) {},
            codeSent: (String verificationId, int? resendToken) {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => otp_verifocation(verification_id: verificationId,)));
            },
            codeAutoRetrievalTimeout: (String verificationId) {},
          );


        }


      },
      child: Container(
        height: 60,
        width: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(60)),
            color: ColorHelper.hex_color[0]
        ),
        child: Center(
            child: login_controller.animate
                ? CircularProgressIndicator(color: ColorHelper.color[0],strokeWidth: 1,)
                :Text("Verify OTP",style: TextStyle(color: ColorHelper.color[0],fontSize: 14,letterSpacing: 2),)
        ),
      ),
    );

  }
}