import 'package:avatar_glow/avatar_glow.dart';
import 'package:billing/modules/StatisticPage/statistic_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_lala_share/flutter_lala_share.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../shared/constants/colors.dart';
import '../../shared/services/LocalString.dart';
import '../../shared/utils/size_config.dart';
import '../../shared/widgets/AppBars/statistic_appBar.dart';
import '../../shared/widgets/SharedWidget/LogoAppBar.dart';

class TermsConditionScreen extends GetView<StatController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
          backgroundColor: ColorConstants.greyBack,
          appBar: StatisticAppBar(title:  LocalString.getStringValue(context, 'who_we') ??
              "من نحن"),
          body: PackageHomePage(
            controller: controller,
          )),
    );
  }
}

class PackageHomePage extends StatefulWidget {
  StatController controller;

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
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    String _phone = '+4915750382367';
    return Form(
      key: widget.controller.FormKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left:0, right: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              new LogoAppBar(),
              Obx(
                      () =>Column(
                    children: <Widget>[
                      new Container(
                        decoration:
                        new BoxDecoration(color: Colors.white, boxShadow: [
                          new BoxShadow(
                              color: Colors.black45,
                              blurRadius: 2.0,
                              offset: new Offset(0.0, 2.0))
                        ]),
                        child: new Padding(
                          padding: new EdgeInsets.all(_width / 20),
                          child: new Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                (widget.controller.data !=null &&  widget.controller.data!.value !=null)?
                                Center(child: Html(data:widget.controller.data!.value!.data!.appTerms.toString())):
                                Text(''),
                              ]),
                        ),
                      ),
                      new Padding(
                        padding: new EdgeInsets.only(top: _height / 30,left: 8, right: 8),
                        child: new Column(
                          children: <Widget>[

                          ],
                        ),
                      )
                    ],
                  )
              ),


            ],
          ),
        ),
      ),
    );
  }




}