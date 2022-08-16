import 'package:billing/routes/app_pages.dart';
import 'package:billing/shared/constants/colors.dart';
import 'package:flutter/material.dart';

import '../../../models/responses/categories_response.dart';
import '../../../shared/utils/size_config.dart';
import 'package:get/get.dart';

import '../../category/categorys_screen.dart';
import '../../../globals.dart' as globals;
class CategoryCard extends StatelessWidget {
  final Category? category;
   CategoryCard({
     this.category
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(category!.id==-1)
          {
            Get.toNamed(Routes.companies);
          }
        else
        Get.to(CategoryScreen(mainCategoryName: category!.name, mainCategoryId: category!.id,category: category,));
      },
      child: Container(
        decoration: BoxDecoration(
       //  border: Border.all(color: Color(0xffeeeeee), width: 2.0),
          //color: Colors.white38,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.white10,
              blurRadius: 4,
              spreadRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
        ),
        margin: EdgeInsets.all(1),
        //height: ColorConstants.categoryHeight,
        width: SizeConfig().screenWidth*ColorConstants.categoryWidth,
        height: SizeConfig().screenWidth*ColorConstants.categoryWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            (category!.image!="")?
            Container(
              height: SizeConfig().screenWidth*ColorConstants.categoryWidth,
              child: CircleAvatar(
                backgroundColor: Colors.black,
                radius: SizeConfig().screenWidth*ColorConstants.categoryWidth,
                child:  CircleAvatar(
                  radius:SizeConfig().screenWidth*ColorConstants.categoryWidth,
                  backgroundImage:  NetworkImage(category!.image??'images/logo.jpg'),
                  backgroundColor: Colors.transparent,
                )
              ),
            ):
            (globals.staticPageResponse!.data!.company_image!=null)?
            Container(
              height: SizeConfig().screenWidth*ColorConstants.categoryWidth,
              child: CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: SizeConfig().screenWidth*ColorConstants.categoryWidth,
                  child:  CircleAvatar(
                    radius:SizeConfig().screenWidth*ColorConstants.categoryWidth,
                    backgroundImage:NetworkImage(globals.staticPageResponse!.data!.company_image??'images/companies.jpg'),

                   // AssetImage('images/companies.jpg'),
                    backgroundColor: Colors.transparent,
                  )
              ),
            ):
            Container(
              height: SizeConfig().screenWidth*ColorConstants.categoryWidth,
              child: CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: SizeConfig().screenWidth*ColorConstants.categoryWidth,
                  child:  CircleAvatar(
                    radius:SizeConfig().screenWidth*ColorConstants.categoryWidth,
                    backgroundImage: AssetImage('images/companies.jpg'),
                    backgroundColor: Colors.transparent,
                  )
              ),
            )
            ,
            Container(
             // width: SizeConfig().screenWidth*ColorConstants.categoryWidth-5,
              child: Text(
                (category!.name),
                textAlign: TextAlign.center,
                maxLines: 2,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10.0,
                    //color: flavorColor
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}