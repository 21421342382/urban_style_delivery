import 'package:flutter/material.dart';
import 'package:urban_style_delivery/constrants/Icons.dart';

import '../../constrants/colors.dart';

class history extends StatelessWidget {
  const history({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(IconHelper.icons[7]),
              ),
              Text("History",style: TextStyle(fontSize: 16),)
            ],
          )),
          Expanded(child: Align(
            alignment: Alignment.center,
            child: Text("Work in Progress !! ",style: TextStyle(color: ColorHelper.color[1]),),
          ))
        ],
      ),
    );
  }
}
