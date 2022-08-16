import 'package:billing/models/responses/categories_response.dart';
import 'package:billing/models/responses/sub_catagories_response.dart';
import 'package:billing/modules/search/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../modules/search/search_screen.dart';
import '../../constants/colors.dart';
import '../../services/LocalString.dart';
import '../../../globals.dart' as globals;
class SearchAppBarCustom extends StatefulWidget {
  final String title;
  final TextEditingController? editingController;
  final SearchScreenState? searchScreenState;
  final SearchController? controller;
  SearchAppBarCustom({Key? key, required this.title, this.editingController, this.searchScreenState, this.controller}) : super(key: key);

  @override
  State<SearchAppBarCustom> createState() => SearchAppBarCustomState();
}

class SearchAppBarCustomState extends State<SearchAppBarCustom> {
  bool checkboxValueCity = false;
  List<SubCategory> allCities = [];
  List<SubCategory?>? selectedCities = [];
  List<SubCategory> models =[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  callOpenSearch()
  {

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  SliverAppBar(
      pinned: true,
      expandedHeight: 55,
      toolbarHeight: 55,
      titleSpacing: 0,
      actions: <Widget>[
        IconButton(
          icon:  Image.asset('images/back.png'),
          onPressed: () {
            Get.back();
          },
        ),
      ],
      leadingWidth: 0,

      automaticallyImplyLeading: false,
      title: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Container(
            //s alignment: Alignment.center,// use aligment
            child: Image.asset(globals.getLogoImage(),
              height:44,
              width: 130,
              fit: BoxFit.fitWidth,),
          )
      ),
      bottom: PreferredSize(
        preferredSize:  Size.fromHeight(kToolbarHeight),
        child: Container(


          child:  Container(

            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(3),
                      //color: ColorConstants.white,
                      decoration: BoxDecoration( borderRadius: BorderRadius.circular(10),
                        color: Colors.white,

                      ),
                      child: TextField(
                        textInputAction: TextInputAction.search,
                        onSubmitted: (text) {
                          callSearch();
                        },
                        controller: widget.editingController,
                        decoration: InputDecoration(
                            hintText: LocalString.getStringValue(context, 'search_with') ??
                                "ابحث مع الوفر",
                            hintStyle: TextStyle(color: ColorConstants.hintColor),
                          enabledBorder: InputBorder.none,
                           focusedBorder: InputBorder.none,
                            prefixIcon:  IconButton(
                                onPressed: () => setState(
                                      () {
                                        callSearch();
                                  },
                                ),
                                icon: Icon(Icons.search, color: ColorConstants.greenColor))
                        ),
                      ),
                    ),
                  ),
                 Container(
                 //  color: Colors.red,
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.end,
                     children: [
                       (! widget.editingController!.text.trim().isEmpty)?
                       Container(
                         width: 20,
                         child: IconButton(
                             highlightColor: Colors.transparent,
                             splashColor: Colors.transparent,
                             icon: Icon(Icons.clear,size: 20,
                                 color: ColorConstants.white),
                             onPressed: () => resetSearch()
                         ),
                       ):Text(''),
                       IconButton(
                           highlightColor: Colors.transparent,
                           splashColor: Colors.transparent,
                           icon: Icon(Icons.sort,size: 20,
                               color: ColorConstants.white),
                           onPressed: () {
                             if(widget.controller!.category!=null)
                             {
                               selectedCities!.clear();
                               selectedCities!.add(widget.controller!.category);
                             }

                             //  showDialogItems(context);

                             showDialog(
                                 context: context,
                                 builder: (context) {
                                   return _MyDialog(
                                       controller: widget.controller,
                                       widget:this,
                                       cities: globals.orginalcategories,
                                       selectedCities: [],
                                       onSelectedCitiesListChanged: (cities) {
                                         selectedCities = cities;
                                         print(selectedCities);
                                       });
                                 });




                           }
                       ),
                     ],
                   ),
                 ),

                ],
              ),
            ),
          ),
        ),
      ),



      backgroundColor: ColorConstants.greenColor,

    );
  }
  void callSearch()
  {
    if(!widget.editingController!.text.trim().isEmpty || widget.controller!.category!=null ||  widget.controller!.isNear
    || widget.controller!.isHigh || widget.controller!.isLow)
    {
      widget.controller!.prefix=widget.editingController!.text;
      widget.controller!.getData(1);
    }
  }
 void resetSearch()
  {
    widget.editingController!.clear();
    setState(() {

    });
  }

}
class _MyDialog extends StatefulWidget {
  _MyDialog({
    required this.cities,
    required this.selectedCities,
    required this.onSelectedCitiesListChanged,
    required this.controller,
    required this.widget
  });

  final List<SubCategory> cities;
  final List<SubCategory> selectedCities;
  final ValueChanged<List<SubCategory>> onSelectedCitiesListChanged;
  final SearchController? controller;
  final SearchAppBarCustomState widget;
  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<_MyDialog> {
  List<SubCategory> _tempSelectedCities = [];

  @override
  void initState() {
    if(widget.controller!.category!=null) {
      //_tempSelectedCities = widget.selectedCities;
      SubCategory category = widget.controller!.category!;
      _tempSelectedCities =[];
      _tempSelectedCities.add(category);
      setState(() {

      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        children: <Widget>[
          SizedBox(height:5,),
          Text(
            LocalString.getStringValue(context, 'search_filter') ??
                "خيارات البحث",
            style: TextStyle(fontSize: 18.0, color: Colors.black,fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          CheckboxListTile(
            activeColor: ColorConstants.greenColor,
            title: Text( LocalString.getStringValue(context, 'near') ??
                "الأقرب"),
            value: widget.controller!.isNear,
            onChanged: (value) {
              setState(() {
                if(value==true)
                  {
                    widget.controller!.isLow=false;
                    widget.controller!.isHigh=false;
                  }
                widget.controller!.isNear = value!;
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),
          CheckboxListTile(
            activeColor: ColorConstants.greenColor,
            title: Text( LocalString.getStringValue(context, 'low_price') ??
                "الأرخص"),
            value: widget.controller!.isLow,
            onChanged: (value) {
              setState(() {
                if(value==true)
                  {
                    widget.controller!.isHigh=false;
                    widget.controller!.isNear=false;
                  }
                widget.controller!.isLow = value!;
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),
          CheckboxListTile(
            activeColor: ColorConstants.greenColor,
            title: Text( LocalString.getStringValue(context, 'high_price') ??
                "الأغلى"),
            value: widget.controller!.isHigh,
            onChanged: (value) {
              setState(() {
                if(value==true)
                {
                  widget.controller!.isLow=false;
                  widget.controller!.isNear=false;
                }
                widget.controller!.isHigh = value!;
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[

              Text(
                LocalString.getStringValue(context, 'select_catrgory') ??
                    "اختر التصنيف",
                style: TextStyle(fontSize: 18.0, color: Colors.black,fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),

            ],
          ),
          Expanded(
            child: ListView.builder(
                itemCount: widget.cities.length,
                itemBuilder: (BuildContext context, int index) {
                  final cityName = widget.cities[index];
                  return Container(
                    child: CheckboxListTile(

                        title: ListTile(
                          leading: CircleAvatar(backgroundImage: cityName.image == null ? null : NetworkImage(cityName.image!)),
                          title: Text(cityName.name),
                        ),
                        value: _tempSelectedCities.contains(cityName),
                        onChanged: (bool? value) {
                          if (value!) {
                            if (!_tempSelectedCities.contains(cityName)) {
                              setState(() {
                                _tempSelectedCities.add(cityName);
                              });
                            }
                          } else {
                            if (_tempSelectedCities.contains(cityName)) {
                              setState(() {
                                _tempSelectedCities.removeWhere(
                                        (SubCategory city) => city == cityName);
                              });
                            }
                          }
                          widget
                              .onSelectedCitiesListChanged(_tempSelectedCities);
                        }),
                  );
                }),
          ),


          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(

                  onPressed: () {
                    // Remove the box
                    setState(() {
                      if(_tempSelectedCities!=null&& _tempSelectedCities.length>0)
                        {
                          widget.controller!.category=_tempSelectedCities[0];
                        }
                      else
                        {
                          widget.controller!.category=null;
                        }
                    });

                    // Close the dialog
                    Navigator.of(context).pop();
                    widget.widget.callSearch();
                  },
                  child:  Text(LocalString.getStringValue(context, 'ok') ??
                      "تم"
                       ,
                    style: TextStyle(color: ColorConstants.greenColor),
                  )),
              TextButton(
                  onPressed: () {

                    Navigator.of(context).pop();
                  },
                  child:  Text(LocalString.getStringValue(context, 'cancel') ??
                      "الغاء",
                    style: TextStyle(color: ColorConstants.greenColor),
                  ))
            ],
          ),

        ],
      ),

    );
  }
}