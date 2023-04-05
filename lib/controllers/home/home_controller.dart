import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:urban_style_delivery/controllers/engine/engine_controller.dart';
import 'package:urban_style_delivery/pages/order_completion/order_info_page.dart';
import 'package:urban_style_delivery/user/user.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../pages/order_completion/reached_seller.dart';

class home_controller{
  static bool continue_scan = false;
  late Timer mytimer ;
  late Timer my_timer ;
  search_for_delivery(context) async{
    mytimer = Timer.periodic(Duration(seconds: 2), (timer) async {
      if(continue_scan == true){
        print("Searching ... ");
        final QueryBuilder<ParseObject> parseQuery =
        QueryBuilder<ParseObject>(ParseObject('deliveryBoy'));
        // `whereContains` is a basic query method that checks if string field
        // contains a specific substring
        parseQuery.whereContains('objectId', user.obj_id);

        // The query will resolve only after calling this method, retrieving
        // an array of `ParseObjects`, if success
        final ParseResponse apiResponse = await parseQuery.query();

        if (apiResponse.success && apiResponse.results != null) {
          for (var o in apiResponse.results!) {
            if(apiResponse.results![0]["order"].isEmpty){
              print("Nothing Found");
            }else{
              print(apiResponse.results![0]["order"]);
              user.my_orders = apiResponse.results![0]["order"];
              print(user.my_orders);
              mytimer.cancel();

              final QueryBuilder<ParseObject> parseQuery2 =
              QueryBuilder<ParseObject>(ParseObject('tokens'));
              // `whereContains` is a basic query method that checks if string field
              // contains a specific substring
              parseQuery2.whereContains('token', '${user.my_orders[0][0]["token"]}');

              // The query will resolve only after calling this method, retrieving
              // an array of `ParseObjects`, if success
              final ParseResponse apiResponse2 = await parseQuery.query();

              if (apiResponse2.success && apiResponse2.results != null) {
                for (var o in apiResponse2.results!) {
                  final QueryBuilder<ParseObject> parseQuery3 =
                  QueryBuilder<ParseObject>(ParseObject('sellers'));
                  // `whereContains` is a basic query method that checks if string field
                  // contains a specific substring
                  parseQuery3.whereContains('objectId', '${o["obj_id"]}');

                  // The query will resolve only after calling this method, retrieving
                  // an array of `ParseObjects`, if success
                  final ParseResponse apiResponse3 = await parseQuery.query();

                  if (apiResponse3.success && apiResponse3.results != null) {
                    for (var o in apiResponse3.results!) {
                      print((o as ParseObject).toString());
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => order_info_page(seller_location: {"lat" : "${o["lat"]}","long" : "${o["long"]}"}, otp: o["otp"], drop_location: {"lat" : "${o["lat"]}","long" : "${o["long"]}"}, product: [o],)));

                    }
                  }
                }
              }


            }

          }
        }
      }else{
        mytimer.cancel();
      }
      }
      );

  }

  cancel_searching(){
    mytimer.cancel();
  }

  static Future<void> openMap(BuildContext context, double lat, double lng) async {
    final availableMaps = await MapLauncher.installedMaps;
    print(availableMaps); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]

    await availableMaps.first.showMarker(
      coords: Coords(lat, lng),
      title: "Seller's Shop",
    );
    await MapLauncher.showMarker(
      mapType: MapType.google,
      coords: Coords(lat, lng),
      title: "Seller's Shop",
      description: "",
    );
  }


  keep_updating_lat_long(start_lat , start_long , context, otp , drop_lat , drop_long , product) async{

    double meters = 500;

    double coef = meters / 111320.0;

    double new_lat = user.lat + coef;

    double new_long = user.long + coef / cos(user.lat * 0.01745);
    bool avail = isPersonAvailable(Person(latitude: start_lat, longitude: start_long), user.lat, user.long, new_lat, new_long, 1);
    if(avail == true){
      engine_controller().getCurrentLocation();
      var todo = ParseObject('deliveryBoy')
        ..objectId = user.obj_id
        ..set('lat', await user.lat)
        ..set('long', await user.long);
      await todo.save();
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => reached_seller(otp: otp,drop_lat: drop_lat,drop_long: drop_long,product: product,)));
    }else{
      engine_controller().getCurrentLocation();
      var todo = ParseObject('deliveryBoy')
        ..objectId = user.obj_id
        ..set('lat', await user.lat)
        ..set('long', await user.long);
      await todo.save();
      keep_updating_lat_long(start_lat, start_long, context ,otp, drop_lat , drop_long, product );
    }
  }

  bool isPersonAvailable(Person person, double startLat, double startLong, double endLat, double endLong, double maxDistance) {
    const double earthRadius = 6371.0; // Earth's radius in km
    double latDiff = (endLat - startLat) * pi / 180.0;
    double longDiff = (endLong - startLong) * pi / 180.0;
    double startLatRad = startLat * pi / 180.0;
    double endLatRad = endLat * pi / 180.0;

    double a = sin(latDiff / 2) * sin(latDiff / 2) +
        sin(longDiff / 2) * sin(longDiff / 2) *
            cos(startLatRad) * cos(endLatRad);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c;

    return distance <= maxDistance;
  }



}

class Person {
  double latitude;
  double longitude;

  Person({required this.latitude, required this.longitude});
}