import 'dart:io';

import 'package:billing/modules/buy/buy_controller.dart';
import 'package:billing/modules/home/home.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../routes/app_pages.dart';
import '../../shared/constants/colors.dart';
import '../../shared/constants/common.dart';
import '../../shared/services/LocalString.dart';
import '../../shared/services/storage_service.dart';
import '../../shared/utils/common_widget.dart';
import '../../shared/utils/regex.dart';
import '../../shared/utils/size_config.dart';
import '../../shared/widgets/AppBars/auth_app_bar.dart';
import '../../shared/widgets/InputFieldPhone1.dart';
import '../../shared/widgets/custom_rounded.dart';
import '../../shared/widgets/AppBars/main_app_bar.dart';
import '../../globals.dart' as globals;
import '../../shared/widgets/input_field.dart';
import '../../shared/widgets/input_field_phone.dart';
import '../../shared/widgets/input_password.dart';
import '../home/Cards/PackageCard.dart';
import '../home/Cards/user_package_card.dart';
import '../solid_app_bar.dart';
import 'me_controller.dart';

class MeScreen extends StatefulWidget {
final  MeController controller;

   MeScreen({Key? key,required this.controller}) : super(key: key);

  @override
  State<MeScreen> createState() => _MeScreenState();
}

class _MeScreenState extends State<MeScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>true,
      child: Scaffold(
          backgroundColor: ColorConstants.greyBack,
          appBar: SolidAppBar(title: LocalString.getStringValue(context, 'my_account') ??
              "حسابي",),
          body:

           PackageHomePage(controller: widget.controller,)


      ),
    );
  }
}
class PackageHomePage extends StatefulWidget {
  MeController controller;
  PackageHomePage({ Key? key,required this.controller }) : super(key: key);

  @override
  State<PackageHomePage> createState() => _PackageHomePageState();
}

class _PackageHomePageState extends State<PackageHomePage> {
  @override
  initState() {
    super.initState();
     initData();
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

        child:
        Container(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0,right: 10,top: 10),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildMainDetails(context,widget.controller),
                CommonWidget.rowHeight(height: 20),


                Obx(
                      () =>buildListPackages(context),
                ),

                CommonWidget.rowHeight(height: 10),


              ],
            ),
          ),
        ),


      ),
    );
  }
  String? _pfp;
  final ImagePicker _picker = ImagePicker();
  bool phoneEnabled=false;
  bool  firstEnabled=false;
  bool secondEnabled=false;
  bool passwordEnabled=false;
  bool genderEnabled=false;
  bool typeEnabled=false;
   FocusNode? myFocusNode;
  void SetControls(bool isTrue,MeController controller)
  {
    setState(() {
      myFocusNode= FocusNode();
      myFocusNode!.requestFocus();
      phoneEnabled=isTrue;
      firstEnabled=isTrue;
      secondEnabled=isTrue;
      passwordEnabled=isTrue;
      genderEnabled=isTrue;
      typeEnabled=isTrue;
    });

  }
  Widget  buildMainDetails(BuildContext context,MeController controller)
  {

    String? selectedValue;
    String? selectedCompany;
    final List<String> genderItems = [
      LocalString.getStringValue(context, 'male') ?? "ذكر",
      LocalString.getStringValue(context, 'female') ?? "أنثى",
    ];
    final List<String> companyItems = [
      LocalString.getStringValue(context, 'individual') ?? "فرد",
      LocalString.getStringValue(context, 'company') ?? "شركة",
    ];
    return Column(
      children: <Widget>[

        GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
            child:  CircleAvatar(
              backgroundColor: Colors.grey[400],
              radius: 70,
              backgroundImage:
              _pfp != null ?
              Image.file(File(_pfp!)).image
                  :
              (globals.userInfo != null && globals.userInfo!.profile!=null && globals.userInfo!.profile!="")?

              Image.network( globals.userInfo!.profile!.toString()).image
                  :
              AssetImage("images/logo.jpg")

              ,
              child: Stack(children: [
                Align(
                    alignment: Alignment.bottomRight,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor:
                      ColorConstants.greenColor.withOpacity(0.7),
                      child:
                      Icon(Icons.edit, color: Colors.white),
                    )
                ),
              ]),
            )),
        CommonWidget.rowHeight(height: 20),
        Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              LocalString.getStringValue(context, 'your_data') ??
                  "بياناتك",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: CommonConstants.normalText,
                  color: ColorConstants.textColor,
                  fontFamily: CommonConstants.largeTextFont),
            )),
        CommonWidget.rowHeight(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              child: Expanded(
                // optional flex property if flex is 1 because the default flex is 1
                flex: 1,
                child: InputField(
                  myFocusNode: myFocusNode,
                  controller: widget.controller.FirstController,
                  keyboardType: TextInputType.text,
                  //labelText: 'Email address',
                  placeholder:
                  LocalString.getStringValue(context, 'first_name') ??
                      'الاسم الأول',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return LocalString.getStringValue(
                          context, 'first_required') ??
                          'الاسم حقل مطلوب';
                    }

                    return null;
                  },
                  icon: Icons.person,
                  enabled: firstEnabled,
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              // optional flex property if flex is 1 because the default flex is 1
              flex: 1,
              child: InputField(

                controller: widget.controller.LastController,
                keyboardType: TextInputType.text,
                //labelText: 'Email address',
                placeholder:
                LocalString.getStringValue(context, 'last_name') ??
                    'الاسم الأخير',
                validator: (value) {
                  if (value!.isEmpty) {
                    return LocalString.getStringValue(
                        context, 'last_required') ??
                        'الكنية حقل مطلوب';
                  }
                  return null;
                },
                /*
                suffiex:
                GestureDetector(
                  onTap: () {
                    setState(() {
                      secondEnabled=true;
                    });
                  },
                  child: Icon(
                    Icons.edit,
                    size: 20,
                    color:  ColorConstants.hintColor,
                  ),
                ),

                 */
                icon: Icons.person,
                enabled: secondEnabled,
              ),
            ),
          ],
        ),
        CommonWidget.rowHeight(height: 10.0),
        InputFieldPhone1(
          controller: widget.controller.PhoneController,
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
            if (value.length !=8) {
              return LocalString.getStringValue(context, 'phone_length_10') ??
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
          enabled: phoneEnabled,
          /*
          suffiex:
          GestureDetector(
            onTap: () {
              setState(() {
                phoneEnabled=true;
               print('ssf');
              });
            },
            child: Icon(
              Icons.edit,
              size: 20,
              color:  ColorConstants.hintColor,
            ),
          ),

           */
        ),
        CommonWidget.rowHeight(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              // optional flex property if flex is 1 because the default flex is 1
              flex: 1,
              child: Container(
                child: DropdownButtonFormField2(
                  decoration: InputDecoration(
                    enabled: genderEnabled,
                    filled: true,
                    fillColor:  ColorConstants.whiteBack,
                    focusColor: ColorConstants.whiteBack,
                    focusedBorder:   OutlineInputBorder(
                      // width: 0.0 produces a thin "hairline" border
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(color: Colors.grey, width: 0.0),
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
                    LocalString.getStringValue(context, 'select_gender') ??
                        'اختر الجنس',
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
                  items: genderItems
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
                          context, 'gender_required') ??
                          'اختر الجنس';
                    }
                  },
                  value: (globals.userInfo!=null)?(globals.userInfo!.gender=="0"||globals.userInfo!.gender=="female")?genderItems[1]:genderItems[0]:null,
                  onChanged:(genderEnabled==true)? (value) {
                    selectedValue = value.toString();
                    widget.controller.gender=selectedValue.toString();
                    int x=(genderItems.indexOf(value.toString()));
                    if(x==0)
                    {
                      widget.controller.gender="male";
                    }
                    else{
                      widget.controller.gender="female";
                    }
                  }:null,
                  onSaved: (value) {
                    selectedValue = value.toString();
                    widget.controller.gender=selectedValue.toString();
                    int x=(genderItems.indexOf(value.toString()));
                    if(x==0)
                    {
                      widget.controller.gender="male";
                    }
                    else{
                      widget.controller.gender="female";
                    }

                  },
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              // optional flex property if flex is 1 because the default flex is 1
              flex: 1,
              child: Container(
                child: DropdownButtonFormField2(
                  decoration: InputDecoration(
                    enabled: typeEnabled,
                    filled: true,
                    fillColor: ColorConstants.whiteBack,
                    focusColor: ColorConstants.whiteBack,
                    focusedBorder:   OutlineInputBorder(
                      // width: 0.0 produces a thin "hairline" border
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(color: Colors.grey, width: 0.0),
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
                    LocalString.getStringValue(context, 'select_company') ??
                        'اختر شركة',
                    style: TextStyle(fontSize: 14),
                  ),
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black45,
                  ),
                  iconSize: 30,
                  buttonHeight: 50,
                  value: (globals.userInfo!=null)?(globals.userInfo!.type=="user")?companyItems[0]:companyItems[1]:null,
                  buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                  dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: ColorConstants.white),
                  items: companyItems
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
                          context, 'select_company') ??
                          'فرد أو شركة';
                    }
                  },
                  onChanged:    (typeEnabled==true)?(value) {
                    selectedCompany = value.toString();
                    int x=(companyItems.indexOf(value.toString()));
                    if(x==0)
                    {
                      widget.controller.individual="user";
                    }
                    else{
                      widget.controller.individual="company";
                    }
                  }:null,
                  onSaved: (value) {
                    selectedCompany = value.toString();
                    int x=(companyItems.indexOf(value.toString()));
                    if(x==0)
                    {
                      widget.controller.individual="user";
                    }
                    else{
                      widget.controller.individual="company";
                    }
                  },
                ),
              ),
            ),
          ],
        ),
        CommonWidget.rowHeight(height: 10.0),
        InputPassword(
          controller: controller.PasswordController,
          keyboardType: TextInputType.text,
          // labelText: 'Password',
          placeholder:
          LocalString.getStringValue(context, 'enter_secret') ??
              'ادخل الرمز السري',
          password: true,

          validator: (value) {
            if (value!.isEmpty) {
              return null;
              return LocalString.getStringValue(
                  context, 'password_required') ??
                  'الرمز السري حق مطلوب';
            }
            if(value!=null &&(!(value!.isEmpty))) {
              if (!Regex.isPassword(value)) {
                return LocalString.getStringValue(context, 'password_error') ??
                    'خطأ في صيغة كلمة السر';
              }
            }

            return null;
          },
          icon: Icons.lock,
          enabled: passwordEnabled,
        ),
        CommonWidget.rowHeight(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                  alignment: Alignment.center,

                  child: CustomRounded(
                      text: LocalString.getStringValue(context, 'edit') ??
                          "تعديل",
                      textSize: CommonConstants.textButton,
                      color: ColorConstants.greenColor,
                      textColor: ColorConstants.white,
                      size: Size(SizeConfig().screenWidth * 1,
                          CommonConstants.roundedHeight),
                      pressed: () {
                        SetControls(true,controller);
                      })),
            ),
            SizedBox(width: 20,),
            Expanded(
              flex: 1,
              child: Container(
                  alignment: Alignment.center,

                  child: CustomRounded(
                      text: LocalString.getStringValue(context, 'save') ??
                          "حفظ",
                      textSize: CommonConstants.textButton,
                      textColor   : ColorConstants.greenColor,
                      color : ColorConstants.white,
                      size: Size(SizeConfig().screenWidth *1,
                          CommonConstants.roundedHeight),
                      pressed: () {
                        controller.updateProfile(context);
                      })),
            ),
          ],
        ),
        CommonWidget.rowHeight(height: 10),

      ],
    );
  }
  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            LocalString.getStringValue(context, 'choose_profile') ??
                "اختر صورة الملف الشخصي",
            style: TextStyle(
              fontSize: 20.0,
              color: ColorConstants.white,
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.camera, color: ColorConstants.white ,),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: Text( LocalString.getStringValue(context, 'open_camera') ??
                  "افتح الكاميرا",style:TextStyle(
                  fontSize: 20.0,
                  color: ColorConstants.white
              ) ,),
            ),
            FlatButton.icon(
              icon: Icon(Icons.image ,color: ColorConstants.white),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: Text( LocalString.getStringValue(context, 'open_gallery') ??
                  "من المعرض",style:TextStyle(
                  fontSize: 20.0,
                  color: ColorConstants.white
              ) ,),
            ),
          ])
        ],
      ),
    );
  }
  void takePhoto(ImageSource source) async {
    var pickedFile = await ImagePicker.pickImage(
      source: source,
    );
    setState(() {
      _pfp = pickedFile!.path;
      widget.controller.imageFile=File(_pfp!);
      Navigator.pop(context);
    });
  }
  Widget buildPopularWidgetHeader(BuildContext context) {
    return Row(children: [
      Padding(
        padding:  EdgeInsets.only(left: CommonConstants.paddingleft, right:  CommonConstants.paddingright),
        child: Text(
          LocalString.getStringValue(context, 'your_plan') ??
              "خطتك الإعلانية الحالية",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: CommonConstants.normalText,
              color: ColorConstants.textColor,
              fontWeight: FontWeight.bold,
              fontFamily: CommonConstants.largeTextFont),
        ),
      ),
      Spacer(),
      GestureDetector(
        onTap: () {
          Get.toNamed(Routes.buy);
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8),
          child: Text(
            LocalString.getStringValue(context, 'buy_package') ?? "شراء حزمة",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: CommonConstants.normalText,
                color: ColorConstants.textColorBlue,
                fontWeight: FontWeight.bold,
                fontFamily: CommonConstants.largeTextFont),
          ),
        ),
      )
    ]);
  }
  Widget buildBuyBundlesList(BuildContext context)
  {
    return Text('');
  }
  Widget buildListPackages(BuildContext context)
  {
    return (widget.controller!.packages!=null && widget.controller!.packages.value!=null)?
    Column(
      children: [
        buildPopularWidgetHeader(context),
        CommonWidget.rowHeight(height: 20),
        Container(
          child: Container(
            child: ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) => UserPackageCard(
                  package: widget.controller!.packages.value!,
                )),
          ),
        ),
      ],
    ):
    WaitWidget( SizeConfig().screenHeight * ColorConstants.sliderHeight);
  }
  Widget WaitWidget(double size)
  {
  return  Column(
      children: [
        buildPopularWidgetHeader(context),
        CommonWidget.rowHeight(height: 20),
        Container(
          child: Container(
            child: Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.only(left: 1, right: 1, top: 1),
              child: InkWell(
                onTap: () {
                  print ('Click Profile Pic');
                },
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
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 1, right: 1, top: 10,bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child:
                                  Text(
                                      LocalString.getStringValue(context, 'donthavepackages') ??
                                          "لا تملك حزم حالية",
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
          ),
        ),
      ],
    );
  }

  void initData() async{
   await StorageService.LoadUser();
    if(globals.userInfo!=null)
      {
        widget.controller.FirstController.text=globals.userInfo!.first_name;
        widget.controller.LastController.text=globals.userInfo!.second_name;
        widget.controller.PhoneController.text=globals.userInfo!.mobile;
        setState(() {

        });
      }
  //to do  widget.controller.FirstController.text=
  }
}
