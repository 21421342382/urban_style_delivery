import 'package:flutter/material.dart';
import 'package:urban_style_delivery/controllers/login/login.dart';
import 'package:urban_style_delivery/user/user.dart';

import '../../controllers/assets/assets.dart';
import '../../controllers/engine/engine_controller.dart';
import '../account/login/login.dart';

class splash extends StatelessWidget {
  const splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    engine_controller().user_logged_in(context);

    Future.delayed(Duration(seconds: 3),(){
      if(user.is_logged_in == false){
        login_controller.country_code.text = "+91";
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => login()), (
            route) => false);
      }
    });
    return Scaffold(
      body: Stack(
        children: [

          Image.asset(assets.logo_background,height: double.infinity,width: double.infinity,fit: BoxFit.fill,),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Image.asset(assets.logo),
            ),
          ),
        ],
      ),
    );
  }
}