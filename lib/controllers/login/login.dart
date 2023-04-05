import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urban_style_delivery/constrants/colors.dart';
import 'package:urban_style_delivery/pages/home/home.dart';
import 'package:urban_style_delivery/user/user.dart';

import '../../constrants/Icons.dart';

class login_controller {
  static TextEditingController name = TextEditingController();
  static TextEditingController phone = TextEditingController();
  static TextEditingController country_code = TextEditingController();
  static bool animate = false;

  validate() {
    if (name.text == "") {
      print("Name - ${name.text}");
      Get.snackbar(
        "Name Not Valid",
        "Please Enter Valid Email to continue",
        icon: Icon(IconHelper.icons[29], color: ColorHelper.color[0]),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorHelper.color[3],
        borderRadius: 20,
        margin: EdgeInsets.all(15),
        colorText: ColorHelper.color[0],
        duration: Duration(seconds: 4),
        isDismissible: true,
        forwardAnimationCurve: Curves.easeOutBack,
      );

      return "not validated";
    } else {
      if (phone.text.isEmpty) {
        Get.snackbar(
          "Phone Number Not Valid",
          "Please Enter Valid Phone Number to continue",
          icon: Icon(IconHelper.icons[29], color: ColorHelper.color[0]),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: ColorHelper.color[3],
          borderRadius: 20,
          margin: EdgeInsets.all(15),
          colorText: ColorHelper.color[0],
          duration: Duration(seconds: 4),
          isDismissible: true,
          forwardAnimationCurve: Curves.easeOutBack,
        );
        return "not validated";
      } else {
        if (country_code.text.isEmpty) {
          Get.snackbar(
            "Country Code Not Valid",
            "Please Enter Valid Country Code to continue",
            icon: Icon(IconHelper.icons[29], color: ColorHelper.color[0]),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: ColorHelper.color[3],
            borderRadius: 20,
            margin: EdgeInsets.all(15),
            colorText: ColorHelper.color[0],
            duration: Duration(seconds: 4),
            isDismissible: true,
            forwardAnimationCurve: Curves.easeOutBack,
          );
          return "not validated";
        } else {
          return "validated";
        }
      }
    }
  }

  static get_user_details(context) async {
    final QueryBuilder<ParseObject> parseQuery =
        QueryBuilder<ParseObject>(ParseObject('deliveryBoy'));

    parseQuery.whereEqualTo('phone', login_controller.phone.text);
    final apiResponse = await parseQuery.query();

    if (apiResponse.success && apiResponse.results != null) {
      for (var o in apiResponse.results!) {
        final object = o as ParseObject;
        var data = apiResponse.results as List<ParseObject>;
        print('${object.objectId} - ${object.get<String>('name')}');
        print("Name Found !!");
        user.username = data[0]["name"];
        user.obj_id = object.objectId;
        user.phone = data[0]["number"];
        user.profile_photo = data[0]["photo"];
        if(user.profile_photo == null){
          user.has_profile_photo = false;
        }else{
          user.profile_photo = data[0]["photo"];
        }
        user.history = data[0]["history"];
        user.revenue = data[0]["revenue"];
        user.active_status = data[0]["is_active"];
        user.order = data[0]['order'];
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString("name", "${name.text}");
        pref.setString("login", "true");
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => home()), (route) => false);

      }
    } else {
      print("Name Not Found");
      final todo = ParseObject('deliveryBoy')
        ..set('name', name.text)
        ..set('number', '${country_code.text}${phone.text}')
        ..set('lat', user.lat)
        ..set('long', user.long)
        ..set('history', [])
        ..set('revenue', 0)
        ..set('is_active', false)
        ..set('order', []);
      await todo.save();
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("name", "${name.text}");
      pref.setString("login", "true");
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => home()), (route) => false);
    }
  }
}
