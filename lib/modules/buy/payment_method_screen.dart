import 'package:billing/modules/buy/buy_controller.dart';
import 'package:billing/shared/widgets/AppBars/titled_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';
import '../../shared/constants/colors.dart';
import '../../shared/constants/common.dart';
import '../../shared/services/LocalString.dart';
import '../../shared/services/storage_service.dart';
import '../../shared/utils/common_widget.dart';
import '../../shared/utils/size_config.dart';
import '../../shared/widgets/custom_rounded.dart';
import '../../shared/widgets/AppBars/main_app_bar.dart';
import '../../globals.dart' as globals;
import '../../shared/widgets/input_field_phone.dart';
import '../../shared/widgets/input_password.dart';
import '../home/Cards/PackageCard.dart';
import '../home/Cards/payment_card.dart';
import '../home/Cards/user_package_card.dart';
import '../solid_app_bar.dart';

class PaymentScreen extends StatefulWidget {
  final BuyController? controller;
  final bool? isBuyAds;
   PaymentScreen({Key? key,required this.controller,required this.isBuyAds}) : super(key: key);

  @override
  _PackageHomePageState createState() {
    return _PackageHomePageState();
  }

}

class _PackageHomePageState extends State<PaymentScreen> {
  @override
  initState() {
    super.initState();
    // widget.controller!.getData();
    // Add listeners to this class
  }

  @override
  Widget build(BuildContext context) {
    return _buildForms(context);
  }

  Widget _buildForms(BuildContext context) {
  return  WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
          backgroundColor: ColorConstants.greyBack,
          appBar: TitledAppBar(
              LocalString.getStringValue(context, 'payemnt_method') ?? "طريقة الدفع"),
          body:  SingleChildScrollView(
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
                        LocalString.getStringValue(context, 'choose_payment_method') ??
                            "اختر طريقة الدفع",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: CommonConstants.normalText,
                            color: ColorConstants.textColor,
                            fontFamily: CommonConstants.largeTextFont),
                      )),
                  Obx(
                        () => buildListPackages(context),
                  ),
                  CommonWidget.rowHeight(height: 10),
                ],
              ),
            ),
          ),

      )
    );

  }
  Widget buildListPackages(BuildContext context) {
    return (widget.controller!.data!=null && widget.controller!.data.value!=null)
        ? Container(
      child: Container(
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            itemCount: widget.controller!.data.value!.data!.paymentMethods!.length,
            itemBuilder: (BuildContext context, int index) => CreditCardsPage(widget.controller!.data.value!.data!.paymentMethods![index],widget.controller,widget.isBuyAds)
        ),
      ),
    )
        : WaitWidget(SizeConfig().screenHeight * ColorConstants.sliderHeight);
  }

  Widget WaitWidget(double size) {
    return Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.only(top: 20),
        child: CircularProgressIndicator(
          color: ColorConstants.greenColor,
          value: 0.8,
        ));
  }
}
