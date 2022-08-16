import 'package:billing/models/Package.dart';
import 'package:billing/models/Product.dart';
import 'package:billing/models/responses/packages_response.dart';
import 'package:billing/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/PackageInnerCustom.dart';
import '../../../models/Product.dart';
import '../../../models/responses/user_packages.dart';
import '../../../shared/constants/colors.dart';
import '../../../shared/services/LocalString.dart';
import '../../../shared/widgets/custom_rounded.dart';
import '../../../globals.dart' as globals;
import '../../product_details/product_details_screen.dart';

class SearchCard extends StatelessWidget {
  final Product? product;
  //final Function? onTap;
  SearchCard({
    this.product
  });
  @override
  Widget build(BuildContext context) {
    return  ListTile(
      minLeadingWidth : 10,
      leading: Container(
        //  color: ColorConstants.black,
          child: Icon(Icons.history,size: 30,)),
      title: Text(product!.title),
      trailing:  TextButton(

          onPressed: () {
            Get.to(DetailsScreen(product: product,));
          },
          child:  Text(LocalString.getStringValue(context, 'show_result') ??
              "عرض النتائج"
            ,
            style: TextStyle(color: ColorConstants.black),
          )),
    );
  }

}

