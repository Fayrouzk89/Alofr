import 'dart:convert';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:http/http.dart' as http;
import 'package:billing/dioApi/api.dart';
import 'package:chip_list/chip_list.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:sweetalert/sweetalert.dart';
import '../../../models/Images.dart';
import '../../../models/Product.dart';
import '../../../models/responses/sub_catagories_response.dart';
import '../../../shared/constants/colors.dart';
import '../../../shared/constants/common.dart';
import '../../../shared/services/LocalString.dart';
import '../../../shared/services/MessageHelper.dart';
import '../../../shared/utils/common_widget.dart';
import '../../../shared/utils/regex.dart';
import '../../../shared/utils/size_config.dart';
import '../../../shared/widgets/AppBars/titled_app_bar.dart';
import '../../../shared/widgets/InputField2.dart';
import '../../../shared/widgets/SharedWidget/LableHeader.dart';
import '../../../shared/widgets/SharedWidget/LableText.dart';
import '../../../shared/widgets/custom_rounded.dart';
import '../../../shared/widgets/input_field.dart';
import '../../../shared/widgets/input_field_multi.dart';
import '../../../shared/widgets/input_field_phone.dart';
import '../../../shared/widgets/input_field_with_suffiex.dart';
import '../../../shared/widgets/no_date.dart';
import '../../mapcustom/CustomPlacesPickers.dart';
import '../home_controller.dart';
import '../../../globals.dart' as globals;


import 'package:place_picker/place_picker.dart';


class NewAdds extends StatefulWidget {
  final bool isEdit;
  final Product? editProduct;
 final HomeController controller;
  NewAdds(this.isEdit, this.editProduct, this.controller);

  @override
  State<NewAdds> createState() => _NewAddsState();
}

class _NewAddsState extends State<NewAdds> {
  @override
  initState() {
    super.initState();
  //  widget.controller.newAddFormKey= GlobalKey<FormState>();
    // Add listeners to this class
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

       appBar: (widget.isEdit)?TitledAppBar( LocalString.getStringValue(context, 'edit_adds') ??
           "تعديل إعلان",):null,
        backgroundColor: ColorConstants.greyBack,
      body:FormNewAdds(controller: widget.controller,isEdit: widget.isEdit,editProduct: widget.editProduct,),

    );
  }
}
class FormNewAdds extends StatefulWidget {
  final HomeController controller;
  final bool? isEdit;
  final Product? editProduct;
   FormNewAdds ({ Key? key,required this.controller, this.isEdit, this.editProduct }): super(key: key);

  @override
  _FormNewAddsState createState() => _FormNewAddsState();
}

class _FormNewAddsState extends State<FormNewAdds>{

  int currentcatIndex=0;
  int currentsubcatIndex=0;
  @override
  Widget build(BuildContext context) {
    return buildFormView(widget.controller,context);
  }
  String selectedValue="";

  List<Asset> images = <Asset>[];
  List<Images>existsimages=<Images>[];
  String _error = '';
  @override
  void initState() {
    super.initState();
    //widget.controller.newAddFormKey=GlobalKey<FormState>();
    /*
    if(widget.isEdit==false)
    {
      widget.controller.titleTextController.text="";
      widget.controller.descriptionController.text="";
      widget.controller.priceController.text="";
      widget.controller.phoneController.text="";
      widget.controller.city="";
      widget.controller.mainCategory=null;
      widget.controller.subCategory=null;
      setState(() {

      });
    }

     */
    initData();

  }



  void initData()async
  {
    await initSubCategories();
    if(widget.isEdit==true)
    {
      initFormData();
    }

  }
  String address="";
  void initFormData()
  {
    address="";
   widget.controller.titleTextController.text=widget.editProduct!.title??"";
   widget.controller.descriptionController.text=widget.editProduct!.desctiption??"";
   widget.controller.priceController.text=widget.editProduct!.price??"";
   widget.controller.phoneController.text=widget.editProduct!.mobile??"";

   globals.latLng=LatLng(double.parse(widget.editProduct!.latitude),double.parse(widget.editProduct!.longitude));
   initMainSubData();
    initCity();
    initPhotos();
    getAddressFromLatLng(context,double.parse(widget.editProduct!.latitude),double.parse(widget.editProduct!.longitude));
  }
  void initCity()
  {
    widget.controller.city="";
    String mapKey="";
    for (var kv in globals.englishCity.entries) {
     String key = kv.key;
     String value= kv.value;
     if(value==widget.editProduct!.city)
       {
         mapKey = key;
         break;
       }
    }
    if(mapKey== "")
      {
        for (var kv in globals.arabicCity.entries) {
          String key = kv.key;
          String value= kv.value;
          if(value==widget.editProduct!.city)
          {
            mapKey = key;
            break;
          }
        }
      }
     if(mapKey!="")
       {
         widget.controller.city= LocalString.getStringValue(context, mapKey) ?? "AlAhmadi";
       }
       else
         {
           widget.controller.city=   LocalString.getStringValue(context, 'AlAhmadi') ?? "AlAhmadi";
         }
       setState(() {

       });
  }
  void initPhotos()
  {
    if(widget.editProduct!.images!=null && widget.editProduct!.images.length>0)
      {
        existsimages=widget.editProduct!.images;
        setState(() {

        });
      }
  }
  void initMainSubData()
  {
    currentsubcatIndex=getSubCategoryIndex();
    int mainId = widget.controller.subcategories.value!.data[currentsubcatIndex].parent.id;
    if(widget.controller.orginalcategories.value!=null) {
      for (int i = 0; i <
          widget.controller.orginalcategories.value!.data.length; i++) {
        if (widget.controller.orginalcategories.value!.data[i].id ==
            mainId ) {
          currentcatIndex=i;
          break;
        }
      }
    }
    getSubCategory(
        widget.controller.orginalcategories.value!.data[currentcatIndex].id);
    currentsubcatIndex=getSubCategoryIndexInner(mainId);

    print("sub category"+currentsubcatIndex.toString());
    widget.controller.subCategory = data[currentsubcatIndex];
   // widget.controller.subCategory= data[currentsubcatIndex];
    widget.controller.mainCategory =
    widget.controller.orginalcategories.value!.data[currentcatIndex];
    setState(() {

    });
  }
  int getSubCategoryIndexInner(int parent)
  {
    data=[];
    int id =  widget.editProduct!.category.id;
    for (int i = 0; i <
        widget.controller.subcategories.value!.data.length; i++) {
      if (widget.controller.subcategories.value!.data[i].parent.id ==
          parent) {
        data.add(widget.controller.subcategories.value!.data[i]);
      }
    }
    for (int i = 0; i < data.length; i++) {
      if (data[i].id==id) {
        return i;
      }
    }

    return 0;
  }
  int getSubCategoryIndex()
  {
    int id =  widget.editProduct!.category.id;


    if(widget.controller.subcategories.value!=null) {
      for (int i = 0; i < widget.controller.subcategories.value!.data.length; i++) {
        int Subid =widget.controller.subcategories.value!.data[i].id;
        if (Subid == id) {
          widget.controller.subCategory=(widget.controller.subcategories.value!.data[i]);
          return i;
        }
      }
    }
    return 0;
  }
  Future<void> initSubCategories()async
  {
   await widget.controller.getSubCategories();
   getSubCategory(0);
  }
  void initMainCategories()async
  {
    await widget.controller. getCategories();
    BuildCatNames();
    setState(() {

    });
  }

  Widget buildSelectCity(BuildContext context)
  {
    return Container(
      child: DropdownButtonFormField2(
        decoration: InputDecoration(
          filled: true,
          fillColor: ColorConstants.white,
          focusColor: ColorConstants.white,
          focusedBorder:   OutlineInputBorder(
            // width: 0.0 produces a thin "hairline" border
            borderRadius: BorderRadius.circular(25),
            borderSide:  BorderSide(color: ColorConstants.white, width: 0.0),
          ),
          //Add isDense true and zero Padding.
          //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
          isDense: true,
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          //Add more decoration as you want here
          //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
        ),
        isExpanded: true,
        hint: Text(
          LocalString.getStringValue(context, 'select_city') ??
              'اختر مدينة',
          style: TextStyle(fontSize: 14),
        ),
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.black45,
        ),
        iconSize: 30,
        buttonHeight: 50,
        buttonPadding: const EdgeInsets.only(left: 20, right: 10),
        dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: ColorConstants.white),
        items: globals.getItems(context)
            .map((item) => DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ))
            .toList(),
        validator: (value) {
          if (value == null) {
            return LocalString.getStringValue(
                context, 'city_required') ??
                'المدينة حقل مطلوب';
          }
        },
        onChanged: (value) {
          //Do something when changing the item if you want.
         widget.controller.city=value.toString();
        },
        onSaved: (value) {
          selectedValue = value.toString();
        },
        value: (widget.controller.city!="")?widget.controller.city:null,
      ),
    );
  }

  Widget buildUploadImages(BuildContext context)
  {
    return Row(
      children: <Widget>[

        Expanded(
          child: buildGridView(),
        )
      ],
    );

  }
  Widget buildEditImages(BuildContext context)
  {
    return Row(
      children: <Widget>[

        Expanded(
          child:  buildExistsGridView()
        )
      ],
    );

  }

  Widget buildGridView() {
    
    return (images.length>0)? GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return  Card(
          color: Colors.white,
          elevation: 5,
          child: AssetThumb(
            asset: asset,
            width: 300,
            height: 300,
          ),
        );
      }),
    ):Text('');
  }
  Widget buildExistsGridView() {

    return (existsimages.length>0)?
    Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        children: List.generate(existsimages.length, (index) {
          return Card(
            color: Colors.white,
            elevation: 5,
            child: Column(
              children: [
                Image.network(
                  existsimages[index].image,
                  width: 100,
                  height: 100,
                ),
                GestureDetector(
                  onTap: ()
                  {
                    DisplayDialogDelete(existsimages[index],context);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.delete, color: Colors.red, size: 25),
                      Container(
                          child: Text(
                            LocalString.getStringValue(
                                context, 'delete') ??
                                "حذف",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          )),
                    ],
                  ),
                )
              ],
            ),
          );
        }),
      ),
    ):Text('');
  }
  void DisplayDialogDelete(Images id, BuildContext context) {
    SweetAlert.show(context,
        subtitle: LocalString.getStringValue(context, 'delete_confirmation') ??
            "هل تريد تأكيد حذف الإعلان؟",
        style: SweetAlertStyle.confirm,
        cancelButtonText:
        LocalString.getStringValue(context, 'cancel') ?? "إلغاء",
        confirmButtonText:
        LocalString.getStringValue(context, 'confirm') ?? "تأكيد",
        showCancelButton: true, onPress: (bool isConfirm) {
          if (isConfirm) {
            Navigator.of(context).pop();
            CallDeleteProduct(id, context);
            /*
            new Future.delayed(new Duration(seconds: 2),(){
              SweetAlert.show(context,subtitle: "Success!", style: SweetAlertStyle.success);
            });

             */
          } else {
            SweetAlert.show(context,
                subtitle: "Canceled!", style: SweetAlertStyle.error);
          }
          // return false to keep dialog
          return false;
        });
  }
  CallDeleteProduct(Images imageId,BuildContext context)
  {
    widget.controller!.deleteProductImage(context, imageId,widget.editProduct);
  }
  bool isSetLocation=false;
  void chooseLocation()async
  {
    if(widget.editProduct!=null)
      {
          if(widget.editProduct!.latitude!=null && widget.editProduct!.latitude!="") {
            LatLng? displayLocation = LatLng(
                double.parse(widget.editProduct!.latitude),
                double.parse(widget.editProduct!.longitude));
            LocationResult? result = await Navigator.of(context).push(
                MaterialPageRoute(builder: (context) =>
                    CustomPlacePicker(globals.MapApiKey, false,
                      displayLocation: displayLocation,))).then((_) {
              if (globals.latLng != null) {
                getAddressFromLatLng(context, globals.latLng!.latitude,
                    globals.latLng!.longitude);
              }
            });
          }

      }
    else {
      LocationResult? result = await Navigator.of(context).push(
          MaterialPageRoute(builder: (context) =>
              CustomPlacePicker(globals.MapApiKey, false))).then((_)
      {
           if(globals.latLng!=null)
             {
               getAddressFromLatLng(context, globals.latLng!.latitude, globals.latLng!.longitude);
             }
      });
    }
    //print("result is "+result.latLng.toString());
    isSetLocation=true;
    setState(() {

    });
  }
  getAddressFromLatLng(context, double lat, double lng) async {
    try {

      final coordinates = new Coordinates(
          lat, lng);
      var addresses = await Geocoder.local.findAddressesFromCoordinates(
          coordinates);
      var first = addresses.first;
      //print(' ${first.locality}');
      if (first.adminArea != null) {
        address = "";
        address = first.adminArea;
      }
      if (first.subLocality != null) {
        address = address + " " + first.subLocality;
      }
      setState(() {

      });
      print(
          ' ${first.locality}, ${first.adminArea},${first.subLocality}, ${first
              .subAdminArea},${first.addressLine}, ${first.featureName},${first
              .thoroughfare}, ${first.subThoroughfare}');
      return first;


    }
    catch(e)
    {}
  }
  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = '';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 8,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: '#4BAE4F',
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
      widget.controller.resultList=resultList;
    } on Exception catch (e) {
      error = e.toString();
      widget.controller.resultList=[];
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

     setState(() {
    images = resultList;
    _error = error;
    });
  }

  Widget buildFormView(HomeController controller,BuildContext context) {
    return Form(
      key: controller.newAddFormKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0,right: 12,top: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  LableHeader(text: LocalString.getStringValue(context, 'choose_category') ??
                      "اختر الفئة"),
                  buildMainCategory(),
                  LableHeader(text: LocalString.getStringValue(context, 'choose_sub_category') ??
                      "اختر الفئة الفرعية"),
                  buildSubCategory(),
                  CommonWidget.rowHeight(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LableHeader(text: LocalString.getStringValue(context, 'choose_ads') ??
                          "اختر صور اعلانك"),
                      LableText(text: LocalString.getStringValue(context, 'can_upload_eight') ??
                          "يمكن رفع 8 صور"),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                     height: 140,
                      width: SizeConfig().screenWidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: ColorConstants.white,
                      ),
                      child: Container(child: IconButton(
                        icon: const Icon(Icons.add,size: 50,),
                        color: ColorConstants.greenColor,
                        onPressed: () {
                          loadAssets();
                        },
                      ),)
                    ),
                  ),
                  buildUploadImages(context),
                  (widget.isEdit==true)?buildEditImages(context):Text(''),
                  (_error!=null && _error!='')?Center(child: Text(' $_error')):Container(height: 1,),
                  InputField2(
                    controller: controller.titleTextController,
                    keyboardType: TextInputType.text,
                    //labelText: 'Email address',
                    placeholder:
                    LocalString.getStringValue(context, 'adds_name') ??
                        'اسم الإعلان',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return LocalString.getStringValue(
                            context, 'adds_name_required') ??
                            'الاسم حقل مطلوب';
                      }

                      return null;
                    },
                    icon: Icons.description_rounded,
                    //icon: Icons.auto_stories,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4,right: 4,top: 4),
                    child: Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: Text(
                          LocalString.getStringValue(context, '100_char') ??
                              '100 حرف',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: CommonConstants.smallText,
                              color: ColorConstants.textColor),
                        )),
                  ),
                  CommonWidget.rowHeight(height: 10),
                  InputFieldMulti(
                    controller: controller.descriptionController,
                    keyboardType: TextInputType.text,
                    //labelText: 'Email address',
                    placeholder:
                    LocalString.getStringValue(context, 'adds_description') ??
                        'توصيف الإعلان',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return LocalString.getStringValue(
                            context, 'adds_description_required') ??
                            'التوصيف مطلوب';
                      }
                      return null;
                    },
                    icon: Icons.description_rounded,
                    //icon: Icons.auto_stories,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4,right: 4,top: 4),
                    child: Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: Text(
                          LocalString.getStringValue(context, '5000_char') ??
                              '5000 حرف',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: CommonConstants.smallText,
                              color: ColorConstants.textColor),
                        )),
                  ),
                  CommonWidget.rowHeight(height: 10),
                  InputFieldWithSuffiex(
                    controller: controller.priceController,
                    keyboardType: TextInputType.text,
                    //labelText: 'Email address',
                    placeholder:
                    LocalString.getStringValue(context, 'expected_price') ??
                        'السعر المتوقع',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return LocalString.getStringValue(
                            context, 'price_required') ??
                            'السعر المتوقع حقل مطلوب';
                      }

                      return null;
                    },
                    icon: Icons.description_rounded,
                    suffiex: Text(
                          "KD",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: CommonConstants.normalText,
                          color: ColorConstants.textColor,
                          fontFamily: CommonConstants.largeTextFont),
                    ),
                  ),
                  CommonWidget.rowHeight(height: 10),
                  buildSelectCity(context),
                  CommonWidget.rowHeight(height: 10),
                  InputFieldPhone(
                    controller: controller.phoneController,
                    keyboardType: TextInputType.text,
                    //labelText: 'Email address',
                    placeholder: LocalString.getStringValue(context, 'enter_phone') ??
                        'ادخل رقم الهاتف',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return LocalString.getStringValue(
                            context, 'phone_required') ??
                            'رقم الهاتف حقل مطلوب';
                      }
                      if (value.length != CommonConstants.phoneLength) {
                        return LocalString.getStringValue(context, 'phone_length') ??
                            'طول الرقم 10 حروف';
                      }
                      if (value != null) {
                        if (!Regex.isPhone(value)) {
                          return LocalString.getStringValue(context, 'phone_error') ??
                              'خطأ في صيغة الهاتف';
                        }
                      }
                      return null;
                    },
                    icon: Icons.phone,
                  ),
                  CommonWidget.rowHeight(height: 10),
                  LableHeader( text: LocalString.getStringValue(context, 'choose_location') ??
                      "اختر موقعك على الخريطة"),
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                        height: 140,
                        width: SizeConfig().screenWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: ColorConstants.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(child: IconButton(
                              icon:  Icon((widget.isEdit==true)? Icons.edit:Icons.add,size: 50,),
                              color: ColorConstants.greenColor,
                              onPressed: () {
                                chooseLocation();
                              },
                            ),),
                            (address=="")?Container(height: 1,):
                            LableText(text: address),
                          ],
                        )
                    ),
                  ),
                  /*
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      // height: 110,
                      width: SizeConfig().screenWidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: ColorConstants.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 1.0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.location_history,
                              size: 40,
                              color: Colors.grey,
                              semanticLabel: 'Text to announce in accessibility modes',
                            ),
                            Container(child: IconButton(
                              icon: const Icon(Icons.add,size: 50,),
                              color: ColorConstants.greenColor,
                              onPressed: () {
                                chooseLocation();
                              },
                            ),)
                            ,
                            SizedBox(height: 10,),
                            /*
                            Container(
                                alignment: Alignment.center,
                                margin:  EdgeInsets.symmetric(horizontal: CommonConstants.horizontalPaddingButton, vertical: CommonConstants.verticalPaddingButton),
                                child: CustomRounded(
                                  text: LocalString.getStringValue(context, 'open_map') ?? "افتح الخريطة",
                                  textSize: CommonConstants.textButton,
                                  textColor: ColorConstants.greenColor,
                                  color: Colors.white,
                                  size: Size(SizeConfig().screenWidth  * 0.8, CommonConstants.roundedHeight),
                                  pressed: () {
                                    chooseLocation();
                                  },
                                )),

                             */
                          ],
                        ),
                      ),
                    ),
                  ),

                   */
                  //(isSetLocation && globals.latLng==null)?
                   //   Text(LocalString.getStringValue(context, 'please_select_address') ?? " يجب تحديد العنوان" ,style: TextStyle(color: Colors.red),):Text(''),
                  CommonWidget.rowHeight(height: 10.0),
                  Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(
                          horizontal: CommonConstants.horizontalPaddingButton,
                          vertical: CommonConstants.verticalPaddingButton),
                      child: CustomRounded(
                          text:(widget.isEdit==true)?
                          LocalString.getStringValue(context, 'save_changes') ??
                              "حفظ التغييرات"
                          :
                          LocalString.getStringValue(context, 'create_add') ??
                              "نشر الإعلان"
                          ,
                          textSize: CommonConstants.textButton,
                          textColor: Colors.white,
                          color: ColorConstants.greenColor,
                          size: Size(SizeConfig().screenWidth * 0.8,
                              CommonConstants.roundedHeight),
                          pressed: () {
                             addValidate(controller);
                          })),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  void addValidate(HomeController controller)
  {
    if(widget.controller.orginalcategories==null || widget.controller.orginalcategories.value==null)
      {
        initMainCategories();
      }
    else if(widget.controller.subcategories==null || widget.controller.subcategories.value==null)
      {
        initSubCategories();
      }
    else {
      controller.latLng = globals.latLng;
      if (controller.mainCategory == null) {
        MessageHelper.showMessage(context, LocalString.getStringValue(
            context, 'please_select_main_category') ??
            "يجب اختيار الفئة الرئيسية");
      }
      else if (controller.subCategory == null) {
        MessageHelper.showMessage(context, LocalString.getStringValue(
            context, 'please_select_sub_category') ??
            "يجب اختيار الفئة الفرعية");
      }
      else if (controller.resultList.length == 0 && widget.isEdit==false) {
        MessageHelper.showMessage(context, LocalString.getStringValue(
            context, 'please_select_one_image') ??
            "يجب تحديد صورة واحدة للإعلان على الأقل");
      }
      else if (controller.city == "") {
        MessageHelper.showMessage(context, LocalString.getStringValue(
            context, 'please_select_city') ??
            "يجب اختيار مدينة الإعلان");
      }
      /*
      else if (controller.latLng == null) {
        MessageHelper.showMessage(context, LocalString.getStringValue(
            context, 'please_select_address') ??
            "يجب اختيار موقع الإعلان");
      }

       */
      else {
        if(widget.isEdit==true)
          {
            controller.adNew(context,widget.editProduct,true);
          }
        else
        controller.adNew(context,null,false);
      }
    }
  }
  List<String> BuildCatNames()
  {
    List<String> catsNames = [];
    if(widget.controller.orginalcategories.value !=null) {

      for (int i = 0; i <
          widget.controller.orginalcategories.value!.data.length; i++) {
        catsNames.add(widget.controller.orginalcategories.value!.data[i].name);
      }
      if (catsNames.length > 0) {
        widget.controller.mainCategory =
        widget.controller.orginalcategories.value!.data[currentcatIndex];
      }
    }
    return catsNames;
  }
  Widget buildMainCategory()
  {
    if(widget.controller.orginalcategories.value !=null) {
      List<String> catsNames = BuildCatNames();


      return Container(
        child: ChipList(
          shouldWrap: true,
          supportsMultiSelect: false,
          listOfChipNames: catsNames,
          activeBgColorList: [ ColorConstants.greenColor],
          inactiveBgColorList: [Colors.white],
          activeTextColorList: [Colors.white],
          inactiveTextColorList: [Theme
              .of(context)
              .primaryColor
          ],
          listOfChipIndicesCurrentlySeclected: [currentcatIndex],
          activeBorderColorList: [Theme
              .of(context)
              .primaryColor
          ],
          extraOnToggle: (val) {
            currentcatIndex = val;
            getSubCategory(
                widget.controller.orginalcategories.value!.data[currentcatIndex].id);

            setState(() {});
          },
        ),
      );
    }
    else
      return Text('');
  }
  Widget buildSubCategory()
  {
    List<String> catsNames = [];
    for(int i=0;i<data.length;i++)
    {
      catsNames.add(data[i].name);
    }

    updateSunCategory();

    return (catsNames.length>0)?Container(
      child: ChipList(
        shouldWrap: true,
        supportsMultiSelect: false,
        listOfChipNames: catsNames,
        activeBgColorList:[ ColorConstants.greenColor],
        inactiveBgColorList: [Colors.white],
        activeTextColorList: [Colors.white],
        inactiveTextColorList: [Theme.of(context).primaryColor],
        listOfChipIndicesCurrentlySeclected: [currentsubcatIndex],
        activeBorderColorList: [Theme.of(context).primaryColor],
        extraOnToggle: (val) {
          currentsubcatIndex = val;
          updateSunCategory();
          setState(() {});
        },
      ),
    ):   Container(
      height: 150,
      child:
      Padding(
        padding: const EdgeInsets.only(top: 20.0,left: 10,right: 10),
        child: Container(
          height: 150,
          child: Card(
              elevation: 5,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white70, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child:

              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Image.asset(
                        'images/review.png',
                        width: 100,
                        height: 50,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 1, right: 1, top: 10,bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child:
                            Text(
                                LocalString.getStringValue(context, 'no_categories') ??
                                    "لا يوجد تصنيفات فرعية",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(0xFF444444),
                                    fontFamily: CommonConstants.largeTextFont,
                                    fontSize: CommonConstants.meduimText,
                                    fontWeight: FontWeight.bold)),),

                        ],
                      ),
                    ),
                  ],
                ),
              )
          ),
        ),
      ),
    );

  }
  void updateSunCategory()
  {
    if(data.length>0 && currentsubcatIndex<data.length)
    {
      widget.controller.subCategory= data[currentsubcatIndex];
    }
    else
      {
        widget.controller.subCategory=null;
      }

  }
  void updateMainCategory()
  {
    if(widget.controller.orginalcategories.value!=null) {
      widget.controller.mainCategory =
      widget.controller.orginalcategories.value!.data[currentcatIndex];
      currentsubcatIndex = 0;
      if (data.length > 0) {
        widget.controller.subCategory = data[currentsubcatIndex];
      }
      else {
        widget.controller.subCategory = null;
      }
    }
  }
  List<SubCategory> data=[];
  List<SubCategory> getSubCategory(int parent)
  {
     data=[];
     if(widget.controller.subcategories.value!=null) {
       for (int i = 0; i <
           widget.controller.subcategories.value!.data.length; i++) {
         if (widget.controller.subcategories.value!.data[i].parent.id ==
             parent) {
           data.add(widget.controller.subcategories.value!.data[i]);
         }
       }
     }
     refreshSubCategory();
     updateMainCategory();
    return data;
  }
  refreshSubCategory()
  {
    setState(() {

    });
  }
}





