import 'package:auto_size_text/auto_size_text.dart';
import 'package:billing/models/Product.dart';
import 'package:billing/modules/home/tabs/open_map.dart';
import 'package:billing/modules/product_details/product_details_screen.dart';
import 'package:billing/routes/app_pages.dart';
import 'package:billing/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/Product.dart';
import '../../../shared/constants/colors.dart';
import '../../../shared/services/LocalString.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../shared/widgets/NetworkImageWidget.dart';
import '../../../globals.dart' as globals;

class ProductCard extends StatelessWidget {
  final Product? product;

  //final Function? onTap;
  ProductCard({this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        openDetails(product, context);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 6, bottom: 6, left: 2, right: 2),
        child: Container(
          //height: SizeConfig().screenHeight*ColorConstants.productHeight,
          width: SizeConfig().screenWidth * ColorConstants.productImgWidth,
          padding: EdgeInsets.only(top: 0, left: 0, right: 0),
          child: Card(
              elevation: 5,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white70, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        openDetails(product, context);
                      },
                      child: (product!.images != null &&
                              product!.images!.length > 0)
                          ? Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: getNetworkImage(
                                  context,
                                  product!.images[0].image,
                                  SizeConfig().screenWidth *
                                      ColorConstants.productImgWidth,
                                  CommonConstants.imageHeight))
                          : Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Image.asset(
                                'images/logo.jpg',
                                width: SizeConfig().screenWidth *
                                    ColorConstants.productImgWidth,
                                height: CommonConstants.imageHeight,
                              ),
                            ),
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    Divider(color: ColorConstants.greenColor, thickness: 2),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      // height: CommonConstants.remainHeight,
                      padding: EdgeInsets.only(left: 1, right: 1, top: 1),
                      child: Container(
                        child: Container(
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                          child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 1, right: 1),
                                                child: (product!.user
                                                                .photoProfile !=
                                                            null &&
                                                        product!.user
                                                                .photoProfile !=
                                                            '')
                                                    ? CircleAvatar(
                                                        radius: 15.0,
                                                        backgroundImage:
                                                            NetworkImage(product!
                                                                .user
                                                                .photoProfile),
                                                        backgroundColor:
                                                            Colors.transparent,
                                                      )
                                                    : CircleAvatar(
                                                        radius: 15.0,
                                                        backgroundColor:
                                                            ColorConstants
                                                                .lightGray,
                                                        child: Image.asset(
                                                            'images/logo.jpg'),
                                                      ),
                                              ),
                                              Expanded(
                                                  child: Container(
                                                      child: Column(children: [
                                                Text(
                                                  (product!.user.firstName),
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w100),
                                                  maxLines: 1,
                                                ),
                                                Text(
                                                  (product!.user.lastName),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w100),
                                                  maxLines: 1,
                                                )
                                              ])))
                                            ],
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 0, right: 0, top: 1),
                                            child: Container(
                                              height: 45,
                                              child: Center(
                                                child: Text(
                                                    (product!.title != null)
                                                        ? (product!.title!
                                                                    .length >
                                                                20)
                                                            ? (product!.title!
                                                                .substring(
                                                                    0, 15))
                                                            : product!.title!
                                                        : "",
                                                    // textAlign: TextAlign.center,
                                                    //overflow: TextOverflow.fade,
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF444444),
                                                        //fontFamily: CommonConstants.introTextFont,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ),
                                          ),
                                          //SizedBox(height: 10,),
                                          _buildButtonColumnViews(
                                              ColorConstants.greenColor,
                                              Icons.visibility,
                                              LocalString.getStringValue(
                                                      context, 'views') ??
                                                  "المشاهدات",
                                              product,context),
                                        ],
                                      )),
                                      Container(
                                        width: CommonConstants.remainWidth,
                                        // color: Colors.red,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            GestureDetector(
                                                onTap: () {
                                                  launch("tel://" +
                                                      product!.mobile);
                                                },
                                                child: _buildButtonColumn(
                                                  ColorConstants.greenColor,
                                                  Icons.call,
                                                  LocalString.getStringValue(
                                                          context, 'call') ??
                                                      "اتصال",
                                                )),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                openDetails(product, context);
                                              },
                                              child: _buildButtonColumn(
                                                  ColorConstants.darkGray,
                                                  Icons.table_view,
                                                  LocalString.getStringValue(
                                                          context, 'details') ??
                                                      "التفاصيل"),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            // _buildButtonColumn(ColorConstants.blue, Icons.today_sharp , product!.createdAt??" ")
                                            Container(
                                                width: 70,
                                                child: _buildButtonColumn(
                                                    ColorConstants.blue,
                                                    Icons.today_sharp,
                                                    product!.createdAt ?? " ")),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  void openDetails(Product? product, BuildContext context) {
    globals.product = product;
    if (ModalRoute.of(context)!.settings.name!.contains("DetailsScreen"))
      Get.offAndToNamed(Routes.details);
    //  Navigator.popAndPushNamed(context, Routes.details);
    else
      Get.to(DetailsScreen(
        product: product,
      ));
    //  Get.to(DetailsScreen(product: product,));
    //Navigator.push(context,MaterialPageRoute(builder: (context) =>  DetailsScreen(product: product,)));
    //Get.offAndToNamed(Routes.details);
    //Get.to(DetailsScreen(product: product,));
    // Get.tcdsfdgfo(DetailsScreen(product: product,));
  }

  Widget getNetworkImage(
      BuildContext context, String url, double width, double height) {
    /*
   return CachedNetworkImage(
      imageUrl: url,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: CircularProgressIndicator(value: downloadProgress.progress,color: ColorConstants.greenColor,),
          ),
      errorWidget: (context, url, error) =>Image.asset(
        'images/logo.png',
        fit: BoxFit.fill,
      ),
      width: width,
      height: height,
    );

     */
    return Container(
        width: MediaQuery.of(context).size.width,
        height: height,
        child: CachedNetworkImage(
          imageUrl: url,
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              Text(''),
          errorWidget: (context, url, error) => Image.asset(
            'images/logo.jpg',
            fit: BoxFit.fill,
          ),
          fit: BoxFit.fill,
        ));
  }

  Container _buildButtonColumn(Color color, IconData icon, String label) {
    return Container(
      // height: 10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: color,
            size: 15,
          ),
          Container(
            margin: const EdgeInsets.only(top: 1),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row _buildButtonColumnViews(
      Color color, IconData icon, String label, Product? product,BuildContext context) {
    return Row(
      //mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //  crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 2.0,right: 2),
          child: Column(
            children: [
              Text(
                LocalString.getStringValue(
                    context, 'price') ??
                    "السعر",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Container(
                  child: (product!.price != null)
                      ? Text(
                          product!.price!.toString(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: color,
                          ),
                        )
                      : Text(
                          "0 " + label,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: color,
                          ),
                        )),
            ],
          ),
        ),
        Column(
          children: [
            Icon(icon, color: color),
            Container(
                child: (product!.views != null)
                    ? Text(
                        product!.views!.toString() + " " + label,
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w400,
                          color: color,
                        ),
                      )
                    : Text(
                        "0 " + label,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: color,
                        ),
                      )),
          ],
        ),
      ],
    );
  }
}
