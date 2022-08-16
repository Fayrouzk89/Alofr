/*
import 'package:billing/modules/buy/buy_controller.dart';
import 'package:billing/modules/my_ads/my_ads_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';
import '../../shared/constants/colors.dart';
import '../../shared/constants/common.dart';
import '../../shared/services/LocalString.dart';
import '../../shared/services/storage_service.dart';
import '../../shared/utils/common_widget.dart';
import '../../shared/utils/size_config.dart';
import '../home/Cards/PackageCard.dart';
import '../solid_app_bar.dart';

class MyAdsScreen extends GetView<MyAdsController> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>true,
      child: Scaffold(
          backgroundColor: ColorConstants.whiteBack,
          appBar: SolidAppBar(title: LocalString.getStringValue(context, 'my_adds') ??
              "إعلاناتي",),
          body:
          Stack(
              children: <Widget>[
                Positioned(
                    top: 1,
                    left: 0,
                    right: 0,
                    child:  PackageHomePage(controller: controller,)

                  //_buildForms(context)
                ),
              ]
          )

      ),
    );
  }
}
class PackageHomePage extends StatefulWidget {
  MyAdsController controller;
  PackageHomePage({ Key? key,required this.controller }) : super(key: key);

  @override
  State<PackageHomePage> createState() => _PackageHomePageState();
}

class _PackageHomePageState extends State<PackageHomePage> {
  @override
  initState() {
    super.initState();

    // Add listeners to this class
  }
  @override
  Widget build(BuildContext context) {
    return _buildForms(context);
  }

  Widget _buildForms(BuildContext context) {
    return Form(
      key: widget.controller.FormKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0,right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Text(
                    LocalString.getStringValue(context, 'num_ads_published') ??
                        "عدد الإعلانات التي قد نشرتها",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: CommonConstants.normalText,
                        color: ColorConstants.textColor,
                        fontFamily: CommonConstants.largeTextFont),
                  )),
              Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Text(
                    LocalString.getStringValue(context, 'num_ads_remain') ??
                        "عدد الإعلانات المتبقية",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: CommonConstants.normalText,
                        color: ColorConstants.textColor,
                        fontFamily: CommonConstants.largeTextFont),
                  )),
              Text(
                '😓',
                style: TextStyle(fontSize:60),
                textAlign: TextAlign.center,
              ),
              Text(
                LocalString.getStringValue(context, 'donthavepackages') ??
                    "لا تملك حزم حالية",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: CommonConstants.normalText,
                    color: ColorConstants.textColor,
                    fontFamily: CommonConstants.largeTextFont),
              ),
              CommonWidget.rowHeight(height: 10),
              Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    LocalString.getStringValue(context, 'buy_bundles') ??
                        "شراء حزم",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: CommonConstants.normalText,
                        color: ColorConstants.textColor,
                        fontFamily: CommonConstants.largeTextFont),
                  )),
              CommonWidget.rowHeight(height: 20),
              Obx(
                    () =>buildListPackages(context),
              ),

              CommonWidget.rowHeight(height: 10),


            ],
          ),
        ),
      ),
    );
  }
  Widget buildBuyBundlesList(BuildContext context)
  {
    return Text('');
  }
  Widget buildListPackages(BuildContext context)
  {
    return (widget.controller!.packages!=null && widget.controller!.packages.value!=null)?
    Container(
      child: Container(
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: widget.controller!.packages.value!.data.length,
            itemBuilder: (BuildContext context, int index) => PackageCard(
              package: widget.controller!.packages.value!.data[index],
            )),
      ),
    ):
    WaitWidget( SizeConfig().screenHeight * ColorConstants.sliderHeight);
  }
  Widget WaitWidget(double size)
  {
    return Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.only(top: 20),
        child: CircularProgressIndicator(
          color: ColorConstants.greenColor,
          value: 0.8,
        )
    );
  }
}

 */
import 'package:billing/modules/Allproducts/products_controller.dart';
import 'package:billing/modules/buy/buy_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';
import '../../shared/constants/colors.dart';
import '../../shared/constants/common.dart';
import '../../shared/services/LocalString.dart';
import '../../shared/widgets/AppBars/build_header.dart';
import '../../shared/widgets/no_date.dart';
import '../home/Cards/product_card.dart';
import '../home/Cards/product_edit_card.dart';
import '../solid_app_bar.dart';
import '../../globals.dart' as globals;
import 'my_ads_controller.dart';

class MyAdsScreen extends StatefulWidget {
  const MyAdsScreen({Key? key}) : super(key: key);

  @override
  State<MyAdsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<MyAdsScreen> with RouteAware{
  final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();
  MyAdsController? homePageController = Get.put(MyAdsController(
      apiRepository: Get.find(), categoryId: globals.myProducts));

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      routeObserver.subscribe(this, ModalRoute.of(context)!);
    });
    super.initState();
  }
  @override
  void didPush() {
    print('SecondPage: Called didPush');
    if(!homePageController!.isLoading)
      {
        homePageController!.page=1;
        homePageController!.getProducts(1);
        setState(() {

        });
      }
    super.didPush();
  }

  @override
  void didPop() {
    print('SecondPage: Called didPop');
    super.didPop();
  }

  @override
  void didPopNext() {
    print('SecondPage: Called didPopNext');
    super.didPopNext();
  }

  @override
  void didPushNext() {
    print('SecondPage: Called didPushNext');
    super.didPushNext();
  }
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
        backgroundColor: ColorConstants.greyBack,
        body: Obx(() =>
            Container(child: home(orientation))
        ));
  }
  Future<void> _loadData() async {
    try {
      homePageController!.page=1;
     await  homePageController!.getProducts(1);


        setState(() {

        });
      }
     catch (err) {
      rethrow;
    }
  }
  Widget home(orientation) {
    return (homePageController!.products != null &&
            homePageController!.products.value != null)
        ? (homePageController!.products.value!.data.isEmpty)
            ? NoData(
                text: LocalString.getStringValue(context, 'no_products') ??
                    "لا يوجد إعلانات",
                imagePath: 'images/review.png',
              )
            : Container(
              child: Column(
                  children: [
                    RowDetails(
                        LocalString.getStringValue(
                                context, 'num_ads_published') ??
                            "عدد الإعلانات التي قد نشرتها",
                        homePageController!.products.value!.published_advs),
                    SizedBox(
                      height: 5,
                    ),
                    RowDetails(
                        LocalString.getStringValue(context, 'num_ads_remain') ??
                            "عدد الإعلانات المتبقية",
                        homePageController!.products.value!.rest_advs),
                    Expanded(
                      child: GetBuilder(
                        init: homePageController,
                        builder: (value) => GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisExtent: 150,
                              crossAxisCount: 1),
                          //  shrinkWrap: true,
                          // physics: NeverScrollableScrollPhysics(),
                          controller: homePageController!.controller,
                          itemCount:
                              homePageController!.products.value!.data.length,
                          itemBuilder: (context, index) {
                            return Padding(
                                padding: const EdgeInsets.only(left: 4, right: 4,bottom: 10),
                                child: ProductEditCard(
                                  product: homePageController!
                                      .products.value!.data[index],
                                  controller: homePageController,
                                ));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
            )
        : Text("");
  }

  Widget RowDetails(String header, int number) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8),
          child: Text(
            header,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: CommonConstants.normalText,
                color: ColorConstants.textColor,
                fontFamily: CommonConstants.largeTextFont),
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.black, width: 2.0, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Center(child: Text(number.toString() ?? "")),
            ))
      ],
    );
  }
}
