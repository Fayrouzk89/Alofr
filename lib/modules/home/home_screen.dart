import 'dart:math';

import 'package:billing/modules/home/drawer.dart';
import 'package:billing/modules/home/home.dart';
import 'package:billing/modules/home/tabs/new_adds.dart';
import 'package:billing/shared/shared.dart';
import 'package:billing/shared/widgets/AppBars/titled_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import '../../shared/constants/colors.dart';
import '../../shared/services/LocalString.dart';
import '../../shared/services/MessageHelper.dart';
import '../../shared/widgets/AppBars/build_header.dart';
import '../../shared/widgets/DialogExit.dart';
import 'home_controller.dart';
import 'tabs/tabs.dart';
import '../../globals.dart' as globals;
class HomeScreen extends GetView<HomeController>  {
  BuildContext? mcontext;
  @override
  Widget build(BuildContext context) {
    mcontext=context;
    return  MyHomePage(controller);
    /*
    return WillPopScope(
      onWillPop: _onBackPress,
      //child: Obx(() => _buildWidget(context)),
      child:  MyHomePage(controller),
    );

     */
  }

}



class MyHomePage extends StatefulWidget {
  final HomeController controller;
  MyHomePage(this.controller):super();

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  @override
  initState() {
    super.initState();
   widget.controller.scaffoldKey= new GlobalKey<ScaffoldState>();
    // Add listeners to this class
  }
  Future<bool> _onBackPress() async {
    bool goBack = false;
    if(widget.controller.currentTab!= MainTabs.home)
    {
      widget.controller.switchTab(0);
      setState(() {

      });
    }
    else {
      await showDialog(
        context: context!,
        builder: (BuildContext context) {
          return DialogExit(context);
        },
      );
    }
    return goBack;
  }
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: _onBackPress,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: widget.controller.scaffoldKey,
        endDrawer:new MultiDrawer( widget.controller.currentTab.value.index,widget,widget.controller),
        backgroundColor: ColorConstants.greyBack,
        body: CustomScrollView(

          slivers: [
            (widget.controller.currentTab ==  MainTabs.newAdds ||widget.controller.currentTab ==  MainTabs.resource)?
           SliverAppBar(
          pinned: true,
          floating: false,
          expandedHeight: globals.silver_expanded_height,
          toolbarHeight:  globals.silver_tool_height,
          titleSpacing: 0,
          actions: <Widget>[
            IconButton(
              icon:  Image.asset('images/back.png'),
              onPressed: () {
               widget.controller.switchTab(0);
               setState(() {

               });
              },
            ),
          ],
          title: Padding(
              padding:  EdgeInsets.only(top:globals.imagePaddingTop),
              child: Container(
                //s alignment: Alignment.center,// use aligment
                child: Image.asset(globals.getLogoImage(),
                  height:globals.imageHeightAppBar,
                  width: globals.imageWidthAppBar,
                  fit: BoxFit.fitWidth,),
              )
          ),
          bottom:  PreferredSize(
            preferredSize:  Size.fromHeight(kToolbarHeight ),
            child: Container(
              color: ColorConstants.greyBack,
              child: Padding(
                padding: const EdgeInsets.only(top: 1),
                child:
                (widget.controller.currentTab ==  MainTabs.newAdds)?
                BuildHeader(text:   LocalString.getStringValue(context, 'add_adds') ??
                    "إضافة إعلان",)
                :
                BuildHeader(text:   LocalString.getStringValue(context, 'my_adds') ??
                    "إعلاناتي",)
                ,
              ),
            ),
          ),

          backgroundColor: ColorConstants.greenColor,

        )
                :
            SliverAppBar(
              pinned: true,
              floating: false,
              expandedHeight: 55,
              toolbarHeight: 55,
              titleSpacing: 0,
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.notifications,
                    size: 30,
                    color: Colors.white,
                  ),
                  onPressed: () {
                   Get.toNamed(Routes.Notification);
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.menu,
                    size: 30,
                    color: Colors.white,
                  ),
                  onPressed: () {
                   // Scaffold.of(context).openDrawer();
                    //widget.controller.scaffoldKey.currentState!.openDrawer();
                   // widget.controller.scaffoldKey== new GlobalKey<ScaffoldState>();
                   widget.controller.scaffoldKey.currentState!.openEndDrawer();
                    /*
                    if( widget.controller.scaffoldKey!=null &&  widget.controller.scaffoldKey.currentState!=null)
                      widget.controller.scaffoldKey.currentState!.openEndDrawer();
                    else
                    {
                      widget.controller.scaffoldKey== new GlobalKey<ScaffoldState>();
                      widget.controller.scaffoldKey.currentState!.openEndDrawer();
                    }


                     */

                  //  widget.controller.scaffoldKey.currentState!.openEndDrawer();
                  },
                ),
              ],
              title: Padding(
                  padding:  EdgeInsets.only(top:globals.imagePaddingTop),
                  child: Container(
                    //s alignment: Alignment.center,// use aligment
                    child: Image.asset(globals.getLogoImage(),
                      height:globals.imageHeightAppBar,
                      width: globals.imageWidthAppBar,
                      fit: BoxFit.fitWidth,),
                  )
              ),
              //stretch: false,
              //elevation: 5,

              backgroundColor: ColorConstants.greenColor,

            ),
            SliverFillRemaining(
              hasScrollBody: true,
              child:  buildWidget(context),
            )
          ],
        ),
      ),
    );
  }

  Widget buildWidget(BuildContext context) {
    return Scaffold(

      backgroundColor: ColorConstants.greyBack,
      body: _buildContent(widget.controller.currentTab.value),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: ColorConstants.greenColor,
        items: [
          _buildNavigationBarItem(
            LocalString.getStringValue(context, 'home') ??
                "حسابي",
            MainTabs.home == widget.controller.currentTab.value
                ? Icon(Icons.home,color: ColorConstants.white,)
                :Icon(Icons.home,color: ColorConstants.notActiveColor,),
          ),
          _buildNavigationBarItem(
            LocalString.getStringValue(context, 'add_adds') ??
                "إضافة إعلان",
            MainTabs.newAdds == widget.controller.currentTab.value
                ? Icon(Icons.add_circle_outline,color: ColorConstants.white,)
                :Icon(Icons.add_circle_outline,color: ColorConstants.notActiveColor,),
          ),
          _buildNavigationBarItem(
            LocalString.getStringValue(context, 'my_adds') ??
                "إعلاناتي",
            MainTabs.resource == widget.controller.currentTab.value  ?
            Icon(Icons.article,color: ColorConstants.white,)
                :Icon(Icons.article,color: ColorConstants.notActiveColor,),
          )
        ],

        unselectedItemColor:  ColorConstants.notActiveColor,
        currentIndex: widget.controller.getCurrentIndex(widget.controller.currentTab.value),
        selectedItemColor: ColorConstants.white,
        selectedLabelStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white
        ),
        onTap: (index)
        {
          onTapIndex(widget.controller,index);
        },
      ),
    );
  }
  void onTapIndex(HomeController controller,int index)
  {
    // If the drawer is open
    /*
    if (controller.scaffoldKey.currentState!.isDrawerOpen) {
      // Closes the drawer
      controller.scaffoldKey.currentState!?.openEndDrawer();
    }

     */
    if((index==1 || index==2 )&&(!MessageHelper.isLoggedIn()))
    {
      MessageHelper.goToLogin(context);
    }
    else {
      controller.switchTab(index);
      setState(() {

      });
    }

  }
  Widget _buildContent(MainTabs tab) {
    switch (tab) {
      case MainTabs.home:
        return widget.controller.mainTab;
      case MainTabs.newAdds:
        return widget.controller.newAdds;
    //return controller.discoverTab;
      case MainTabs.resource:
        return widget.controller.resourceTab;
    // return controller.resourceTab;
      case MainTabs.resource:
        return widget.controller.mainTab;
    // return controller.inboxTab;
    //return controller.meTab;
      default:
        return widget.controller.mainTab;
    }
  }

  BottomNavigationBarItem _buildNavigationBarItem(String label, Icon svg) {
    return BottomNavigationBarItem(
      icon: svg,//SvgPicture.asset('assets/svgs/$svg'),
      label: label,
    );
  }


}

class _Search extends StatefulWidget {

  _Search({Key? key}) : super(key: key);

  @override
  __SearchState createState() => __SearchState();
}

class __SearchState extends State<_Search> {
  TextEditingController? _editingController;

  @override
  void initState() {
    super.initState();

    _editingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              controller: _editingController,
              // textAlignVertical: TextAlignVertical.center,
              onChanged: (_) => callOpenSearch(),
              decoration: InputDecoration(
                hintText:  LocalString.getStringValue(context, 'search_with') ??
                    "ابحث مع الوفر",
                hintStyle: TextStyle(
                    color: ColorConstants.hintColor),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          _editingController!.text.trim().isEmpty
              ? IconButton(
              icon: Icon(Icons.search,
                  color: ColorConstants.darkGray),
              onPressed: null)
              : IconButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            icon: Icon(Icons.clear,
                color: ColorConstants.darkGray),
            onPressed: () => setState(
                  () {
                _editingController!.clear();
              },
            ),
          ),
        ],
      ),
    );
  }

  callOpenSearch() {
    if(!_editingController!.text.trim().isEmpty)
      {
        Get.toNamed(Routes.Search);

      }
  }
}

class SearchHeader extends SliverPersistentHeaderDelegate {
  final double minTopBarHeight = 100;
  final double maxTopBarHeight = 130;
  final String title;
  final IconData icon;
  final Widget search;
  final HomeController controller;
  SearchHeader({
    required this.title,
    required this.icon,
    required this.search,
    required this.controller
  });

  @override
  Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent,
      ) {
    var shrinkFactor = min(1, shrinkOffset / (maxExtent - minExtent));

    var topBar = Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        alignment: Alignment.topCenter,
        height:
        maxTopBarHeight,
        width: 100,
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                 //s alignment: Alignment.center,// use aligment
                  child: Image.asset(globals.getLogoImage(),
                      height: 45,
                      width: 150,
                      fit: BoxFit.cover),
                ),
                SizedBox(
                  width: 20,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.notifications,
                      size: 40,
                      color: Colors.white,
                    ),
                    IconButton(
                      icon: new Icon( Icons.menu,
                        size: 80,
                        color: Colors.white,),
                        //onPressed: () =>  Navigator.push(context, MaterialPageRoute(builder: (_) => MultiDrawer(controller.currentTab.value.index)))
                      onPressed: () {
                        if(controller.scaffoldKey!=null && controller.scaffoldKey.currentState!=null)
                        controller.scaffoldKey.currentState!.openEndDrawer();
                        else
                          {
                            controller.scaffoldKey== new GlobalKey<ScaffoldState>();
                            controller.scaffoldKey.currentState!.openEndDrawer();
                          }

                      }
                    )
                    /*,
                    Icon(
                      Icons.menu,
                      size: 40,
                      color: Colors.white,
                    )

                     */
                  ],
                ),

              ],
            ),
          ),
        ),
        decoration: BoxDecoration(
            color:ColorConstants.greenColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(36),
              bottomRight: Radius.circular(36),
            )),
      ),
    );
    return Container(
     // height: max(maxExtent - shrinkOffset, minExtent),
      child:  Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.only(
              bottom: 1,
              top: 1
          ),
          child: Container(

            alignment: Alignment.topCenter,
            child: search,
            width: SizeConfig().screenWidth * 0.9,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,

            ),
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 130;

  @override
  double get minExtent => 90;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
