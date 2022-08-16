import 'package:billing/modules/Allproducts/products_controller.dart';
import 'package:billing/modules/buy/buy_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';
import '../../shared/constants/colors.dart';
import '../../shared/constants/common.dart';
import '../../shared/services/LocalString.dart';
import '../../shared/widgets/AppBars/build_header.dart';
import '../../shared/widgets/AppBars/silver_custom.dart';
import '../../shared/widgets/no_date.dart';
import '../home/Cards/product_card.dart';
import '../solid_app_bar.dart';
import '../../globals.dart' as globals;
class ProductsScreen extends StatefulWidget {
  final int categoryId;
  final String categoryName;
  const ProductsScreen({Key? key,required this.categoryId,required this.categoryName}) : super(key: key);
  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  ProductsController? homePageController;
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homePageController = Get.put(ProductsController(apiRepository: Get.find(),categoryId:widget.categoryId ));
  }
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    //return
      /*Stack(
        children: <Widget>[
          Positioned(
              top: 1,
              left: 0,
              right: 0,
              child:  Obx(
                      () =>home(orientation)
              )

            //_buildForms(context)
          ),
        ]
    );

       */
    /*
    return Scaffold(
        backgroundColor: ColorConstants.greyBack,
        appBar:

        SolidAppBar(title:
        (widget.categoryId==globals.publicProducts)?
        LocalString.getStringValue(context, 'all_products') ??
            "كافة المنتجات"
          :
            widget.categoryName
          ,),
        body:
        Obx(
                () =>home(orientation)
        )

    );

     */


    return Scaffold(
      backgroundColor: ColorConstants.greyBack,
      body: CustomScrollView(
        slivers: [
          SilverAppBarCustom(  title: (widget.categoryId==globals.publicProducts)?
          LocalString.getStringValue(context, 'all_products') ??
              "كافة المنتجات"
              :
          widget.categoryName,)
             ,
          SliverFillRemaining(
            hasScrollBody: true,
            child: Obx(
                    () =>home(orientation)
            )
          )
        ],
      ),
    );
  }

  Widget home(orientation )
  {
   return (homePageController!.products!=null && homePageController!.products.value!=null)?
   (homePageController!.products.value!.data.isEmpty)?
   NoData(  text: LocalString.getStringValue(context, 'no_products') ??
       "لا يوجد إعلانات", imagePath: 'images/review.png', ):
    Container(
      child: GetBuilder(
        init: homePageController,
        builder: (value) => GridView.builder(
          padding: EdgeInsets.all(1),
          physics: AlwaysScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: CommonConstants.listViewHeight+10,
              crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3),
          shrinkWrap: true,
          controller: homePageController!.controller,
          itemCount: homePageController!.products.value!.data.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 4,right: 4),
              child:  ProductCard(
                  product: homePageController!.products.value!.data[index],
                )
              /*
              child: Container(
                color: Colors.red,
                height: 100,
                child: Center(
                  child: Text(homePageController.products.value!.data[index].title),
                ),
              ),

               */
            );
          },
        ),
      ),
    ):Text("");
  }
}
