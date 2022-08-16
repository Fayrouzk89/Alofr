import 'package:auto_size_text/auto_size_text.dart';
import 'package:billing/models/Company.dart';
import 'package:billing/models/Product.dart';
import 'package:billing/modules/home/tabs/open_map.dart';
import 'package:billing/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/NotificationModel.dart';
import '../../../shared/constants/colors.dart';
import '../../../shared/services/DateConverter.dart';
import '../../../shared/services/LocalString.dart';
import '../../../shared/widgets/NetworkImageWidget.dart';
import '../../../shared/widgets/custom_rounded.dart';
import '../../Allproducts/products_screen.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel? data;

  //final Function? onTap;
  NotificationCard({this.data});

  @override
  Widget build(BuildContext context) {
    /*
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  data!.title, overflow: TextOverflow.ellipsis, maxLines: 4,

                ),
              ),


            ],
          ),
        ),


      ],
    );

     */
    //  DateTime _originalDateTime = DateConverter.isoStringToLocalDate(data!.createdAt);
    //  DateTime _convertedDate = DateTime(_originalDateTime.year, _originalDateTime.month, _originalDateTime.day);
    bool _addTitle = true;

    return  Wrap(
      children: [
        Card(
          elevation: 5,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white70, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(data!.createdAt,),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(5),

                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset('images/logo.jpg'),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data!.title,
                          style: TextStyle(color: ColorConstants.greenColor,fontSize: 18,fontWeight: FontWeight.bold),
                        ),
                        Text(
                          data!.description,
                          style: TextStyle(color: ColorConstants.black,fontSize: 15),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ],
    );
  }
}
