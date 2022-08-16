import 'dart:async';
import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:billing/dioApi/api.dart';
import 'package:billing/modules/home/home.dart';
import 'package:billing/modules/me/me_controller.dart';
import 'package:billing/modules/me/me_screen.dart';
import 'package:billing/shared/services/MessageHelper.dart';
import 'package:billing/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import '../../globals.dart' as globals;
import '../../routes/app_pages.dart';
import '../../shared/services/LocalString.dart';
import '../auth/auth_controller.dart';
import 'home_screen.dart';

class MultiDrawer extends StatefulWidget {
  var state;
  final int currentTabIndex;
  final MyHomePage myHomePage;
  HomeController controller;
  MultiDrawer(this.currentTabIndex,this.myHomePage,this.controller) : super();

  @override
  _PageState createState() {
    state = _PageState();
    return state;
  }
}

class _PageState extends State<MultiDrawer> {

  @override
  void initState() {
    super.initState();
  }


  Widget build(BuildContext context) {
    return CustomeDrawer(widget.currentTabIndex,widget.myHomePage,widget.controller);
  }
}

class CustomeDrawer extends StatefulWidget {
  final int currentTabIndex;
  final HomeController controller;
  final MyHomePage myHomePage;
  CustomeDrawer(this.currentTabIndex,this.myHomePage,this.controller) : super();

  @override
  State<CustomeDrawer> createState() => _CustomeDrawerState();

  static myFunction (BuildContext context) async {
    try {

      Navigator.pop(context);

    }catch(e){
      print(e);
    }
  }
}

class _CustomeDrawerState extends State<CustomeDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: Column(
          children: [
            Container(
              child: Container(
                color: ColorConstants.white,
                height:SizeConfig().screenHeight/3+20,
                width:SizeConfig().screenWidth,
                child: Container(
                   color: Colors.white,
                  child: DrawerHeader(

                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: <Color>[
                            ColorConstants.darkScaffoldBackgroundColor,
                            ColorConstants.darkScaffoldBackgroundColor
                          ])),
                      margin: EdgeInsets.only(bottom: 3),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom:2),
                        child: Container(
                          color: ColorConstants.greenColor,
                          child: Container(
                            alignment: Alignment.topCenter,
                            width: double.infinity,
                            child: Stack(
                              alignment: Alignment.topCenter,
                              children: [

                                Padding(
                                  padding: const EdgeInsets.only(top: 130.0),
                                  child: Container(
                                    height: 100,
                                    alignment: Alignment.center,// use aligment
                                    child: Image.asset(globals.getLogoImage(),
                                        //height: 200,
                                        width: 150,
                                        height: 150,
                                        fit: BoxFit.fitHeight),
                                  ),
                                ),
                                AvatarGlow(
                                  startDelay: Duration(milliseconds: 1000),
                                  glowColor: Colors.white,
                                  endRadius: 90,
                                  duration: Duration(milliseconds: 3000),
                                  repeat: true,
                                  showTwoGlows: true,
                                  repeatPauseDuration: Duration(milliseconds: 100),
                                  child: Material(
                                    elevation: 8.0,
                                    shape: CircleBorder(),
                                    color: Colors.transparent,
                                    child:  Material(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(55.0)),
                                      elevation: 10,
                                      child: ClipOval(
                                        child: SizedBox.fromSize(
                                          size: Size.fromRadius(50), // Image radius
                                          child: Padding(
                                            padding: EdgeInsets.all(0),
                                            child: Image.asset("images/logo.jpg",
                                                height: 90, width: 90,fit: BoxFit.cover,),
                                          ),
                                        ),

                                      ),
                                    ),
                                  ),
                                  shape: BoxShape.circle,
                                  animate: true,
                                  curve: Curves.fastOutSlowIn,
                                ),

                              ],
                            ),
                          ),
                        ),
                      )),
                ),
              ),
            ),
            Expanded(
              flex:6,
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  _createDrawerItem(icon: Icons.assignment_ind,text: LocalString.getStringValue(context, 'my_account') ??
                      "حسابي",operationId:globals.my_account_operation,context: context,controller: widget.controller),
                  _createDrawerItem(icon: Icons.account_balance_wallet,text: LocalString.getStringValue(context, 'buy_bundles') ??
                      "شراء حزم",operationId:globals.buy_operation,context: context,controller: widget.controller),
                  _createDrawerItem(icon: Icons.language ,text: LocalString.getStringValue(context, 'change_lang') ??
                      "تغيير اللغة",operationId:globals.lang_operation,context: context,controller: widget.controller),
                  Divider(color:ColorConstants.white),
                  _createDrawerItem(icon: Icons.contact_support ,text: LocalString.getStringValue(context, 'who_we') ??
                      "من نحن",operationId:globals.about_operation,context: context,controller: widget.controller),
                  _createDrawerItem(icon: Icons.turned_in_outlined ,text: LocalString.getStringValue(context, 'terms_condition') ??
                      "الشروط والأحكام",operationId:globals.term_operation,context: context,controller: widget.controller),
                  _createDrawerItem(icon: Icons.privacy_tip ,text: LocalString.getStringValue(context, 'privacy') ??
                      "سياسة الخصوصية",operationId:globals.privacy_operation,context: context,controller: widget.controller),
                  Divider(color:ColorConstants.white),
                  _createDrawerItem(icon: Icons.logout,text: LocalString.getStringValue(context, 'log_out') ??
                      "تسجيل الخروج",operationId:globals.exit_operation,context: context,controller: widget.controller),
                  _createDrawerItem(icon: Icons.power_settings_new,text: LocalString.getStringValue(context, 'close_app') ??
                      " اغلاق البرنامج",operationId:globals.close_app_operation,context: context,controller: widget.controller),
                ],
              ),
            )
          ]
      ),
    );
  }

  Widget _createDrawerItem(
      {IconData? icon, String? text, GestureTapCallback? onTap,int? operationId,BuildContext? context,HomeController? controller}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0,right: 8),
            child: Text(text??""),
          )
        ],
      ),
      onTap:() =>doAction(operationId,context,controller!),
    );
  }

  void doAction(int? op,BuildContext? context,HomeController controller)
  {
    int choice=op??0;

    if (choice == globals.my_account_operation) {
      if(!MessageHelper.isLoggedIn())
        {
          MessageHelper.goToLogin(context!);
        }
      else {
       // widget.myHomePage!.onTapIndex(widget.controller, 0);
        Navigator.of(context!).pop();
        MeController controller= MeController(apiRepository:Get.find() );
        Navigator.push(context,MaterialPageRoute(builder: (context) =>  MeScreen(controller: controller)));
       // Get.toNamed(Routes.MyAccount, arguments: controller);
       // Get.toNamed(Routes.MyAccount);
      }
    }
    else if (choice == globals.buy_operation) {
      if(!MessageHelper.isLoggedIn())
      {
        MessageHelper.goToLogin(context!);
      }
      else {
        // widget.myHomePage!.onTapIndex(widget.controller, 0);
        Navigator.of(context!).pop();
        Get.toNamed(Routes.buy);
      }

      //Navigator.of(context).pop();
    }
    else if (choice == globals.lang_operation) {
      Get.toNamed(Routes.Lang);
    }
    else if (choice == globals.about_operation) {
      Navigator.of(context!).pop();
      Get.toNamed(Routes.staticPages);
    }
    else if (choice == globals.term_operation) {
      Navigator.of(context!).pop();
      Get.toNamed( Routes.Terms);
    }
    else if (choice == globals.privacy_operation) {

      Navigator.of(context!).pop();
      Get.toNamed( Routes.Privacy);
    }
    else if (choice ==globals.exit_operation) {
      logout(context!,controller);
    //  Navigator.of(context!).pop();
    }
    else if (choice ==globals.close_app_operation) {
      Navigator.of(context!).pop();
      if (Platform.isAndroid) {
        SystemNavigator.pop();
      } else if (Platform.isIOS) {
        exit(0);
      }
    }
  }
  void logout(BuildContext context,HomeController controller)async
  {
    Api.setLoading("Please wait");
    bool? res = await controller.logout();
    //controller.switchTab(0);
    if(res!=null && res) {
      StorageService. ResetInfo();
      Api.hideLoading();
      AuthController controller= AuthController(apiRepository:Get.find() );
      //  Navigator.push(context,MaterialPageRoute(builder: (context) =>  AuthScreen()));
      Get.toNamed(Routes.LOGIN, arguments: controller);
  //    MessageHelper.goToLogin(context!);


    }
    else
      {
        Api.hideLoading();
        MessageHelper.goToLogin(context!);
      }
  }
}




