import 'package:flutter/material.dart';
import 'package:urban_style_delivery/constrants/colors.dart';

Widget container_rounded(
    title,
    number,
    icon,
    base_color,
    ) {
  return Container(
    height: 150,
    width: 110,
    child: Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 2, bottom: 4),
              child: Text(
                "${title}",
                style: TextStyle(
                    fontSize: 14,
                    color: ColorHelper.color[1],
                    overflow: TextOverflow.ellipsis),
              ),
            )),
        Container(
          height: 120,
          width: 110,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: ColorHelper.color[0],
              boxShadow: [
                BoxShadow(
                    blurRadius: 2.0,
                    color: ColorHelper.color[1].withOpacity(0.80))
              ]),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(child: icon),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "${number}",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: base_color),
                )
              ],
            ),
          ),
        )
      ],
    ),
  );
}
