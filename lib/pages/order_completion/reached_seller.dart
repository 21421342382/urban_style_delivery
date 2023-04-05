import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:urban_style_delivery/constrants/colors.dart';
import 'package:urban_style_delivery/widget/product_item_card.dart';

class reached_seller extends StatelessWidget {
  reached_seller({Key? key, required this.otp, required this.drop_lat, required this.drop_long, required this.product}) : super(key: key);
final otp ;
final drop_lat;
final drop_long ;
final product ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50,),
          SafeArea(child: Center(
            child: Text("Yo've arrived at the sellers location",style: TextStyle(fontSize: 18,color: ColorHelper.color[1]),),
          )),
          SizedBox(height: 20,),
          Center(
            child: Text("${otp}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
          ),
          Center(
            child: Text("Tell This OTP to the Shop Owner"),
          ),
          SizedBox(height: 20,),
          Divider(),
          Row(
            children: [
              SizedBox(width: 5,),
              Text("Product",style: TextStyle(color: ColorHelper.color[1]),),
              SizedBox(width: 5,),
              Expanded(child: Divider()),
            ],
          ),
          Container(
            height: 500,
            child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context , index){
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: packging_product_item_card(index, product),
              );
            }),
          ),
          Expanded(child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: ColorHelper.color[8]
                ),
                child: Center(
                    child: Text("Go to final destination",style: TextStyle(color: ColorHelper.color[0]),)
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
