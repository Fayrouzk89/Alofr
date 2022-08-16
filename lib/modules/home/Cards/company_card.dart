import 'package:auto_size_text/auto_size_text.dart';
import 'package:billing/models/Company.dart';
import 'package:billing/models/Product.dart';
import 'package:billing/modules/home/tabs/open_map.dart';
import 'package:billing/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../shared/constants/colors.dart';
import '../../../shared/services/LocalString.dart';
import '../../../shared/widgets/NetworkImageWidget.dart';
import '../../../shared/widgets/custom_rounded.dart';
import '../../Allproducts/products_screen.dart';

class CompanyCard extends StatelessWidget {
  final Company? data;
  //final Function? onTap;
  CompanyCard({
    this.data
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {


      },
      child: Padding(
        padding: const EdgeInsets.only(top:10.0,bottom: 10,left: 5,right: 5),
        child: Container(
          //height: SizeConfig().screenHeight*ColorConstants.productHeight,
          width: SizeConfig().screenWidth,
          padding: EdgeInsets.only(top: 0,left: 0,right: 0),
          child: Card(
              elevation: 5,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white70, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child:

              Container(
                child: Column(
                  children: <Widget>[
                    (data!.photoProfile!= null &&data!.photoProfile! !='' )?
                    Padding(
                        padding: const EdgeInsets.all(0.0),
                        child:  getNetworkImage(context,data!.photoProfile,SizeConfig().screenWidth, CommonConstants.imageHeight)
                    ):
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Image.asset(
                        'images/logo.jpg',
                        width: SizeConfig().screenWidth,
                        height: CommonConstants.imageHeight,
                      ),
                    ),
                    SizedBox(height: 5,),
                    Divider(color: ColorConstants.greenColor,thickness:2),
                    SizedBox(height: 5,),
                    Container(

                      alignment: Alignment.topCenter,
                      // height: CommonConstants.remainHeight,
                      padding: EdgeInsets.only(left: 1, right: 1, top: 1),
                      child: InkWell(
                        onTap: () {
                          print ('Click Profile Pic');
                        },
                        child: Container(
                          // height: CommonConstants.remainHeight,
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(width: 3,),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                              data!.firstName+ " "+ data!.lastName,
                                            //  (data!.firstName!=null)?data!.firstName:"",
                                              // textAlign: TextAlign.center,
                                              //overflow: TextOverflow.fade,
                                              style: TextStyle(
                                                  color: Color(0xFF444444),
                                                  //fontFamily: CommonConstants.introTextFont,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 100,
                                            child: CustomRounded(
                                              text:LocalString.getStringValue(context, 'call') ?? "اتصال",
                                              textSize: CommonConstants.textApp,
                                              textColor: Colors.white,
                                              color: ColorConstants.greenColor,
                                              size: Size(SizeConfig().screenWidth * 0.8,
                                                  CommonConstants.roundedHeight),
                                              pressed: () {
                                                print(data!.mobile);
                                                launch("tel://" +data!.mobile);
                                                //Get.toNamed(Routes.AUTH + Routes.REGISTER, arguments: controller);
                                              },
                                            ),
                                          ),
                                          SizedBox(width: 5,),
                                          Container(
                                            width: 140,
                                            child: CustomRounded(
                                              text: LocalString.getStringValue(context, 'view_ads') ?? "عرض الإعلانات",
                                              textSize: CommonConstants.textApp,
                                              textColor: ColorConstants.greenColor,
                                              color: Colors.white,
                                              size: Size(SizeConfig().screenWidth * 0.8,
                                                  CommonConstants.roundedHeight),
                                              pressed: () {

                                                Get.to(ProductsScreen(categoryId: data!.id,
                                                  categoryName: data!.firstName +" "+data!.lastName ,
                                                ));


                                              },
                                            ),
                                          ),
                                        //  Container(child: _buildButtonColumn(ColorConstants.greenColor, Icons.call, LocalString.getStringValue(context, 'call') ?? "اتصال",)),
                                          SizedBox(width: 3,),
                                         // Container(child: _buildButtonColumn(ColorConstants.blue, Icons.call, LocalString.getStringValue(context, 'view_ads') ?? "عرض الإعلانات",)),
                                         // SizedBox(width: 10,),
                                        ],
                                      ),
                                    ],
                                  ),

                                ],
                              ),

                            ],
                          )
                          ,
                        ),
                      ),
                    ),

                  ],
                ),
              )
          ),
        ),
      ),
    );
  }
  Container _buildButtonColumn(Color color, IconData icon, String label) {
    return Container(
      // height: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: color,size:30,),
          Container(
            margin: const EdgeInsets.only(top:1),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget getNetworkImage(BuildContext context,String url,double width,double height)
  {

    return NetworkImageWidget(url:url,width:width,height:height);
  }
}

