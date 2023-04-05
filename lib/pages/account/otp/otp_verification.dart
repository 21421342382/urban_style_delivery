import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:urban_style_delivery/constrants/Icons.dart';
import 'package:urban_style_delivery/constrants/colors.dart';
import 'package:urban_style_delivery/controllers/assets/assets.dart';
import '../../../controllers/login/login.dart';
import '../../../widget/otp_pin.dart';


class otp_verifocation extends StatelessWidget {
  otp_verifocation({Key? key, required this.verification_id,}) : super(key: key);
final verification_id ;
  @override
  FirebaseAuth auth = FirebaseAuth.instance;

  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();
  final TextEditingController _fieldFive = TextEditingController();
  final TextEditingController _fieldSix = TextEditingController();
  String? _otp;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorHelper.r_g_b[3],
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      onTap: () {
                        login_controller.animate = false;
                        Navigator.pop(context);
                      },
                      child: Icon(
                        IconHelper.icons[7],
                        color: ColorHelper.color[0],
                      )),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(80)),
                child: Image.asset(
                  assets.otp_screen_image,
                  fit: BoxFit.fill,
                  height: 200,
                  width: 200,
                ),
              ),
            ),
            Center(
              child: Text(
                "Verification",
                style: TextStyle(
                    color: ColorHelper.color[0],
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    letterSpacing: 1),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                "Enter OTP sended to ${login_controller.country_code.text}${login_controller.phone.text}",
                style: TextStyle(
                    fontSize: 15,
                    color: ColorHelper.color[1],
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: ColorHelper.color[0],
                    boxShadow: [
                      BoxShadow(color: ColorHelper.color[0], blurRadius: 20.0)
                    ]),
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OtpInput(_fieldOne, true), // auto focus
                        OtpInput(_fieldTwo, false),
                        OtpInput(_fieldThree, false),
                        OtpInput(_fieldFour, false),
                        OtpInput(_fieldFive, false),
                        OtpInput(_fieldSix, false)
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: InkWell(
                        onTap: () async{
                          try{
                            PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verification_id, smsCode: "${_fieldOne.text}${_fieldTwo.text}${_fieldThree.text}${_fieldFour.text}${_fieldFive.text}${_fieldSix.text}");

                            // Sign the user in (or link) with the credential
                            await auth.signInWithCredential(credential);
                            Get.snackbar("Verifying. Please Wait" , "Verifying Please Wait few moments");
                            login_controller.get_user_details(context);
                          }catch (e){
                            Get.snackbar("Wrong Otp" , "Wrong Otp. Please Enter Correct Otp");
                          }
                        },
                        child: Container(
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: ColorHelper.r_g_b[3]
                          ),
                          child: Center(
                            child: Text("Verify OTP",style: TextStyle(color: ColorHelper.color[0]),),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
