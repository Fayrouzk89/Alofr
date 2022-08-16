import 'package:billing/models/Product.dart';
import 'package:billing/modules/home/tabs/slider_adver.dart';
import 'package:billing/modules/home/tabs/widgets/category_page.dart';
import 'package:billing/shared/widgets/SearchWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:getwidget/getwidget.dart';

import '../../../routes/app_pages.dart';
import '../../../shared/constants/colors.dart';
import '../../../shared/constants/common.dart';
import '../../../shared/services/LocalString.dart';
import '../../../shared/utils/common_widget.dart';
import '../../../shared/utils/size_config.dart';
import '../../Allproducts/products_screen.dart';
import '../Cards/category_card.dart';
import '../Cards/product_card.dart';
import '../Shimmer/BannerShimmer.dart';
import '../Shimmer/CategoryShimmer.dart';
import '../Shimmer/ProductShimmer.dart';
import '../home_controller.dart';
class MainTab extends StatefulWidget {
 final HomeController controller;

  const MainTab({Key? key,required this.controller}) : super(key: key);
  @override
  State<MainTab> createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> {
  @override
  Widget build(BuildContext context) {
    return   _buildGridView(widget.controller);
  }

  Widget _buildGridView(HomeController controller) {
    return MainTabWidget(controller: controller);
  }
}

class MainTabWidget extends StatefulWidget {
  final HomeController? controller;

  const MainTabWidget({Key? key, this.controller}) : super(key: key);
  @override
  State<MainTabWidget> createState() => MainTabState();
}

class MainTabState extends State<MainTabWidget> {
  double height = SizeConfig().screenHeight * ColorConstants.productHeightList;

  @override
  Widget build(BuildContext context) {
    var sc = SizeConfig();
    return  _buildMainScreen();


  }
  Widget _buildMainScreen()
  {
    return  RefreshIndicator(
        onRefresh: _loadData,
        child:
      SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          buildSearchWidget(),
          Obx(
                () => _buildSlider(),
          ),

          Obx(
                () =>buildCategories(),
          ),

          Obx(
                () =>buildPopularWidgetBody(context),
          ),
         // buildGridProducts(),

          Obx(
                () =>buildLatestWidgetBody(context),
          ),




        ],
      ),
    ));
  }
  Future<void> _loadData() async {
    try {

        await widget.controller!.getCategories();
        await widget.controller!.getLatestProducts();
        await widget.controller!.getPopular();
        await widget.controller!.getSubCategories();

        setState(() {

        });

    } catch (err) {
      rethrow;
    }
  }
  Widget WaitWidget(double size)
  {
    /*
    return Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.only(top: 20),
        child: CircularProgressIndicator(
          color: ColorConstants.greenColor,
          value: 0.8,
        )
    );

     */
   return Text("");
  }
  Widget buildSearchWidget()
  {
  return  new Container(
      height: 65.0,
      color: Colors.transparent,
      child: new Container(
          decoration: new BoxDecoration(
              color: ColorConstants.greenColor,
              borderRadius: new BorderRadius.only(
                bottomLeft: const Radius.circular(25.0),
                bottomRight: const Radius.circular(25.0),
              )
          ),
          child: new Center(
            child: Container(
              alignment: Alignment.topCenter,
              child: SearchWidget(),
              width: SizeConfig().screenWidth * 0.88,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
            ),
          )
      ),
    );

  }

  Widget buildGridProducts() {
    List<Product> data = [];

    return Container(
      height: height + 50,
      child: Container(
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) => ProductCard(
                  product: data[index],
                )),
      ),
    );
  }

  Widget buildPopularWidgetHeader(BuildContext context) {
    return Row(children: [
      Padding(
        padding:  EdgeInsets.only(left: CommonConstants.paddingleft, right:  CommonConstants.paddingright),
        child: Text(
          LocalString.getStringValue(context, 'products_popular') ??
              "المنتجات الرائجة",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: CommonConstants.smallText,
              color: ColorConstants.textColor,
              fontWeight: FontWeight.bold,
              fontFamily: CommonConstants.largeTextFont),
        ),
      ),
      Spacer(),
      GestureDetector(
        onTap: () {
         // Get.toNamed( Routes.allProducts);
          Get.to(ProductsScreen(categoryId: -1,categoryName: '',));
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8),
          child: Text(
            LocalString.getStringValue(context, 'view_all') ?? "مشاهدة الكل",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: CommonConstants.smallText,
                color: ColorConstants.textColor,
                fontWeight: FontWeight.bold,
                fontFamily: CommonConstants.largeTextFont),
          ),
        ),
      )
    ]);
  }

  Widget buildNewWidgetHeader(BuildContext context) {
    return Row(children: [
      Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8),
        child: Text(
          LocalString.getStringValue(context, 'products_new') ??
              "المنتجات الحديثة",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: CommonConstants.smallText,
              color: ColorConstants.textColor,
              fontWeight: FontWeight.bold,
              fontFamily: CommonConstants.largeTextFont),
        ),
      ),
      Spacer(),
      GestureDetector(
        onTap: () {
          Get.to(ProductsScreen(categoryId: -1,categoryName: '',));
        //  Get.toNamed(Routes.allProducts);
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8),
          child: Text(
            LocalString.getStringValue(context, 'view_all') ?? "مشاهدة الكل",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: CommonConstants.smallText,
                color: ColorConstants.textColor,
                fontWeight: FontWeight.bold,
                fontFamily: CommonConstants.largeTextFont),
          ),
        ),
      )
    ]);
  }

  Widget buildPopularWidgetBody(BuildContext context) {
    return (widget.controller!.popular!=null && widget.controller!.popular.value!=null)?
     Column(
       children: [
         buildPopularWidgetHeader(context),
         Container(
          height: CommonConstants.listViewHeight,
          child: Container(
            child: ListView.builder(
                padding: EdgeInsets.only(top: 4,bottom: 4),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: widget.controller!.popular.value!.data.length,
                itemBuilder: (BuildContext context, int index) => Padding(
                  padding: const EdgeInsets.only(left: 2,right:2),
                  child: ProductCard(
                    product: widget.controller!.popular.value!.data[index],
                  ),
                )),
          ),
    ),
       ],
     ):

    Column(
      children: [
        SizedBox(height: 10,),
        Container(
            height: CommonConstants.listViewHeight,
            child: SetMenuShimmer()),
      ],
    );
   // WaitWidget( SizeConfig().screenHeight * ColorConstants.sliderHeight);

  }
  Widget buildLatestWidgetBody(BuildContext context) {
    return (widget.controller!.latestProducts!=null && widget.controller!.latestProducts.value!=null)?
    Column(
      children: [
        buildNewWidgetHeader(context),
        Container(
          height: CommonConstants.listViewHeight,
          child: Container(
            child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 4,bottom: 4),
                scrollDirection: Axis.horizontal,
                itemCount: widget.controller!.latestProducts.value!.data.length,
                itemBuilder: (BuildContext context, int index) => Padding(
                  padding: const EdgeInsets.only(left: 2,right:2),
                  child: ProductCard(
                    product: widget.controller!.latestProducts.value!.data[index],
                  ),
                )),
          ),
        ),
      ],
    ):
    WaitWidget( SizeConfig().screenHeight * ColorConstants.sliderHeight);

  }

 Widget _buildSlider() {
   return (widget.controller!.banners!=null && widget.controller!.banners.value!=null && widget.controller!.banners.value!.data!=null)?
   (widget.controller!.banners.value!.data.length==0)?
       Text(""):
    Container(
       width: SizeConfig().screenWidth,
       height: ColorConstants.sliderHeight+30,
       child: CarouselWithIndicatorDemo(imgList:widget.controller!.banners.value!.data),
    ):
   Column(
     children: [
       Container(
           width: SizeConfig().screenWidth,
           height: ColorConstants.sliderHeight+30,
           child: BannerShimmer()
       ),
       SizedBox(height: 10,)
     ],
   );
   // WaitWidget( SizeConfig().screenHeight * ColorConstants.sliderHeight);
  }
  Widget buildCategories() {
    return (widget.controller!.categories!=null && widget.controller!.categories.value!=null)?
    Column(
      children: [
        Padding(
          padding:EdgeInsets.only(left: 8, right:  8),
          child: Align(
              alignment: AlignmentDirectional.topStart,
              child: Text(
                LocalString.getStringValue(context, 'categories') ?? "الفئات",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: CommonConstants.smallText,
                    color: ColorConstants.textColor,
                    fontFamily: CommonConstants.largeTextFont),
              )),
        ),
        Container(
          height:
          SizeConfig().screenWidth*ColorConstants.categoryWidth+50,
          child: CategoryPage(data: widget.controller!.categories.value!.data),
        ),
      ],
    ):
    CategoryShimmer();
   // WaitWidget( SizeConfig().screenHeight * ColorConstants.sliderHeight);
  }
}


