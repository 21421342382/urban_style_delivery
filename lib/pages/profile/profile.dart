import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urban_style_delivery/pages/home/home.dart';

import '../../constrants/Icons.dart';
import '../../constrants/colors.dart';
import '../../user/user.dart';
import '../../widget/profile/profile_card.dart';


class account extends StatelessWidget {
  const account({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body : Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: ColorHelper.r_g_b[2],
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18,right: 18,top: 8),
                        child: InkWell(
                          onTap: (){
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => home()), (route) => false);
                          },
                          child: Row(
                            children: [
                              Icon(IconHelper.icons[7]),
                              Text("Account"),

                            ],
                          ),
                        ),
                      )),
                  SizedBox(height: 50,),
                  profile(),
                  SizedBox(height: 10,),
                  Center(
                    child: Text("${user.username}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
                  ),
                  SizedBox(height: 10,),
                  Divider(color: ColorHelper.color[1],),
                  Row(
                    children: [
                      SizedBox(width: 5,),
                      Text("Profile Details",style: TextStyle(color: ColorHelper.color[1]),),
                      Expanded(child: Divider(color: ColorHelper.color[1],))
                    ],
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(left: 8,right: 8),
                    child: Row(
                      children: [
                        Icon(IconHelper.icons[0],color: ColorHelper.color[1],),
                        SizedBox(width: 5,),
                        Text("${user.username}" , style: TextStyle(color: ColorHelper.color[1]),),
                        Expanded(child: Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                              onTap: (){
                                // AwesomeDialog(
                                //   context: context,
                                //   animType: AnimType.scale,
                                //   dialogType: DialogType.info,
                                //   body: Center(child: text_feild("Name", IconHelper.icons[0], account_controller.email)),
                                //   title: 'New Name',
                                //   desc:   'Enter new Name',
                                //   btnOkText: "Save",
                                //   btnOkOnPress: () {
                                //     account_controller.change_email(context);
                                //   },
                                // ).show();
                              },
                              child: Icon(IconHelper.icons[18])),
                        ))
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(left: 8,right: 8),
                    child: Row(
                      children: [
                        Icon(IconHelper.icons[28],color: ColorHelper.color[1],),
                        SizedBox(width: 5,),
                        Text("${user.phone}" , style: TextStyle(color: ColorHelper.color[1]),),
                        Expanded(child: Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                              onTap: (){
                                // AwesomeDialog(
                                //   context: context,
                                //   animType: AnimType.scale,
                                //   dialogType: DialogType.info,
                                //   body: Center(child: text_feild("Email", IconHelper.icons[0], account_controller.email)),
                                //   title: 'New Email',
                                //   desc:   'Enter new Email',
                                //   btnOkText: "Save",
                                //   btnOkOnPress: () {
                                //     account_controller.change_email(context);
                                //   },
                                // ).show();
                              },
                              child: Icon(IconHelper.icons[18])),
                        ))
                      ],
                    ),
                  ),
                  context.isPhone ? SizedBox(height: 20,) : SizedBox(),
                  context.isPhone
                      ?Padding(
                    padding: const EdgeInsets.only(left: 8,right: 8),
                    child: Row(
                      children: [
                        Icon(IconHelper.icons[12],color: ColorHelper.color[1],),
                        SizedBox(width: 5,),
                        Text("${user.sublocality} ," + "${user.locality} ," + "${user.postal_code}" , style: TextStyle(color: ColorHelper.color[1]),),

                      ],
                    ),
                  )
                      : SizedBox(),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(left: 8,right: 8),
                    child: Row(
                      children: [
                        Icon(IconHelper.icons[6],color: ColorHelper.color[1],),
                        SizedBox(width: 5,),
                        Text("Past Orders" , style: TextStyle(color: ColorHelper.color[1]),),
                        Expanded(child: Align(
                          alignment: Alignment.centerRight,
                          child: Text("${user.history.length}"),
                        )),
                        SizedBox(width: 8,)
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(left: 8,right: 8),
                    child: Row(
                      children: [
                        Icon(IconHelper.icons[31],color: ColorHelper.color[1],),
                        SizedBox(width: 5,),
                        Text("Total Revenue" , style: TextStyle(color: ColorHelper.color[1]),),
                        Expanded(child: Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                              onTap: (){
                                // AwesomeDialog(
                                //   context: context,
                                //   animType: AnimType.scale,
                                //   dialogType: DialogType.info,
                                //   body: Center(child: text_feild("Name", IconHelper.icons[0], account_controller.email)),
                                //   title: 'New Name',
                                //   desc:   'Enter new Name',
                                //   btnOkText: "Save",
                                //   btnOkOnPress: () {
                                //     account_controller.change_email(context);
                                //   },
                                // ).show();
                              },
                              child: Text("${user.revenue}")),
                        )),
                        SizedBox(width: 10,)
                      ],
                    ),
                  ),

                  SizedBox(height: 40,),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: InkWell(
                        onTap: (){
                          // account_controller.logout(context);
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
                            child: Text("Request Payout",style: TextStyle(color: ColorHelper.color[8]),),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: InkWell(
                        onTap: (){
                          // account_controller.logout(context);
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
                            child: Text("Log Out",style: TextStyle(color: ColorHelper.color[4]),),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: InkWell(
                        onTap: (){
                          // account_controller.delete_account(context);
                        },
                        child: Container(
                          height: 80,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: ColorHelper.color[4],
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
                            child: Text("Delete Account",style: TextStyle(color: ColorHelper.color[0]),),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
  }
}
