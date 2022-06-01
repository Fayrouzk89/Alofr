import 'dart:math';

import 'package:billing/shared/shared.dart';
import 'package:flutter/material.dart';


import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../shared/constants/colors.dart';
import '../../shared/services/LocalString.dart';
import 'home_controller.dart';
import 'tabs/tabs.dart';

class HomeScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      //child: Obx(() => _buildWidget(context)),
      child:  MyHomePage(controller),
    );
  }

}
class MyHomePage extends StatefulWidget {
  final HomeController controller;
  MyHomePage(this.controller):super();
  @override
  State<MyHomePage> createState() => _MyHomePageState();
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.whiteBack,
      body: Center(
        child: _buildContent(controller.currentTab.value),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          _buildNavigationBarItem(
            LocalString.getStringValue(context, 'my_account') ??
                "حسابي",
            MainTabs.home == controller.currentTab.value
                ? Icon(Icons.person,color: ColorConstants.white,)
                :Icon(Icons.person,color: ColorConstants.notActiveColor,),
          ),
          _buildNavigationBarItem(
            LocalString.getStringValue(context, 'add_adds') ??
                "إضافة إعلان",
            MainTabs.discover == controller.currentTab.value
                ? Icon(Icons.add,color: ColorConstants.white,)
                :Icon(Icons.add,color: ColorConstants.notActiveColor,),
          ),
          _buildNavigationBarItem(
            LocalString.getStringValue(context, 'my_adds') ??
                "إعلاناتي",
            MainTabs.resource == controller.currentTab.value  ?
            Icon(Icons.article,color: ColorConstants.white,)
                :Icon(Icons.article,color: ColorConstants.notActiveColor,),
          )
        ],
        type: BottomNavigationBarType.fixed,
        unselectedItemColor:  ColorConstants.notActiveColor,
        currentIndex: controller.getCurrentIndex(controller.currentTab.value),
        selectedItemColor: ColorConstants.white,
        selectedLabelStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white
        ),
        onTap: (index) => controller.switchTab(index),
      ),
    );
  }

  Widget _buildContent(MainTabs tab) {
    switch (tab) {
      case MainTabs.home:
        return controller.mainTab;
      case MainTabs.discover:
        return controller.mainTab;
    //return controller.discoverTab;
      case MainTabs.resource:
        return controller.mainTab;
    // return controller.resourceTab;
      case MainTabs.inbox:
        return controller.mainTab;
    // return controller.inboxTab;
      case MainTabs.me:
        return controller.mainTab;
    //return controller.meTab;
      default:
        return controller.mainTab;
    }
  }

  BottomNavigationBarItem _buildNavigationBarItem(String label, Icon svg) {
    return BottomNavigationBarItem(
      icon: svg,//SvgPicture.asset('assets/svgs/$svg'),
      label: label,
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            floating: false,
            delegate: SearchHeader(
              icon: Icons.terrain,
              title: 'Trees',
              search: _Search(),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: true,
            child: Obx(() => widget.buildWidget(context)),
          )
        ],
      ),
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
              onChanged: (_) => setState(() {}),
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
}

class SearchHeader extends SliverPersistentHeaderDelegate {
  final double minTopBarHeight = 90;
  final double maxTopBarHeight = 150;
  final String title;
  final IconData icon;
  final Widget search;

  SearchHeader({
    required this.title,
    required this.icon,
    required this.search,
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
        max(maxTopBarHeight * (1 - shrinkFactor * 1.45), minTopBarHeight),
        width: 100,
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                 //s alignment: Alignment.center,// use aligment
                  child: Image.asset('images/title.png',
                      height: 50,
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
                    Icon(
                      Icons.menu,
                      size: 40,
                      color: Colors.white,
                    )
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
      height: max(maxExtent - shrinkOffset, minExtent),
      child: Stack(
        fit: StackFit.loose,
        children: [
          if (shrinkFactor <= 0.5) topBar,
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: 15,
                top: 60
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
          if (shrinkFactor > 0.5) topBar,
        ],
      ),
    );
  }

  @override
  double get maxExtent => 200;

  @override
  double get minExtent => 100;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
