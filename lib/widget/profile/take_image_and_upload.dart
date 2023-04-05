import 'dart:convert';

import 'package:flutter/material.dart';
import '../../constrants/Icons.dart';
import '../../constrants/colors.dart';
import '../../controllers/profile/profile_controller.dart';
import '../../user/user.dart';


class take_image_and_upload extends StatefulWidget {
  const take_image_and_upload({Key? key, required this.img}) : super(key: key);
  final img ;
  @override
  State<take_image_and_upload> createState() => _take_image_and_uploadState();
}

class _take_image_and_uploadState extends State<take_image_and_upload> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 10,),
          SafeArea(child: Row(
            children: [
              SizedBox(width: 8,),
              InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Icon(IconHelper.icons[7],size: 30,)),
              SizedBox(width: 5,),
              Text("Select Image",style: TextStyle(fontSize: 18),)
            ],
          )),
          Expanded(child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
                height: double.infinity,
                width: double.infinity,
                child: Image.memory(widget.img,fit: BoxFit.fill,)
            ),
          )),
          SizedBox(height: 10,),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: InkWell(
                onTap: (){
                  user.has_profile_photo = true;
                  user.profile_photo = widget.img;
                  account_controller.update_profile_photo(context);
                },
                child: Container(
                  height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: ColorHelper.color[0],
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                            color: ColorHelper.color[1],
                            blurRadius: 30.0,
                            offset: Offset(0,20)
                        )
                      ]
                  ),
                  child: Center(
                    child: Text("Save",style: TextStyle(color: ColorHelper.color[8]),),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
