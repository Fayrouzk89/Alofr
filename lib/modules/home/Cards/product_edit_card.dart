import 'package:auto_size_text/auto_size_text.dart';
import 'package:billing/models/Product.dart';
import 'package:billing/modules/home/tabs/open_map.dart';
import 'package:billing/modules/product_details/product_details_screen.dart';
import 'package:billing/routes/app_pages.dart';
import 'package:billing/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/Product.dart';
import '../../../shared/constants/colors.dart';
import '../../../shared/services/LocalString.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../shared/widgets/NetworkImageWidget.dart';
import '../../my_ads/my_ads_controller.dart';
import '../tabs/new_adds.dart';
import '../../../globals.dart' as globals;
class ProductEditCard extends StatelessWidget {
  final Product? product;
  final MyAdsController? controller;

  //final Function? onTap;
  ProductEditCard({this.product, this.controller});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 1),
          decoration: BoxDecoration(
            color: ColorConstants.white,
            borderRadius: BorderRadius.circular(1),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5,
                spreadRadius: 1,
              )
            ],
          ),
          child: Row(children: [
            Padding(
              padding: const EdgeInsets.only(left: 1,right: 1),
              child: (product!.images != null && product!.images!.length > 0)?
              CircleAvatar(
                radius: 50.0,

                backgroundImage:
                NetworkImage(  product!.images[0].image,)

                ,
                backgroundColor: Colors.grey,
              ):
              CircleAvatar(
                radius: 50.0,
                backgroundColor: Colors.grey,
                child: Image.asset( 'images/logo.jpg'),
              )
              ,
            ),

            SizedBox(width: 10),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        (LocalString.getStringValue(context, 'adds_name') ??
                                "اسم الإعلان") +
                            ": " +
                            product!.title,
                        style: TextStyle(
                            color: Color(0xFF444444),
                            //fontFamily: CommonConstants.introTextFont,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text(
                        (LocalString.getStringValue(
                            context, 'adds_status') ??
                            "حالة الإعلان") +
                            ": " +
                            product!.status,
                        //  (data!.firstName!=null)?data!.firstName:"",
                        // textAlign: TextAlign.center,
                        //overflow: TextOverflow.fade,
                        style: TextStyle(
                            color: Color(0xFF444444),
                            //fontFamily: CommonConstants.introTextFont,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                   // SizedBox(height: 10),
                    (product!.note!="")?
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text(
                            (LocalString.getStringValue(
                                context, 'reason_reject') ??
                                "سبب الرفض") +
                                ": " +
                                product!.note,
                            //  (data!.firstName!=null)?data!.firstName:"",
                            // textAlign: TextAlign.center,
                            //overflow: TextOverflow.fade,
                            style: TextStyle(
                                color: Color(0xFF444444),
                                //fontFamily: CommonConstants.introTextFont,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 10)
                      ],
                    )
                   :
                    SizedBox(height: 10),
                    Text(
                        (LocalString.getStringValue(
                            context, 'description') ??
                            "توصيف الإعلان") +
                            ": " +
                            product!.desctiption,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        //  (data!.firstName!=null)?data!.firstName:"",
                        // textAlign: TextAlign.center,
                        //overflow: TextOverflow.fade,
                        style: TextStyle(
                            color: Color(0xFF444444),
                            //fontFamily: CommonConstants.introTextFont,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 2,right: 2),
              child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                _buildButtonColumnViews(
                    ColorConstants.greenColor,
                    Icons.visibility,
                    LocalString.getStringValue(context, 'views') ?? "المشاهدات",
                    product),
                Expanded(child: SizedBox()),
                GestureDetector(
                  onTap: ()
                  {
                    openEditProduct(product);
                  },
                  child: Padding(
                    padding:const EdgeInsets.only(left: 2,right: 2),
                    child: _buildButtonColumnEdit(
                      Colors.blueGrey,
                      Icons.edit,
                      LocalString.getStringValue(
                          context, 'edit') ??
                          "تعديل",
                    ),
                  ),
                ),  Expanded(child: SizedBox()),

                Padding(
                  padding: const EdgeInsets.only(left: 2,right: 2),
                  child:  GestureDetector(
                    onTap: ()
                    {
                      DisplayDialogDelete(product,context);
                    },
                    child: _buildButtonColumnEdit(
                      Colors.red,
                      Icons.delete,
                      LocalString.getStringValue(
                          context, 'delete') ??
                          "حذف",
                    ),
                  ),
                ),
              ]),
            ),
          ]),
        ),
      ),
    );
  }

  void openDetails(Product? product) {
    Get.to(DetailsScreen(
      product: product,
    ));
  }

  Widget getNetworkImage(
      BuildContext context, String url, double width, double height) {
    return NetworkImageWidget(url: url, width: width, height: height);
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

  Column _buildButtonColumnViews(
      Color color, IconData icon, String label, Product? product) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
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
    );
  }

  Column _buildButtonColumnEdit(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 25),
        Container(
            child: Text(
          label,
          style: TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.w400,
            color: color,
          ),
        )),
      ],
    );
  }

  void DisplayDialogDelete(Product? product, BuildContext context) {
    SweetAlert.show(context,
        subtitle: LocalString.getStringValue(context, 'delete_confirmation') ??
            "هل تريد تأكيد حذف الإعلان؟",
        style: SweetAlertStyle.confirm,
        cancelButtonText:
            LocalString.getStringValue(context, 'cancel') ?? "إلغاء",
        confirmButtonText:
            LocalString.getStringValue(context, 'confirm') ?? "تأكيد",
        showCancelButton: true, onPress: (bool isConfirm) {
      if (isConfirm) {
        Navigator.of(context).pop();
        CallDeleteProduct(product, context);
        /*
            new Future.delayed(new Duration(seconds: 2),(){
              SweetAlert.show(context,subtitle: "Success!", style: SweetAlertStyle.success);
            });

             */
      } else {
        SweetAlert.show(context,
            subtitle: "Canceled!", style: SweetAlertStyle.error);
      }
      // return false to keep dialog
      return false;
    });
  }

  void CallDeleteProduct(Product? product, BuildContext context) async {
    controller!.deleteProduct(context, product!);
  }

  void openEditProduct(Product? product) {
    Get.to(NewAdds(true, product,globals.controller!));
  }
}
