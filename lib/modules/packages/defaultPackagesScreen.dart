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
import 'DefaultPackageController.dart';

class DefaultPackagesScreen extends GetView<DefaultPackageController> {
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
  DefaultPackageController controller;

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

              Obx(
                    () => buildListPackages(context),
              ),
              CommonWidget.rowHeight(height: 10),

            ],
          ),
        ),
      ),
    );
  }



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
              package: widget.controller!.packages.value!.data[index],controller: null,
            )),
      ),
    )
        : WaitWidget(SizeConfig().screenHeight * ColorConstants.sliderHeight);
  }
  Widget WaitWidget(double size) {
    return Text('');
  }
}
