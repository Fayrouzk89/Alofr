library globals;

import 'package:billing/AppLocalizations.dart';
import 'package:billing/shared/constants/common.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'models/Product.dart';
import 'models/UserInfo.dart';
import 'models/responses/banners_response.dart';
import 'models/responses/categories_response.dart';
import 'models/responses/static_page_response.dart';
import 'models/responses/sub_catagories_response.dart';
import 'modules/home/home_controller.dart';
import 'shared/services/LocalString.dart';
String activateMsg="";
String generalTopic="general";
String fcm="";
String lang="ar";
String defaultLang="ar";
AppLocalizationsDelegate? specificLocalizationDelegate;
int my_account_operation=1;
int buy_operation=2;
int lang_operation=3;
int about_operation=4;
int term_operation=5;
int privacy_operation=6;
int exit_operation=7;
int close_app_operation=8;
UserInfo? userInfo;
LatLng? latLng;
List<SubCategory> orginalcategories = [];

int publicProducts=-1;
int myProducts=-2;
int usersProducts=-3;
int similarProducts=-4;
int companyProducts=-5;
String companyName="";
int priceAdd=100;
int maxAds=20;
double silver_expanded_height=70;
double silver_tool_height=70;
double imagePaddingTop=5;
double imageHeightAppBar=44;
double imageWidthAppBar=130;
StaticPageResponse? staticPageResponse;
String MapApiKey ="AIzaSyBpTrk1IxSz9ieJpAqUBCiVZa34cysSJhY";
Product? product;
BannersResponse? banners ;
String type_external_url="external_url";
String type_category="category";
String type_product="product";
String type_sub_category="sub_category";
String mainUrl='';
int phonelength=8;
HomeController? controller;
List getItems(BuildContext context)
{
 List<String> cityItems = [
    LocalString.getStringValue(context, 'AlAhmadi') ?? "AlAhmadi",
    LocalString.getStringValue(context, 'Hawalli') ?? "Hawalli",
    LocalString.getStringValue(context, 'AsSalimiyah') ?? "AsSalimiyah",
    LocalString.getStringValue(context, 'SabahasSalim') ?? "SabahasSalim",
    LocalString.getStringValue(context, 'AlFarwaniyah') ?? "AlFarwaniyah",
    LocalString.getStringValue(context, 'AlFahahil') ?? "AlFahahil",
    LocalString.getStringValue(context, 'KuwaitCity') ?? "KuwaitCity",
    LocalString.getStringValue(context, 'ArRumaythiyah') ?? "ArRumaythiyah",
    LocalString.getStringValue(context, 'ArRiqqah') ?? "ArRiqqah",
    LocalString.getStringValue(context, 'Salwa') ?? "Salwa",
    LocalString.getStringValue(context, 'AlManqaf') ?? "AlManqaf",
    LocalString.getStringValue(context, 'ArRabiyah') ?? "ArRabiyah",
    LocalString.getStringValue(context, 'Bayan') ?? "Bayan",
    LocalString.getStringValue(context, 'AlJahra') ?? "AlJahra",
    LocalString.getStringValue(context, 'AlFintas') ?? "AlFintas",
    LocalString.getStringValue(context, 'JanubasSurrah') ?? "JanubasSurrah",
    LocalString.getStringValue(context, 'AlMahbulah') ?? "AlMahbulah",
    LocalString.getStringValue(context, 'AdDasmah') ?? "AdDasmah",
    LocalString.getStringValue(context, 'AshShamiyah') ?? "AshShamiyah",
    LocalString.getStringValue(context, 'AlWafrah') ?? "AlWafrah",
    LocalString.getStringValue(context, 'AzZawr') ?? "AzZawr",
    LocalString.getStringValue(context, 'Al-Masayel') ?? "Al-Masayel",
    LocalString.getStringValue(context, 'AlFunaytis') ?? "AlFunaytis",
    LocalString.getStringValue(context, 'AbuAlHasaniya') ?? "AbuAlHasaniya",
    LocalString.getStringValue(context, 'AbuFatira') ?? "AbuFatira"
  ];
 return cityItems;

}
String getPrefixPhone(BuildContext context)
{
   return "05";
}
String getLogoImage()
{
   return(lang!=null && lang=="ar")?'images/title.png':'images/entitle.png';
}
Map<String, String> arabicCity = {"AlAhmadi":"الأحمدي",
"Hawalli":"حولي",
"AsSalimiyah":"السالمية",
"SabahasSalim":"صباح السالم",
"AlFarwaniyah":"الفراونية",
"AlFahahil":"الفحيحيل"	,
"KuwaitCity":"مدينة الكويت",
"ArRumaythiyah":"الرميثية",
"ArRiqqah":"الرقة",
"Salwa":"سلوى",
"AlManqaf":"المنقف",
"ArRabiyah":"الرابية",
"Bayan": "بيان",
"AlJahra":	"الجهراء",
"AlFintas":"الفنطاس",
"JanubasSurrah":"جنوب السرة",
"AlMahbulah":"المهبولة",
"AdDasmah":"الدسمة",
"AshShamiyah":"الشامية",
"AlWafrah":"الوفرة"	,
"AzZawr":"الزور",
"Al-Masayel":"المسايل",
"AlFunaytis":"الفنيطيس",
"AbuAlHasaniya":"أبو الحصانية",
"AbuFatira":"أبو فطيرة"};
Map<String, String> englishCity = {
   "AlAhmadi":"Al Ahmadi",
   "Hawalli":"Hawalli",
   "AsSalimiyah":"As Salimiyah",
   "SabahasSalim":"Sabah as Salim",
   "AlFarwaniyah":"Al Farwaniyah",
   "AlFahahil":"Al Fahahil"	,
   "KuwaitCity":"Kuwait City",
   "ArRumaythiyah":"Ar Rumaythiyah",
   "ArRiqqah":"Ar Riqqah",
   "Salwa":"Salwa",
   "AlManqaf":"Al Manqaf",
   "ArRabiyah":"Ar Rabiyah",
   "Bayan": "Bayan",
   "AlJahra":	"Al Jahra",
   "AlFintas":"Al Fintas",
   "JanubasSurrah":"Janub as Surrah",
   "AlMahbulah":"Al Mahbulah",
   "AdDasmah":"Ad Dasmah",
   "AshShamiyah":"Ash Shamiyah",
   "AlWafrah":"Al Wafrah"	,
   "AzZawr":"Az Zawr",
   "Al-Masayel":"Al Masayel",
   "AlFunaytis":"Al Funaytis",
   "AbuAlHasaniya":"Abu Al Hasaniya",
   "AbuFatira":"Abu Fatira"
};