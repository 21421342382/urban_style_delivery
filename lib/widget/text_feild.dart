
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constrants/colors.dart';

Widget TextFeild(hint_text , icon , controller , input_type, capital){
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.only(left: 24),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text("${hint_text}",style: TextStyle(color: ColorHelper.color[1],fontSize: 14),)),
      ),
      Container(
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(60)),
              color: ColorHelper.color[1].withOpacity(0.20)
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 18,right: 18),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      textCapitalization: capital == true
                          ? TextCapitalization.words
                          : TextCapitalization.none,
                      controller: controller,
                      cursorColor: ColorHelper.color[1],
                      keyboardType: input_type == "number"
                          ? TextInputType.number
                          : TextInputType.name,
                      decoration: InputDecoration.collapsed(
                        hintText: "${hint_text}",
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: icon,
                  )
                ],
              ),
            ),
          )
      ),
    ],
  );
}