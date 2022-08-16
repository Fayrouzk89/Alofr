import 'package:billing/modules/buy/buy_controller.dart';
import 'package:billing/modules/buy/payment_method_screen.dart';
import 'package:billing/shared/widgets/AppBars/titled_app_bar.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';
import '../../shared/constants/colors.dart';
import '../../shared/constants/common.dart';
import '../../shared/services/LocalString.dart';
import '../../shared/services/MessageHelper.dart';
import '../../shared/services/storage_service.dart';
import '../../shared/utils/common_widget.dart';
import '../../shared/utils/size_config.dart';
import '../../shared/widgets/custom_rounded.dart';
import '../../shared/widgets/AppBars/main_app_bar.dart';
import '../../globals.dart' as globals;
import '../../shared/widgets/input_field_phone.dart';
import '../../shared/widgets/input_password.dart';
import '../home/Cards/PackageCard.dart';
import '../home/Cards/user_package_card.dart';
import '../solid_app_bar.dart';

class BuyScreen extends GetView<BuyController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
          backgroundColor: ColorConstants.greyBack,
          appBar: TitledAppBar(
              LocalString.getStringValue(context, 'packages') ?? "الباقات"),
          body: PackageHomePage(
            controller: controller,
          )),
    );
  }
}

class PackageHomePage extends StatefulWidget {
  BuyController controller;

  PackageHomePage({Key? key, required this.controller}) : super(key: key);

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
          padding: const EdgeInsets.only(left: 10.0, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 5,
              ),
              Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    LocalString.getStringValue(context, 'current_bundles') ??
                        "حزمك الحالية",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: CommonConstants.normalText,
                        color: ColorConstants.textColor,
                        fontFamily: CommonConstants.largeTextFont),
                  )),
              Obx(
                () => buildMyPackages(context),
              ),
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
                () => buildListPackages(context),
              ),
              CommonWidget.rowHeight(height: 10),
              buildBuyAds(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget DontHavePackage(BuildContext context) {
    return Column(
      children: [
        Text(
          '😓',
          style: TextStyle(fontSize: 60),
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
      ],
    );
  }

  Widget buildMyPackages(BuildContext context) {
    return (widget.controller!.mypackages != null &&
            widget.controller!.mypackages.value != null)
        ? Container(
            child: ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) =>
                    UserPackageCard(
                      package: widget.controller!.mypackages.value!,
                    )),
          )
        :
         (widget.controller!.mypackages == null)?
         Text(''):
        DontHavePackage(context)
            ;
  }

  Widget buildBuyAds(BuildContext context) {
    return Card(
        elevation: 5,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                padding:
                    EdgeInsets.only(left: 1, right: 1, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(
                          (LocalString.getStringValue(context, 'buy_ads') ??
                              "شراء إعلانات"),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color(0xFF444444),
                              fontFamily: CommonConstants.largeTextFont,
                              fontSize: CommonConstants.meduimText,
                              fontWeight: FontWeight.w400)),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _decrementButton(),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${numberOfItems}',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    _incrementButton(),
                  ],
                ),
              ),
              // Divider(color: ColorConstants.greenColor,thickness:2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 30,
                        child: Text("",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Color(0xFF444444),
                                fontFamily: CommonConstants.largeTextFont,
                                fontSize: CommonConstants.meduimText,
                                fontWeight: FontWeight.w400)),
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        padding: EdgeInsets.only(left: 1, right: 1, top: 1),
                        child: InkWell(
                          onTap: () {
                            print('Click Profile Pic');
                          },
                          child: Container(
                              alignment: Alignment.center,
                              child: CustomRounded(
                                text: LocalString.getStringValue(
                                        context, 'buy_ad_now') ??
                                    "شراء إعلان",
                                textSize: CommonConstants.textButton,
                                textColor: Colors.white,
                                color: ColorConstants.greenColor,
                                size: Size(SizeConfig().screenWidth * 0.4,
                                    CommonConstants.roundedHeightSmall),
                                pressed: () {
                                  if(numberOfItems>0)
                                  {
                                    widget.controller.numberAds=numberOfItems;
                                    Get.to(PaymentScreen(controller:  widget.controller,isBuyAds: true,));
                                  }
                                  else
                                  {
                                    MessageHelper.showMessage(context,LocalString.getStringValue(
                                        context, 'you_must_select_number_ads') ??
                                        'يجب تحديد عدد الإعلانات');
                                  }
                                },
                              )),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    children: [
                      Container(
                        height: 30,
                        child: Text(
                            (LocalString.getStringValue(
                                    context, 'total_price') ??
                                "السعر الإجمالي"),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Color(0xFF444444),
                                fontFamily: CommonConstants.largeTextFont,
                                fontSize: CommonConstants.meduimText,
                                fontWeight: FontWeight.w400)),
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        padding: EdgeInsets.only(left: 1, right: 1, top: 1),
                        child: InkWell(
                          onTap: () {
                            print('Click Profile Pic');
                          },
                          child: Container(
                              alignment: Alignment.center,
                              child: CustomRounded(
                                text: total.toString(),
                                textSize: CommonConstants.textButton,
                                textColor: ColorConstants.greenColor,
                                color: Colors.white,
                                size: Size(SizeConfig().screenWidth * 0.4,
                                    CommonConstants.roundedHeightSmall),
                                pressed: () {

                                  // loadAssets();
                                },
                              )),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }

  Widget buildBuyBundlesList(BuildContext context) {
    return Text('');
  }

  Widget _incrementButton() {
    return FloatingActionButton(
      child: Icon(Icons.add, color: Colors.black87),
      backgroundColor: Colors.white,
      onPressed: () {
        setState(() {
          if (numberOfItems + 1 > globals.maxAds) {
          } else {
            numberOfItems++;
            total = globals.priceAdd * numberOfItems;
          }
        });
      },
    );
  }

  Widget _decrementButton() {
    return FloatingActionButton(
        onPressed: () {
          setState(() {
            if (numberOfItems - 1 < 0) {
            } else {
              numberOfItems--;
              total = globals.priceAdd * numberOfItems;
            }
          });
        },
        child: new Icon(Icons.remove, color: Colors.black),
        backgroundColor: Colors.white);
  }

  int numberOfItems = 0;
  int total = 0;

  Widget buildListPackages(BuildContext context) {
    return (widget.controller!.packages != null &&
            widget.controller!.packages.value != null)
        ? Container(
            child: Container(
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: ClampingScrollPhysics(),
                  itemCount: widget.controller!.packages.value!.data.length,
                  itemBuilder: (BuildContext context, int index) => PackageCard(
                        package: widget.controller!.packages.value!.data[index],controller: widget.controller,
                      )),
            ),
          )
        : WaitWidget(SizeConfig().screenHeight * ColorConstants.sliderHeight);
  }

  Widget WaitWidget(double size) {
    return Text('');
  }
}
