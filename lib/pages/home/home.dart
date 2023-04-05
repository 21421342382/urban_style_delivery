import 'package:flutter/material.dart';
import 'package:urban_style_delivery/constrants/Icons.dart';
import 'package:urban_style_delivery/constrants/colors.dart';
import 'package:urban_style_delivery/pages/history/history.dart';
import 'package:urban_style_delivery/pages/profile/profile.dart';
import 'package:urban_style_delivery/user/user.dart';

import '../../staful widget/home/home_body.dart';
import '../../widget/home_card.dart';

class home extends StatelessWidget {
  const home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorHelper.color[0],
      body: Column(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                        width: double.infinity,
                        child: Text("Hi ${user.username} !",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),)),
                  ),
                  InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => history()));
                      },
                      child: Icon(IconHelper.icons[30], size: 25,)),
                  SizedBox(width: 10,),
                  InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => account()));
                      },
                      child: user.profile_photo == null
                      ?Icon(IconHelper.icons[8], size: 25,)
                      : Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(80)),
                              border: Border.all()
                          ),
                          child : ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(80)),
                            child: Image.memory(user.profile_photo,fit: BoxFit.fitWidth,),
                          )
                      ),
                  )
                ],

              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: container_rounded("Today's Order", "${user.order.length}", Icon(IconHelper.icons[32],color: ColorHelper.color[9],), ColorHelper.color[3]),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: container_rounded("Today Revenue", "${user.revenue}", Icon(IconHelper.icons[31],color: ColorHelper.color[9]), ColorHelper.color[3]),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: container_rounded("Total Order", "${user.total_order}", Icon(IconHelper.icons[32],color: ColorHelper.color[9]), ColorHelper.color[3]),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: container_rounded("Total Revenue", "${user.total_revenue}", Icon(IconHelper.icons[31],color: ColorHelper.color[9]), ColorHelper.color[3]),
                )
              ],
            ),
          ),
          Expanded(child: home_body())

        ],
      ),
    );
  }
}
