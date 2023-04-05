import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constrants/Icons.dart';
import '../../controllers/profile/profile_controller.dart';
import '../../user/user.dart';

class profile extends StatelessWidget {
  const profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(context.isPhone){
          account_controller().take_image(context);
        }else{
          Get.snackbar(
            "Can't show profile photo on web",
            "Can't show profile photo on web. It will be fixed after some updates",
          );
        }
      },
      child: Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(80)),
              border: Border.all()
          ),
          child: context.isPhone
              ?user.profile_photo == null
              ? Center(
            child: Icon(IconHelper.icons[17]),
          )
              : ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(80)),
            child: Image.memory(user.profile_photo,fit: BoxFit.fitWidth,),
          )
              : Center(
            child: Icon(IconHelper.icons[0],size: 44,),
          )
      ),
    );
  }
}
