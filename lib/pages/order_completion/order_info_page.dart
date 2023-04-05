import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:urban_style_delivery/constrants/colors.dart';
import 'package:urban_style_delivery/controllers/home/home_controller.dart';
import 'package:urban_style_delivery/user/user.dart';
class order_info_page extends StatelessWidget {
  const order_info_page({Key? key, required this.seller_location, required this.otp, required this.drop_location, required this.product})
      : super(key: key);
  final seller_location;
  final otp;
  final drop_location ;
  final product ;

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 5),(){
      print("////////////////////////////////////////////////////////////////////////");
      print("$otp");
      home_controller().keep_updating_lat_long(double.parse(seller_location["lat"]) , double.parse(seller_location["long"]),context, "834401" , double.parse(drop_location["lat"]) , double.parse(drop_location["lat"]), product);
      // home_controller.openMap(context ,double.parse(seller_location["lat"]), double.parse(seller_location["long"]));

    });
    return Scaffold(
      backgroundColor: ColorHelper.color[6],
        body: Center(
          child: RiveAnimation.asset('assets/got_order.riv',),
        ));
  }
}
