import 'package:billing/modules/category/categorys_controller.dart';
import 'package:billing/modules/search/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';
import '../../shared/constants/colors.dart';
import '../../shared/constants/common.dart';
import '../../shared/services/LocalString.dart';
import '../../shared/widgets/AppBars/build_header.dart';
import '../../shared/widgets/AppBars/search_app_bar.dart';
import '../../shared/widgets/no_date.dart';
import '../home/Cards/product_card.dart';
import '../home/Cards/search_card.dart';

class SearchScreen extends StatefulWidget {
  final String Name;

  const SearchScreen({Key? key, required this.Name}) : super(key: key);

  @override
  State<SearchScreen> createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  SearchController? homePageController;
  TextEditingController? _editingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _editingController = TextEditingController();
    _editingController!.text = widget.Name;
    setState(() {});
    homePageController =
        Get.put(SearchController(widget.Name, apiRepository: Get.find()));
    // homePageController!.getCategories(widget.mainCategoryId);
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      backgroundColor: ColorConstants.greyBack,
      body: CustomScrollView(
        slivers: [
          SearchAppBarCustom(
            title: widget.Name,
            editingController: _editingController,
            searchScreenState: this,
            controller: homePageController,
          ),
          SliverFillRemaining(
              hasScrollBody: true, child: Obx(() => home(orientation)))
        ],
      ),
    );
  }

  callOpenSearch() {
    if (!_editingController!.text.trim().isEmpty) {}
  }

  Widget home(orientation) {
    return SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      buildLastSearches(),
                      buildLastSeen(),
                      (homePageController!.products != null &&
                          homePageController!.products.value != null)
                          ? (homePageController!.products.value!.data.isEmpty)
                          ? NoData(
                        text: LocalString.getStringValue(context, 'no_products') ??
                            "لا يوجد إعلانات",
                        imagePath: 'images/review.png',
                         )
                          :
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 8, right: 8),
                            child: Align(
                                alignment: AlignmentDirectional.topStart,
                                child: Text(
                                  LocalString.getStringValue(context, 'search_result') ??
                                      "نتائج البحث",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: CommonConstants.normalText,
                                      color: ColorConstants.textColor,
                                      fontFamily: CommonConstants.largeTextFont),
                                )),
                          ),
                          GetBuilder(
                            init: homePageController,
                            builder: (value) => GridView.builder(
                              padding: EdgeInsets.all(0),
                              physics: const NeverScrollableScrollPhysics(), //<--here
                              shrinkWrap: true,
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 1.0,
                                  crossAxisSpacing: 1,
                                  mainAxisExtent:
                                  CommonConstants.listViewHeight-10,
                                  crossAxisCount:
                                  (orientation == Orientation.portrait)
                                      ? 2
                                      : 3),
                              controller: homePageController!.controller,
                              itemCount:
                              homePageController!.products.value!.data.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                    padding:
                                    const EdgeInsets.only(left: 4, right: 4),
                                    child: ProductCard(
                                      product: homePageController!
                                          .products.value!.data[index],
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
                        ],
                      ):Text('')

                    ],
                  ),
                ),
              );

  }

  Widget buildLastSearches() {
    return (homePageController!.latestProducts != null &&
            homePageController!.latestProducts.value != null)
        ? Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      LocalString.getStringValue(context, 'last_searches') ??
                          "آخر البحوث",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: CommonConstants.normalText,
                          color: ColorConstants.textColor,
                          fontFamily: CommonConstants.largeTextFont),
                    )),
              ),
              Container(
                child: Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(0),
                      itemCount:
                          homePageController!.latestProducts.value!.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return SearchCard(
                          product: homePageController!
                              .latestProducts.value!.data[index],
                        );
                      }),
                ),
              ),
            ],
          )
        : Text('');
  }

  Widget buildLastSeen() {
    return (homePageController!.popular != null &&
            homePageController!.popular.value != null)
        ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        LocalString.getStringValue(context, 'last_ads_seen') ??
                            "آخر الإعلانات مشاهدة",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: CommonConstants.normalText,
                            color: ColorConstants.textColor,
                            fontFamily: CommonConstants.largeTextFont),
                      ))),
              Container(
                height: CommonConstants.listViewHeight,
                child: Container(
                  child: ListView.builder(
                      padding: EdgeInsets.all(0),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: homePageController!.popular.value!.data.length,
                      itemBuilder: (BuildContext context, int index) =>
                          ProductCard(
                            product:
                                homePageController!.popular.value!.data[index],
                          )),
                ),
              ),
            ],
          )
        : Text('');
  }
/*
  Widget home(orientation )
  {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Padding(
              padding:EdgeInsets.only(left: 8, right:  8),
              child: Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Text(
                    LocalString.getStringValue(context, 'last_searches') ?? "آخر البحوث",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: CommonConstants.normalText,
                        color: ColorConstants.textColor,
                        fontFamily: CommonConstants.largeTextFont),
                  )),
            ),
            Padding(
              padding:EdgeInsets.only(left: 8, right:  8),
              child: Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Text(
                    LocalString.getStringValue(context, 'last_ads_seen') ?? "آخر الإعلانات مشاهدة",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: CommonConstants.normalText,
                        color: ColorConstants.textColor,
                        fontFamily: CommonConstants.largeTextFont),
                  )),
            ),
            Padding(
              padding:EdgeInsets.only(left: 8, right:  8),
              child: Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Text(
                    LocalString.getStringValue(context, 'suggested') ?? "مقترحة",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: CommonConstants.normalText,
                        color: ColorConstants.textColor,
                        fontFamily: CommonConstants.largeTextFont),
                  )),
            ),
          ],
        ),
      ),
    );

  }


   */
}
