import 'package:billing/models/Package.dart';
import 'package:billing/models/Product.dart';
import 'package:billing/models/responses/packages_response.dart';
import 'package:billing/shared/shared.dart';
import 'package:flutter/material.dart';

import '../../../models/PackageInnerCustom.dart';
import '../../../models/Product.dart';
import '../../../models/responses/user_packages.dart';
import '../../../shared/constants/colors.dart';
import '../../../shared/services/LocalString.dart';
import '../../../shared/widgets/custom_rounded.dart';
import '../../../globals.dart' as globals;

class UserPackageCard extends StatelessWidget {
  final UserPackages? package;
  //final Function? onTap;
  UserPackageCard({
    this.package
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {


      },
      child: Padding(
        padding: const EdgeInsets.only(top:1.0,bottom: 2,left: 10,right: 10),
        child: Container(
          //height: SizeConfig().screenHeight*ColorConstants.productHeight,
          width: SizeConfig().screenWidth*ColorConstants.productImgWidth,
          padding: EdgeInsets.only(top: 3,left: 3,right: 3),
          child: Card(
              elevation: 5,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white70, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child:

              Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 1, right: 1, top: 10,bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child:
                            Text(
                                (package!.package!.nameAr!=null && globals.lang=="ar")?
                                (package!.package!.nameAr):
                                (package!.package!.nameEn!=null && globals.lang!="ar")?
                                (package!.package!.nameEn):
                                "",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color:ColorConstants.greenColor,
                                    fontFamily: CommonConstants.largeTextFont,
                                    fontSize: CommonConstants.meduimText,
                                    fontWeight: FontWeight.w400)),),

                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 1, right: 1, top: 10,bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child:
                            Row(
                              children: [
                                Text(
                                    (LocalString.getStringValue(context, 'price') ?? "السعر"),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color(0xFF444444),
                                        fontFamily: CommonConstants.largeTextFont,
                                        fontSize: CommonConstants.smallText,
                                        fontWeight: FontWeight.w400)),
                                Text(
                                    ( package!.package!.price.toString()),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color(0xFF444444),
                                        fontFamily: CommonConstants.largeTextFont,
                                        fontSize: CommonConstants.smallText,
                                        fontWeight: FontWeight.w400)),
                              ],
                            ),),

                        ],
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.only(left: 1, right: 1, top: 10,bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child:
                            Row(
                              children: [
                                Text(
                                    (LocalString.getStringValue(context, 'Published_ads_lbl') ?? "الاعلانات المنشورة") +": "+ ( package!.publishedAdvs.toString()),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color(0xFF444444),
                                        fontFamily: CommonConstants.largeTextFont,
                                        fontSize: CommonConstants.smallText,
                                        fontWeight: FontWeight.w400)),
                                SizedBox(width: 10,),
                                Text(
                                    (LocalString.getStringValue(context, 'remain_ads_lbl') ?? "الاعلانات المتبقية") +": "+ ( package!.restAdvs.toString()),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color(0xFF444444),
                                        fontFamily: CommonConstants.largeTextFont,
                                        fontSize: CommonConstants.smallText,
                                        fontWeight: FontWeight.w400)),
                              ],
                            ),),

                        ],
                      ),
                    ),
                    /*
                    // Divider(color: ColorConstants.greenColor,thickness:2),
                    Container(
                      alignment: Alignment.bottomLeft,
                      padding: EdgeInsets.only(left: 1, right: 1, top: 1),
                      child: InkWell(
                        onTap: () {
                          print ('Click Profile Pic');
                        },
                        child: Container(
                            alignment: Alignment.center,
                            margin:  EdgeInsets.symmetric(horizontal: CommonConstants.horizontalPaddingButton, vertical: CommonConstants.verticalPaddingButton),
                            child: CustomRounded(
                              text: LocalString.getStringValue(context, 'change_package') ?? "تغيير الحزمة",
                              textSize: CommonConstants.textButton,
                              textColor: Colors.white,
                              color: ColorConstants.greenColor,
                              size: Size(SizeConfig().screenWidth  * 0.8, CommonConstants.roundedHeightSmall),
                              pressed: () {
                                // loadAssets();
                              },
                            )),
                      ),
                    ),

                     */
                    SizedBox(height: 10,),
                  ],
                ),
              )
          ),
        ),
      ),
    );
  }

}

