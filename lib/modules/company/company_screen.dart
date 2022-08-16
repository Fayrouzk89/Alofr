import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';
import '../../shared/constants/colors.dart';
import '../../shared/constants/common.dart';
import '../../shared/services/LocalString.dart';
import '../../shared/utils/size_config.dart';
import '../../shared/widgets/AppBars/silver_custom.dart';
import '../../shared/widgets/no_date.dart';
import '../home/Cards/company_card.dart';
import '../home/Cards/product_card.dart';
import '../home/Shimmer/BannerShimmer.dart';
import '../home/tabs/slider_adver.dart';
import '../solid_app_bar.dart';
import '../../globals.dart' as globals;
import 'company_controller.dart';
import '../../globals.dart' as globals;
class CompanyScreen extends StatefulWidget {

  const CompanyScreen({Key? key}) : super(key: key);
  @override
  State<CompanyScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<CompanyScreen> {
  CompanyController? homePageController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homePageController = Get.put(CompanyController(apiRepository: Get.find() ));
  }
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      backgroundColor: ColorConstants.greyBack,
      body: CustomScrollView(
        slivers: [
          SilverAppBarCustom(  title: LocalString.getStringValue(context, 'companies') ??
              "الشركات")
          ,
          SliverFillRemaining(
              hasScrollBody: true,
              child:
          Obx(
          () => Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildSlider(),

                Expanded(child: home(orientation))
                ,
                SizedBox(height: 5,)
              ],
            ),
          )
          )




          )
        ],
      ),
    );
    return Scaffold(
        backgroundColor: ColorConstants.greyBack,
        appBar: SolidAppBar(title:
        LocalString.getStringValue(context, 'companies') ??
            "الشركات"
          ,),
        body:
        Obx(
                () =>home(orientation)
        )

    );

  }
  Widget _buildSlider() {
    if(homePageController!.banners==null || homePageController!.banners!.value==null)
      {
        return Text("");
      }
    else
    return
    Container(
      width: SizeConfig().screenWidth,
      height: ColorConstants.sliderHeight+30,
      child: CarouselWithIndicatorDemo(imgList:homePageController!.banners!.value!.data),
    );
    // WaitWidget( SizeConfig().screenHeight * ColorConstants.sliderHeight);
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
         // physics: AlwaysScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: CommonConstants.listViewHeight-40,
              crossAxisCount: (orientation == Orientation.portrait) ? 1 : 2),
          shrinkWrap: true,
          controller: homePageController!.controller,
          itemCount: homePageController!.products.value!.data.length,
          itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.only(left: 4,right: 4),
                child:  CompanyCard(data: homePageController!.products.value!.data[index],)
            );
          },
        ),
      ),
    ):Text("");
  }
}
