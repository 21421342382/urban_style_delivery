import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constrants/Icons.dart';
import '../../../constrants/colors.dart';
import '../../../controllers/assets/assets.dart';
import '../../../controllers/login/login.dart';
import '../../../staful widget/login_btn/login_btn.dart';
import '../../../widget/text_feild.dart';

class login extends StatelessWidget {
  const login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorHelper.color[0],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: 500,
                width: double.infinity,
                child: Image.asset(assets.login_image,fit: BoxFit.fill,width: double.infinity,height: double.infinity,)),

            Padding(
              padding: const EdgeInsets.only(left: 18,right: 18,top: 38),
              child: TextFeild("Name", Icon(IconHelper.icons[0],color: ColorHelper.color[2],) , login_controller.name , "string" , false),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18,right: 18,top: 38),
              child: Row(
                children: [
                  Expanded(child: TextFeild("Country Code", Icon(IconHelper.icons[26]) , login_controller.country_code, "string" , false)),
                  SizedBox(width: 10,),
                  Expanded(child: TextFeild("Phone No." , Icon(IconHelper.icons[28]) , login_controller.phone, "number" , true))
                ],
              ),
            ),
            SizedBox(height: 40,),
            login_button(),
            SizedBox(height: 60,),
          ],
        ),
      ),
    );
  }
}

