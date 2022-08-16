import 'package:billing/modules/category/categorys_controller.dart';
import 'package:billing/modules/home/Cards/notificationCard.dart';
import 'package:billing/modules/search/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';
import '../../shared/constants/colors.dart';
import '../../shared/constants/common.dart';
import '../../shared/services/LocalString.dart';
import '../../shared/widgets/AppBars/build_header.dart';
import '../../shared/widgets/AppBars/silver_custom.dart';
import '../../shared/widgets/no_date.dart';
import 'notifications_controller.dart';
class NotificationScreen extends StatefulWidget {

  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<NotificationScreen> {
  NotificationController? homePageController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homePageController = Get.put(NotificationController(apiRepository: Get.find()));
    homePageController!.getData(1);
  }
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      backgroundColor: ColorConstants.greyBack,
      body: CustomScrollView(
        slivers: [
          SilverAppBarCustom(  title: LocalString.getStringValue(context, 'notifications') ??
              "الإشعارات")
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
    return (homePageController!.data!=null && homePageController!.data.value!=null)?
    (homePageController!.data.value!.data.isEmpty)?
    NoData(  text: LocalString.getStringValue(context, 'no_notifications') ??
        "لا يوجد إشعارات", imagePath: 'images/review.png', ):
    Container(
      child: GetBuilder(
        init: homePageController,
        builder: (value) => GridView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: CommonConstants.listViewHeight-40,
              crossAxisCount: (orientation == Orientation.portrait) ? 1 : 2),
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 2),
          controller: homePageController!.controller,
          itemCount: homePageController!.data.value!.data.length,
          itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.only(left: 4,right: 4),
                child:  NotificationCard(data: homePageController!.data.value!.data[index],)
            );
          },
        ),
      ),
    ):Text("");
  }

}

