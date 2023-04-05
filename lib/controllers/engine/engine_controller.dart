
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../pages/account/login/login.dart';
import '../../pages/home/home.dart';
import '../../user/user.dart';

class engine_controller {
  user_logged_in(context) async {
    getCurrentLocation();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("login") == null) {
      print("///////////////////////////////////////////////////////");
      print("User Not Found !!");
      user.is_logged_in = false;
    } else {
      user.is_logged_in = true;
      user.username = prefs.getString("name");
      final QueryBuilder<ParseObject> parseQuery =
      QueryBuilder<ParseObject>(ParseObject('deliveryBoy'));
      // `whereContains` is a basic query method that checks if string field
      // contains a specific substring
      parseQuery.whereContains('name', user.username);

      // The query will resolve only after calling this method, retrieving
      // an array of `ParseObjects`, if success
      final ParseResponse apiResponse = await parseQuery.query();

      if (apiResponse.success && apiResponse.results != null) {
        for (var o in apiResponse.results!) {
          var data = apiResponse.results as List<ParseObject>;
          user.my_orders = data[0]["order"];
          user.phone = data[0]["number"];
          user.user_number = data[0]["number"];
          user.obj_id = data[0]["objectId"];
          // user.total_revenue = data[0]["Total_Revenue"];
          // user.total_order = data[0]["Total_Order"];
          print(user.obj_id);
          user.profile_photo = data[0]["profile_photo"];
          if (user.profile_photo == null) {
            user.has_profile_photo = false;
          } else {
            user.has_profile_photo = true;
          }
          print("/////////////////////////////////////////////////");
          print("PRINTING USER DETAILS");
          print("user Order - " + "${user.my_orders}");
          print("user location - " + "${user.location}");
          print("user username - " + "${user.username}");
          print("user email - " + "${user.user_number}");
          print("user profile - " + "${user.profile_photo}");

          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => home()), (route) => false);

        }
      } else {
        Get.snackbar(
          "Account Not Found",
          "Please create new Account",
        );
        prefs.remove("login");
        prefs.remove("name");
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => login()), (
            route) => false);
      }
    }
  }

  static update_status ()async{
    var todo1 = ParseObject('deliveryBoy')
      ..objectId = user.obj_id
      ..set("order", [])
      ..set('is_active', false);
    await todo1.update();
    print("Status Changed !!");
  }

  Future<void> getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print("Position got !!");
    user.lat = position.latitude;
    user.long = position.longitude;
    print(position);
    List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude, position.longitude);
    user.location = placemarks;
    user.sublocality = placemarks[0].subLocality;
    user.locality = placemarks[0].locality;
    user.state = placemarks[1].administrativeArea;
    user.postal_code = placemarks[0].postalCode;
    print(placemarks);
  }

}