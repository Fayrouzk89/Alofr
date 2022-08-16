import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:billing/modules/StatisticPage/statistic_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lala_share/flutter_lala_share.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../shared/constants/colors.dart';
import '../../shared/constants/common.dart';
import '../../shared/services/LocalString.dart';
import '../../shared/utils/size_config.dart';
import '../../shared/widgets/AppBars/statistic_appBar.dart';
import '../../shared/widgets/SharedWidget/LogoAppBar.dart';
import '../home/Cards/payment_card.dart';
import 'package:flutter_html/flutter_html.dart';
class AboutScreen extends GetView<StatController> {
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
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              new LogoAppBar(),
              Obx(
                    () =>
                    (widget.controller!.data!=null && widget.controller!.data.value!=null) ?
                        Column(
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
                                  Expanded(
                                    child:
                                    (widget.controller.data !=null &&  widget.controller.data!.value !=null)?
                                    Center(child: Html(data:widget.controller.data!.value!.data!.aboutApp.toString())):
                                    Text(''),
                                  ),
                                  /*
                                  Expanded(
                                    child: Text(
                                      (widget.controller.data !=null &&  widget.controller.data!.value !=null)?
                                      widget.controller.data!.value!.data!.aboutApp.toString()
                                          :
                                      "حول"
                                      ,
                                      maxLines: 7,
                                      style: new TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),

                                   */
                                ]),
                          ),
                        ),
                        new Padding(
                          padding: new EdgeInsets.only(top: _height / 30,left: 8, right: 8),
                          child: new Column(
                            children: <Widget>[
                              (widget.controller.data !=null &&  widget.controller.data!.value !=null)?
                              (Platform.isAndroid)?
                              infoShareApp(
                                  _width,
                                  Icons.share,
                                  LocalString.getStringValue(context, 'share') ??
                                      "مشاركة",
                                  context,
                                  widget.controller.data!.value!.data!.android_link.toString()):
                              infoShareApp(
                                  _width,
                                  Icons.share,
                                  LocalString.getStringValue(context, 'share') ??
                                      "مشاركة",
                                  context,
                                  widget.controller.data!.value!.data!.ios_link.toString())
                                  :Text(''),
                              new SizedBox(
                                height: 10,
                              ),
                              infoCallEmail(_width, FontAwesomeIcons.mailBulk,
                                  (widget.controller.data !=null &&  widget.controller.data!.value !=null)?
                                  widget.controller.data!.value!.data!.email.toString()
                                      :
                                  ''),
                              new SizedBox(
                                height: 10,
                              ),
                              (widget.controller.data !=null &&  widget.controller.data!.value !=null)?
                              infoCallChild(_width, FontAwesomeIcons.phone,
                                  widget.controller.data!.value!.data!.mobile.toString(), _phone):Text(''),
                              /*
                              new SizedBox(
                                height: 10,
                              ),
                              infoCallYoutube(
                                  _width,
                                  FontAwesomeIcons.youtube,
                                  LocalString.getStringValue(context, 'youTube') ??
                                      "يوتيوب",
                                  'https://www.youtube.com/watch?v=Wvb9uyD7KBk'),
                              new SizedBox(
                                height: 10,
                              ),
                              infoCallYoutube(
                                  _width,
                                  FontAwesomeIcons.facebook,
                                  LocalString.getStringValue(context, 'FaceBook') ??
                                      "فايس بوك",
                                  'https://www.facebook.com//sitech.sy'),
                              new SizedBox(
                                height: 10,
                              ),
                              infoCallYoutube(
                                  _width,
                                  FontAwesomeIcons.telegram,
                                  LocalString.getStringValue(context, 'Telegram') ??
                                      "تلغرام",
                                  'https://t.me/phenixsys'),
                              new SizedBox(
                                height: 10,
                              ),
                              infoCallYoutube(
                                  _width,
                                  FontAwesomeIcons.link,
                                  'www.phenixsoft.com',
                                  'http://www.phenixsoft.com')

                               */
                            ],
                          ),
                        )
                      ],
                    ):
                        Text('')
              ),


            ],
          ),
        ),
      ),
    );
  }
  Widget headerChild(String header, int value) => new Expanded(
      child: new Column(
        children: <Widget>[
          new Text(header),
          new SizedBox(
            height: 8.0,
          ),
          new Text(
            '$value',
            style: new TextStyle(
                fontSize: 14.0,
                color: const Color(0xFFB9B7E7),
                fontWeight: FontWeight.bold),
          )
        ],
      ));

  Widget infoChild(double width, IconData icon, data) => new Padding(
    padding: new EdgeInsets.only(bottom: 8.0),
    child: new InkWell(
      child: new Row(
        children: <Widget>[
          new SizedBox(
            width: width / 10,
          ),
          new Icon(
            icon,
            color: ColorConstants.greenColor,
            size: 25.0,
          ),
          new SizedBox(
            width: width / 20,
          ),
          new Text(data)
        ],
      ),
      onTap: () {
        print('Info Object selected');
      },
    ),
  );

  Widget infoCallChild(
      double width, IconData icon, data, _phone) =>
      new Padding(
        padding: new EdgeInsets.only(bottom: 8.0),
        child: new InkWell(
          child: new Row(
            children: <Widget>[
              new Icon(
                icon,
                color: ColorConstants.greenColor,
                size: 25.0,
              ),
              new SizedBox(
                width: width / 20,
              ),
              new Text(data)
            ],
          ),
          onTap: () {
            // print('Info Object selected');
            _makePhoneCall('tel:$_phone');
          },
        ),
      );

  Widget infoCallYoutube(double width, IconData icon, data,
      toLaunch) =>
      new Padding(
        padding: new EdgeInsets.only(bottom: 8.0),
        child: new InkWell(
          child: new Row(
            children: <Widget>[

              new Icon(
                icon,
                color: ColorConstants.greenColor,
                size: 25.0,
              ),
              new SizedBox(
                width: width / 20,
              ),
              new Text(data)
            ],
          ),
          onTap: () {
            // print('Info Object selected');
            _launchUniversalLinkIos(toLaunch);
          },
        ),
      );

  Future<void> _launchUniversalLinkIos(String url) async {
    if (await canLaunch(url)) {
      final bool nativeAppLaunchSucceeded = await launch(
        url,
        forceSafariVC: false,
        universalLinksOnly: true,
      );
      if (!nativeAppLaunchSucceeded) {
        await launch(
          url,
          forceSafariVC: true,
        );
      }
    }
  }

  Widget infoCallEmail(
      double width,
      IconData icon,
      data,
      ) =>
      new Padding(
        padding: new EdgeInsets.only(bottom: 8.0),
        child: new InkWell(
          child: new Row(
            children: <Widget>[
              new Icon(
                icon,
                color: ColorConstants.greenColor,
                size: 25.0,
              ),
              new SizedBox(
                width: width / 20,
              ),
              new Text(data)
            ],
          ),
          onTap: () {
            // print('Info Object selected');
            _createEmail();
          },
        ),
      );

  void _createEmail() async {
    const emailaddress = 'mailto:info@almzar3q8@gmail.com?subject=&body=';

    if (await canLaunch(emailaddress)) {
      await launch(emailaddress);
    } else {
      throw 'Could not Email';
    }
  }
  Widget infoShareApp(double width, IconData icon, data,
      BuildContext con, toLaunch) =>
      new Padding(
        padding: new EdgeInsets.only(bottom: 8.0),
        child: new InkWell(
          child: new Row(
            children: <Widget>[

              new Icon(
                icon,
                color: ColorConstants.greenColor,
                size: 25.0,
              ),
              new SizedBox(
                width: width / 20,
              ),
              new Text(data)
            ],
          ),
          onTap: () {
            // print('Info Object selected');
            shareApp(con,toLaunch);
          },
        ),
      );
  void shareApp(BuildContext context,String link)async
  {
    bool success = await FlutterLalaShare.share(
        emailSubject:LocalString.getStringValue(context, 'app_name') ??
            "وفرتك",
        urlToShare: link
    );
  }
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}