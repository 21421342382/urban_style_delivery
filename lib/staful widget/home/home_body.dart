import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:rive/rive.dart';
import 'package:urban_style_delivery/controllers/engine/engine_controller.dart';
import 'package:urban_style_delivery/controllers/home/home_controller.dart';

import '../../constrants/colors.dart';
import '../../controllers/assets/assets.dart';
import '../../user/user.dart';

class home_body extends StatefulWidget {
  const home_body({Key? key}) : super(key: key);

  @override
  State<home_body> createState() => _home_bodyState();
}

class _home_bodyState extends State<home_body> {
  @override
  bool is_scanner = false;
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Center(child: is_scanner ?Container(height : 100, width : 100 ,child: RiveAnimation.asset('assets/loading.riv')) :Text("No Delivery Yet !. Scan for new delivery",style: TextStyle(color: ColorHelper.color[1]),)))
        ,Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: InkWell(
              onTap: () async {

                if (is_scanner == false) {
                  setState(() {
                    is_scanner = true;
                    home_controller.continue_scan = true;
                  });
                  var todo1 = ParseObject('deliveryBoy')
                    ..objectId = user.obj_id
                    ..set('is_active', is_scanner);
                  await todo1.update();
                  await home_controller().search_for_delivery(context);
                } else {
                  print("Cancelling !!");
                  engine_controller.update_status();
                  setState(() {
                    is_scanner = false;
                    home_controller.continue_scan = false;
                  });
                }
              },

              child: Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: ColorHelper.color[3]
                ),
                child: Center(
                  child: is_scanner
                  ? Text("Stop Scanning",style: TextStyle(color: ColorHelper.color[0]),)
                      : Text("Scan for Delivery",style: TextStyle(color: ColorHelper.color[0]),)
                ),
              ),
            )
          ),
        )
      ],
    );
  }
}
