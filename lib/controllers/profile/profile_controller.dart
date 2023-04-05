import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urban_style_delivery/pages/account/login/login.dart';


import '../../pages/home/home.dart';
import '../../pages/profile/profile.dart';
import '../../user/user.dart';
import '../../widget/profile/take_image_and_upload.dart';

class account_controller{
  static TextEditingController name = new TextEditingController();
  static TextEditingController email = new TextEditingController();
  static TextEditingController location = new TextEditingController();
  ////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////
  final picker = ImagePicker();
  var cmpressed_image ;

  static change_name(context) async{
    if(email.text == ""){
      Get.snackbar(
          "Something went wrong !",
          "Enter email correctly"
      );
    }else{
      user.username = name.text;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("name", user.username);
      var todo1 = ParseObject('users')
        ..objectId = user.obj_id
        ..set('username', user.username);
      await todo1.save();
      print("Name Changed Successfull");
      Get.snackbar(
          "Name Changed !",
          "Name Changed Successfully"
      );
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => home()), (route) => false);

    }
  }


  // static change_email(context) async{
  //   if(email.text == ""){
  //     Get.snackbar(
  //         "Something went wrong !",
  //         "Enter email correctly"
  //     );
  //   }else{
  //     user.email = email.text;
  //     var todo1 = ParseObject('users')
  //       ..objectId = user.obj_id
  //       ..set('email', user.email);
  //     await todo1.save();
  //     print("Name Changed Successfull");
  //     Get.snackbar(
  //         "Email Changed !",
  //         "Email Changed Successfully"
  //     );
  //     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => home()), (route) => false);
  //
  //   }
  // }

  static logout(context) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("login");
    prefs.remove("name");
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => login()), (route) => false);

  }

  static delete_account(context) async{

    var obj ;


    var todo2 = ParseObject('users')..objectId = user.obj_id;
    await todo2.delete();
    //////////////////////////////////// SELLER ACCOUNT DELETED /////////////////////////////////////////////
    // final QueryBuilder<ParseObject> parseQuery =
    // QueryBuilder<ParseObject>(ParseObject('tokens'));
    // // `whereContains` is a basic query method that checks if string field
    // // contains a specific substring
    // parseQuery.whereContains('token', user.secret_key);
    //
    // // The query will resolve only after calling this method, retrieving
    // // an array of `ParseObjects`, if success
    // final ParseResponse apiResponse = await parseQuery.query();
    //
    // if (apiResponse.success && apiResponse.results != null) {
    //   for (var o in apiResponse.results!) {
    //     var data = apiResponse.results as List<ParseObject>;
    //     obj = data[0]["objectId"];
    //     print(obj);
    //   }
    // }else{
    // }
    // var todo3 = ParseObject('tokens')..objectId = obj;
    // await todo3.delete();
    // print(obj);
    // print("Done !! ");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("login");
    prefs.remove("name");
    user.has_profile_photo = false;
    user.profile_photo = "";
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => login()), (route) => false);

  }

  static update_profile_photo(context) async{
    print(user.profile_photo);
    print(user.has_profile_photo);
    print(user.obj_id);
    var todo = ParseObject('deliveryBoy')
      ..objectId = user.obj_id
      ..set('profile_photo', user.profile_photo);
    await todo.save();
    print("Profile Photo Saved");
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => account()), (route) => false);

  }

  take_image(context) async{
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile!=null){
      try {
        cmpressed_image = await FlutterImageCompress.compressWithFile(
            pickedFile.path,
            format: CompressFormat.heic,
            quality: 70
        );

      } catch (e) {
        cmpressed_image = await FlutterImageCompress.compressWithFile(
            pickedFile.path,
            format: CompressFormat.jpeg,
            quality: 70
        );


      }
      print(cmpressed_image);
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => take_image_and_upload(img: cmpressed_image,)));
    }

  }



}