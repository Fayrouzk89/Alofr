import 'dart:math';

import 'package:billing/dioApi/api.dart';
import 'package:billing/models/ProductCateogry.dart';
import 'package:billing/models/ProductUser.dart';
import 'package:billing/models/responses/banners_response.dart';
import 'package:billing/models/responses/categories_response.dart';
import 'package:billing/models/responses/products_response.dart';
import 'package:billing/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/api_repository.dart';
import '../../dioApi/api_repository.dart';
import '../../dioApi/log_util.dart';
import '../../models/Images.dart';
import '../../models/Product.dart';
import '../../models/responses/add_product_response.dart';
import '../../models/responses/static_page_response.dart';
import '../../models/responses/sub_catagories_response.dart';
import '../../models/responses/users_response.dart';
import '../../shared/constants/storage.dart';
import '../../shared/services/LocalString.dart';
import '../../shared/services/MessageHelper.dart';
import '../../shared/services/storage_service.dart';
import '../../shared/utils/focus.dart';
import '../../shared/utils/navigator_helper.dart';
import '../../shared/widgets/dialog_with_image.dart';
import '../my_ads/my_ads_screen.dart';
import 'tabs/new_adds.dart';
import 'tabs/tabs.dart';
import '../../globals.dart' as globals;
class HomeController extends GetxController {
   GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
   GlobalKey<ScaffoldState> scaffoldKeyAdd = new GlobalKey<ScaffoldState>();
  final ApiRepository apiRepository;
  HomeController({required this.apiRepository});

  var currentTab = MainTabs.home.obs;
  var users = Rxn<UsersResponse>();
  var banners = Rxn<BannersResponse>();
  var categories = Rxn<CategoryMainResponse>();
  var orginalcategories = Rxn<CategoryMainResponse>();
  var subcategories = Rxn<SubCategoriesresponse>();
  var popular = Rxn<ProductResponse>();
  var latestProducts = Rxn<ProductResponse>();

  var user = Rxn<Datum>();

  late MainTab mainTab;
  late NewAdds newAdds;
  late MyAdsScreen resourceTab;



  @override
  void onInit() async {
    super.onInit();
    globals.controller=this;
    mainTab = MainTab(controller: this,);


    //newAdds = NewAdds();
    newAdds = NewAdds(false,null,this);
    resourceTab = MyAdsScreen();
    callMethods();

    //loadBanners();

  }
  void callMethods()async
  {
    Api.setLoading("Please wait");
    await getStaticPageResponse();
    await StorageService.LoadUser();
    await getBanners();
    await getCategories();
    await getSubCategories();
    await getPopular();
    await getLatestProducts();

    Api.hideLoading();
  }

  Future<bool> loadBanners() async {

    var _banners = await apiRepository.getBanners();
    if (_banners!.data!.length > 0) {
      banners.value = _banners;
      banners.refresh();
      return true;
    }
    return false;
    //getProducts();
  }
  //Home Page
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  void setLoading(bool show) {
    _isLoading.value = show;
  }
   //var data = Rxn<StaticPageResponse>();

   Future<StaticPageResponse?> getStaticPageResponse() async {
      if(globals.staticPageResponse==null) {
        Api.setLoading('loading');
        try {
          final result = await ApiRepo().getSettings();
          Api.hideLoading();
          if (result != null) {
            if (result != null) {
              globals.staticPageResponse = result;
            } else {
              Log.loga(title, "getPackages:: e >>>>> ");
            }
          }
          else {
            return null;
          }
        } catch (e) {
          Log.loga(title, "getPackages:: e >>>>> $e");
          Api.hideLoading();
          return null;
        }
      }
   }

   Future<bool> getBanners() async {
    setLoading(true);
    try {
      final result = await ApiRepo().getBanners();
      setLoading(false);
      if (result != null) {
        if (result!=null) {
          banners.value = result;
          globals.banners=result;
          banners.refresh();
          return true;
        } else {
          Log.loga(title, "getBanners:: e >>>>> $e");
          return false;
        }
      }
      return false;
    } catch (e) {
      Log.loga(title, "getBanners:: e >>>>> $e");
      setLoading(false);
      return false;
    }
  }
  Future<bool> getCategories() async {
    setLoading(true);
    try {
      final result = await ApiRepo().getCategories();
      setLoading(false);
      if (result != null) {
        if (result!=null) {
          categories.value = result;
          if(categories.value!.data!=null)
            {
              if(globals.lang=="ar")
                {
                  globals.companyName="الشركات";
                }
               else
                 {
                   globals.companyName="Companies";
                 }
              String name =globals.companyName;
              Category category = Category(id:-1, name: name, image: "");
              categories.value!.data.insert(0, category);
              List<Category> data = [];
              for(int i =1;i<categories.value!.data.length;i++)
                {
                  data.add(categories.value!.data[i]);
                }
              orginalcategories.value =CategoryMainResponse(message: 'ss',data: data,code: '1s',status: true);
              orginalcategories.refresh();
            }
          categories.refresh();
          return true;
        } else {
          Log.loga(title, "getCategories:: e >>>>> $e");
          return false;
        }

      }
      return false;
    } catch (e) {
      Log.loga(title, "getCategories:: e >>>>> $e");
      setLoading(false);
      return false;
    }
  }
  Future<bool> getSubCategories() async {
    Api.setLoading("Please wait");
    setLoading(true);
    try {
      Api.hideLoading();
      final result = await ApiRepo().getSubCategories();
      setLoading(false);
      if (result != null) {
        if (result!=null) {
          subcategories.value = result;
          globals.orginalcategories=subcategories.value!.data;
          subcategories.refresh();
          return true;
        } else {
          Log.loga(title, "get sub Categories:: e >>>>> $e");
          return false;
        }

      }
      return false;
    } catch (e) {
      Api.hideLoading();
      Log.loga(title, "get sub Categories:: e >>>>> $e");
      setLoading(false);
      return false;
    }
  }

  Future<bool> getPopular() async {
    setLoading(true);
    try {
      final result = await ApiRepo().getPopular();
      setLoading(false);
      if (result != null) {
        if (result!=null) {
          popular.value = result;
          popular.refresh();
          return true;
        } else {
          Log.loga(title, "getPopular:: e >>>>> $e");
          return false;
        }
      }
      return false;
    } catch (e) {
      Log.loga(title, "getPopular:: e >>>>> $e");
      setLoading(false);
      return false;
    }
  }
  Future<bool> getLatestProducts() async {
    setLoading(true);
    try {
      final result = await ApiRepo().getLatestProducts();
      setLoading(false);
      if (result != null) {
        if (result!=null) {
          latestProducts.value = result;
          latestProducts.refresh();
          return true;
        } else {
          Log.loga(title, "getLatestProducts:: e >>>>> $e");
          return false;
        }
      }
      return false;
    } catch (e) {
      Log.loga(title, "getLatestProducts:: e >>>>> $e");
      setLoading(false);
      return false;
    }
  }




  Future<void> loadUsers() async {
    var _users = await apiRepository.getUsers();
    if (_users!.data!.length > 0) {
      users.value = _users;
      users.refresh();
      _saveUserInfo(_users);
    }
  }
  Future<bool> logout() async {
    setLoading(true);
    try {
      final result = await ApiRepo().logOut();
      setLoading(false);
      if (result != null) {
        if (result!=null) {
          return true;
        } else {
          Log.loga(title, "getBanners:: e >>>>> $e");
          return false;
        }
      }
      return false;
    } catch (e) {
      Log.loga(title, "getBanners:: e >>>>> $e");
      setLoading(false);
      return false;
    }
  }
  void signout() {
    var prefs = Get.find<SharedPreferences>();
    prefs.clear();

    // Get.back();
    NavigatorHelper.popLastScreens(popCount: 2);
  }

  void _saveUserInfo(UsersResponse users) {
    var random = new Random();
    var index = random.nextInt(users.data!.length);
    user.value = users.data![index];
    var prefs = Get.find<SharedPreferences>();
    prefs.setString(StorageConstants.userInfo, users.data![index].toRawJson());

    // var userInfo = prefs.getString(StorageConstants.userInfo);
    // var userInfoObj = Datum.fromRawJson(xx!);
    // print(userInfoObj);
  }
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
   // scaffoldKey = new GlobalKey<ScaffoldState>();

  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();

  }
  void switchTab(index) {
    var tab = _getCurrentTab(index);
   // scaffoldKey = new GlobalKey<ScaffoldState>();
    currentTab.value = tab;

    if(index==1)
      {
       // if(MessageHelper.isLoggedIn())
       // newAddFormKey = GlobalKey<FormState>();
          titleTextController= TextEditingController();
          descriptionController= TextEditingController();
          priceController= TextEditingController();
          phoneController= TextEditingController();
          city="";
          mainCategory=null;
          subCategory=null;
      }
  }

  int getCurrentIndex(MainTabs tab) {
    switch (tab) {
      case MainTabs.home:
        return 0;
      case MainTabs.newAdds:
        return 1;
      case MainTabs.resource:
        return 2;
      default:
        return 0;
    }
  }

  MainTabs _getCurrentTab(int index) {
    switch (index) {
      case 0:
        return MainTabs.home;
      case 1:
        return MainTabs.newAdds;
      case 2:
        return MainTabs.resource;
      default:
        return MainTabs.home;
    }
  }
  final GlobalKey<FormState> newAddFormKey = GlobalKey<FormState>();
  var titleTextController = TextEditingController();
   var  descriptionController = TextEditingController();
   var phoneController = TextEditingController();
   var  priceController = TextEditingController();
  Category? mainCategory;
  SubCategory? subCategory;
  String? city="";
  LatLng? latLng;
  List<Asset> resultList = [];
  void adNew(BuildContext context,Product? product,bool isEdit) async {
    AppFocus.unfocus(context);
    if (newAddFormKey.currentState!.validate()) {
      if(resultList.length>8)
        {

          MessageHelper.showMessage(context,LocalString.getStringValue(
              context, 'cant_upload') ??
              'لا يمكن رفع أكثر من 8 صور');
        }
      else {
        Product info = Product(id: 0,
            title: titleTextController.text.toString(),
            desctiption: descriptionController.text.toString(),
            price: priceController.text.toString(),
            category: ProductCategory(id: 0,
                createdAt: '',
                image: '',
                nameAr: '',
                nameEn: '',
                parentId: 0,
                updatedAt: ''),
            city: city!,
            latitude:(latLng!=null)? latLng!.latitude.toString():"",
            longitude:(latLng!=null)? latLng!.longitude.toString():"",
            mobile: phoneController.text.toString(),
            images: [],
            status: "",
            views: 0,
            createdAt: "",
            user: ProductUser(id: 0,
                gender: '',
                lastName: '',
                photoProfile: '',
                numAdvs: 0,
                firstName: '',
                mobile: '',
                package: null,
                fcmToken: '',
                type: ''));
        info.resultList = resultList;
        info.categorymainId = mainCategory!.id;
        info.subcategoryId = subCategory!.id;
        if (isEdit) {
          int id = product!.id;
          editProduct(context, info, id);
        }
        else {
          addProduct(context, info);
        }
      }
    }
  }
  void deleteProductImage(BuildContext context,Images imageId,Product? product) async {
    AppFocus.unfocus(context);
    Api.setLoading(LocalString.getStringValue(context, 'pleaseWait') ??
        'يرجى الانتظار');
    try {
      final result = await ApiRepo().deleteProductImage(imageId,product);
      Api.hideLoading();
      if (result != null) {
        if (result!=null) {

         if(result.status)
           {
             MessageHelper.showMessage(context,LocalString.getStringValue(
                 context, 'add_in_review') ??
                 'إعلانك قيد المراجعة لن نتأخر عليك');
             switchTab(0);
             Get.toNamed(Routes.HOME);
           }
        } else {

        }
      }
      else
      {
        return null;
      }
    } catch (e) {
      Log.loga(title, "RegisterUser:: e >>>>> $e");
      Api.hideLoading();

      return null;
    }
  }

  Future<AddProductResponse?> editProduct(BuildContext context,Product info,int id) async {
    Api.setLoading(LocalString.getStringValue(context, 'pleaseWait') ??
        'يرجى الانتظار');
    try {
      final result = await ApiRepo().editProduct(info,id);
      Api.hideLoading();
      if (result != null) {
        if (result!=null) {
          processEditResult(result, context,info,true);
          return result;
        } else {
          processUpdateResult(result, context,info,true);
        }
      }
      else
      {
        return null;
      }
    } catch (e) {
      Log.loga(title, "RegisterUser:: e >>>>> $e");
      Api.hideLoading();
      processUpdateResult(null, context,info,true);
      return null;
    }
  }
  Future<AddProductResponse?> addProduct(BuildContext context,Product info) async {
    Api.setLoading(LocalString.getStringValue(context, 'pleaseWait') ??
        'يرجى الانتظار');
    try {
      final result = await ApiRepo().addProduct(info);
      Api.hideLoading();
      if (result != null) {
        if (result!=null) {
          processUpdateResult(result, context,info,false);
          return result;
        } else {
          processUpdateResult(result, context,info,false);
        }
      }
      else
      {
        return null;
      }
    } catch (e) {
      Log.loga(title, "RegisterUser:: e >>>>> $e");
      Api.hideLoading();
      processUpdateResult(null, context,info,false);
      return null;
    }
  }
  void processUpdateResult(AddProductResponse? response,BuildContext context,Product userInfo,bool isEdit)
  {
    if(response!=null)
    {
      if(response.status)
      {
       displayshowDialog( context,LocalString.getStringValue(
            context, 'add_in_review') ??
            'إعلانك قيد المراجعة لن نتأخر عليك',
            'images/review.png',
            LocalString.getStringValue(
            context, 'ok_done') ??
                  'حسناً');

      }
      else
      {
        processFailLogin(response,context,userInfo);
      }
    }
    else
    {
      MessageHelper.showMessage(context,LocalString.getStringValue(
          context, 'time_out') ??
          'تايم اوت');
    }
  }
  static void displayshowDialog(BuildContext context,String title,String imagePath,String confirmText) {
    BuildContext dialogContext;
    try {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            dialogContext = context;
            return DialogWithImage(text: title, imagePath: imagePath, confirmText: confirmText,);
          });

    }
    catch(e)
    {

    }
  }
  void processEditResult(AddProductResponse? response,BuildContext context,Product userInfo,bool isEdit)
  {
    if(response!=null)
    {
      if(response.status)
      {
        MessageHelper.showMessage(context,LocalString.getStringValue(
            context, 'add_in_review') ??
            'إعلانك قيد المراجعة لن نتأخر عليك');
           switchTab(0);
           Get.offAndToNamed(Routes.HOME);
          // switchTab(0);
      }
      else
      {
        processFailLogin(response,context,userInfo);
      }
    }
    else
    {
      MessageHelper.showMessage(context,LocalString.getStringValue(
          context, 'time_out') ??
          'تايم اوت');
    }
  }

  void processFailLogin(AddProductResponse response,BuildContext context,Product userInfo)
  {
    if(response.message!=null)
    {
        MessageHelper.showMessage(context,response.message);
    }
    else
    {
      MessageHelper.showMessage(context,LocalString.getStringValue(
          context, 'error_add_product') ??
          'خطأ في إضافة المنتج  يرجى التحقق من المعلومات');
    }
  }

  Future uploadImageToServer(BuildContext context) async {
   /*
    try{
      var uri = Uri.parse('http://18.224.86.8:4000/api/v1/posts/add');
      http.MultipartRequest request = new http.MultipartRequest('POST', uri);

      request.fields['userid'] = '1';
      request.fields['food_name'] = 'piza';
      request.fields['category'] = 'piza';
      request.fields['serving_no'] = '3';
      request.fields['post_type'] = 'Global';
      request.fields['cooking_date'] = '2020-12-09';
      request.fields['exchange_for'] = 'yes';
      request.fields['spice_level'] = '2';
      request.fields['private_address'] ='yes';
      request.fields['address'] = 'nothing';
      request.fields['city'] = 'Peshawar';
      request.fields['state'] = 'KP';
      request.fields['zipcode'] = '2500';
      request.fields['allergies'] = 'No';
      request.fields['diet_specific'] = 'egg';
      request.fields['include_ingredients'] = 'egg, butter';
      request.fields['exclude_ingredients'] = 'egg butter';
      request.fields['details'] = 'nothing';

      List<http.MultipartFile> newList = new List<http.MultipartFile>();

      for (int i = 0; i < imagesList.length; i++) {
        var path = await FlutterAbsolutePath.getAbsolutePath(imagesList[i].identifier);
        File imageFile =  File(path);

        var stream = new http.ByteStream(imageFile.openRead());
        var length = await imageFile.length();

        var multipartFile = new http.MultipartFile("pictures", stream, length,
            filename: basename(imageFile.path));
        newList.add(multipartFile);
      }



      request.files.addAll(newList);
      var response = await request.send();
      print(response.toString()) ;

      response.stream.transform(utf8.decoder).listen((value) {
        print('value') ;
        print(value);
      });

      if (response.statusCode == 200) {
        setState(() {
          showSpinner = false ;
        });

        print('uploaded');


      } else {
        setState(() {
          showSpinner = false ;
        });
        print('failed');

      }

    }catch(e){
      setState(() {
        showSpinner = false ;
      });
      print(e.toString()) ;

    }



    */
  }
}
