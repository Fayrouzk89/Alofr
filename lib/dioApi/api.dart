import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../globals.dart' as globals;
import '../models/responses/categories_response.dart';
import '../models/responses/sub_catagories_response.dart';
import '../shared/widgets/dialog_with_image.dart';
class Api {
  static const String code_activate="433";
  static const baseUrl = "https://alwafrah.aqdeveloper.tech/api/v1";
  static const banners = "/banners";
  static const company_banners = "/company-banners";
  static const company_image = "/company_image";
  static const categories = "/categories";
  static const categoriesproducts = "/products";
  static const subcategories = "/categories/sub/all";
  static const my_products="/my-products/";
  static const popular_products = "/popular-products";
  static const latest_products = "/latest-products";
  static const all_products = "/all-products";
  static const latest_searches = "/latest-searches";
  static const latest_views = "/latest-views";

  static const users = "/users";
  static const companies = "/companies";
  static const notifications = "/notifications";
  static const delete_product_image = "/delete-product-image";
  static const add_product_image = "/add-product-image";

  static const update_profile = "/update-profile";
  static const all_companies = "/companies";
  static const settings = "/settings";

  static const user_package = "/user-package";
  static const packages = "/packages";
  static const register = "/register";
  static const login = "/login";
  static const logout = "/logout";

  static const verify_account = "/verify-account";
  static const forget_password = "/forget-password";
  static const  restet_password = "/restet-password";
  static const  products = "/products";

  static const  choose_main_package = "/choose-main-package";
  static const  choose_extra_package = "/choose-extra-package";
  static const  purchase_advs = "/purchase-advs";

  static const baseUrlMovies = "https://api.themoviedb.org/3/";
  static String api_key =  "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvM3phcHAuY29tXC9hcGlcL3YxXC9sb2dpbiIsImlhdCI6MTY1Mjc4MzY5MywibmJmIjoxNjUyNzgzNjkzLCJqdGkiOiJ5dmtQMWh0TkpSa0JuOFBqIiwic3ViIjoxLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.NKG3OKHaoDsiQEVlR6HBow7bwCLRhfRUgAjk7kC8vuk";
 static String getSuffiex()
 {
  return "?lang="+globals.lang;
 }
  static String getBanners()
  {
   return baseUrl + banners+getSuffiex();
  }
  static String getCompanyBanners()
  {
    return baseUrl +company_banners +getSuffiex();
  }

  static String getCategories()
  {
    return baseUrl + categories+getSuffiex();
  }
  static String getSubCategories()
  {
    return baseUrl + subcategories+getSuffiex();
  }

  static String getPopular()
  {
    return baseUrl + popular_products+getSuffiex();
  }
  static String getLatestSearches()
  {
    return baseUrl + latest_searches+getSuffiex();
  }
  static String getlatest_views()
  {
    return baseUrl + latest_views+getSuffiex();
  }

  static String getNotificationList()
  {
    return baseUrl + notifications+getSuffiex();
  }

  static String getLatestProducts()
  {
    return baseUrl + latest_products+getSuffiex();
  }
  static String getProductsPage(int page)
  {
    return baseUrl + all_products+ getSuffiex()+"&page="+page.toString();
  }
  static String getProductsByFilter(int page,String prefix,SubCategory? category,bool isNear,bool isHigh,String lat,String long)
  {
    if(category!=null)
      {
        return baseUrl + all_products+ getSuffiex()+"&title="+prefix.toString()+"&category_id="+category.id.toString()+"&page="+page.toString()+getSuffiexSearch(isNear, isHigh, lat, long);
      }
    else
    return baseUrl + all_products+ getSuffiex()+"&title="+prefix.toString()+"&page="+page.toString()+getSuffiexSearch(isNear, isHigh, lat, long);
  }
 static String getSuffiexSearch(bool isNear,bool isHigh,String lat,String long)
  {
    String suffiex="";
    if(isNear)
      {
        suffiex="&latitude="+lat+"&longitude="+long;
      }
     else if(isHigh)
       {
         suffiex="&filter=desc";
       }
    else if(!isHigh)
    {
      suffiex="&filter=asc";
    }
    return suffiex;
  }
  static String getProductsByCategoryPage(int page,int categoryId)
  {
    return baseUrl + categories+"/"+categoryId.toString()+categoriesproducts+ getSuffiex()+"&page="+page.toString();
  }
  static String getProductsByUser(int page,int categoryId)
  {
    return baseUrl + my_products+getSuffiex()+"&page="+page.toString();
  }
  static String getProductsByUserId(int page,int userId)
  {
    return baseUrl + users+"/"+userId.toString()+products+ getSuffiex()+"&page="+page.toString();
  }
  static String getProductsByCompanyId(int page,int companyId)
  {
    return baseUrl + companies+"/"+companyId.toString()+products+ getSuffiex()+"&page="+page.toString();
  }
  static String get_product_delete(int productId)
  {
    return baseUrl + products+"/"+productId.toString()+"/delete"+ getSuffiex();
  }
  static String getEditProduct(int productId)
  {
    return baseUrl + products+"/"+productId.toString()+ getSuffiex();
  }
  static String deleteProductImage(int mageId)
  {
    return baseUrl + delete_product_image+"/"+mageId.toString()+ getSuffiex();
  }
  static String upload_product_images(int productId)
  {
    return baseUrl + add_product_image+"/"+productId.toString()+ getSuffiex();
  }

  static String getCompanyPage(int page)
  {
    return baseUrl + all_companies+ getSuffiex()+"&page="+page.toString();
  }
  static String getSubCatByParentId(int mainId)
  {
    return baseUrl + categories+"/"+mainId.toString()+"/sub"+getSuffiex();
  }
  static String getProductDetails(int productId)
  {
    return baseUrl + products+"/"+productId.toString()+getSuffiex();
  }

  static String getRegister()
  {
    return baseUrl + register+getSuffiex();
  }
  static String getLogin()
  {
    return baseUrl + login+getSuffiex();
  }
  static String getPackages()
  {
    return baseUrl + packages+getSuffiex() +"&type=main";
  }
  static String getExtraPackages()
  {
    return baseUrl + packages+getSuffiex() +"&type=extra";
  }
  static String postExtraPackages()
  {
    return baseUrl + choose_extra_package+getSuffiex();
  }
  static String postPackages()
  {
    return baseUrl + choose_main_package+getSuffiex();
  }
  static String post_purchase_advs()
  {
    return baseUrl +  purchase_advs+getSuffiex();
  }

  static String getUserPackages()
  {
    return baseUrl + user_package+getSuffiex();
  }
  static String getSettings()
  {
    return baseUrl + settings+getSuffiex();
  }

  static String getVerify()
  {
    return baseUrl + verify_account+getSuffiex();
  }
  static String getforget_password()
  {
    return baseUrl + forget_password+getSuffiex();
  }
  static String getrestet_password()
  {
    return baseUrl + restet_password+getSuffiex();
  }
  static String getlogout()
  {
    return baseUrl + logout+getSuffiex();
  }
  static String getupdateUser()
  {
    return baseUrl + update_profile+getSuffiex();
  }
  static String getaddProduct()
  {
    return baseUrl + products+getSuffiex();
  }

  static void setLoading(String message) {

     // ..displayDuration = const Duration(milliseconds: 5000)
    EasyLoading.instance  ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
     // ..progressColor = Colors.yellow
     // ..backgroundColor = Colors.green
     // ..indicatorColor = Colors.yellow
      //..textColor = Co.yellow
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false
     ;
    EasyLoading.show(status: message);
  }
  static void hideLoading() {
   try {
     EasyLoading.dismiss();
   }
   catch(e)
    {

    }
  }


}