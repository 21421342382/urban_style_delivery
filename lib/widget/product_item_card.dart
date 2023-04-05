import 'dart:convert';

import 'package:flutter/cupertino.dart';


import '../../user/user.dart';
import '../constrants/colors.dart';

Widget packging_product_item_card(index ,product){
  return Container(
    height: 130,
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      color: ColorHelper.r_g_b[7],

    ),
    child: Row(
      children: [
        SizedBox(width: 8,),
        Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(80)),
                color: ColorHelper.color[3].withOpacity(0.40)
            ),
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(80)),
                    color: ColorHelper.color[3].withOpacity(0.85)
                ),
                child: Center(
                    // child: Image.memory(product[0]["image"],fit: BoxFit.fill,)
                ),
              ),
            )
        ),
        SizedBox(width: 15,),
        Expanded(
          child: Column(
            children: [
              SizedBox(height: 30,),
              Container(
                  width: double.infinity,
                  child: Text("${product[0]["title"]}",style: TextStyle(fontSize: 15,color: ColorHelper.color[2]),overflow: TextOverflow.ellipsis,)),
              SizedBox(height: 10,),
              Container(
                  width: double.infinity,
                  child: Text("${product[0]["price"]}",style: TextStyle(fontSize: 15,color: ColorHelper.color[1]),overflow: TextOverflow.ellipsis,)),

            ],
          ),
        ),
      ],
    ),
  );
}