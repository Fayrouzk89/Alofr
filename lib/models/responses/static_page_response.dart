class StaticPageResponse {
  bool? status;
  String? code;
  String? message;
  DataStaticPageResponse? data;

  StaticPageResponse({this.status, this.code, this.message, this.data});

  StaticPageResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new DataStaticPageResponse.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code.toString();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DataStaticPageResponse {
  int? id;
  String? sitename;
  String? email;
  String? mobile;
  String? android_link;
  String? ios_link;
  String? aboutApp;
  String? appTerms;
  String? appPrivacy;
  List<PaymentMethods>? paymentMethods;
  int? adv_price;
  String? company_image;
  DataStaticPageResponse(
      {this.id,
        this.sitename,
        this.email,
        this.aboutApp,
        this.appTerms,
        this.appPrivacy,
        this.paymentMethods,
        required this.adv_price,
        required this.company_image
      });

  DataStaticPageResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sitename = json['sitename'];
    email = json['email'];
    mobile = json['mobile'];
    ios_link = json['ios_link'];
    android_link = json['android_link'];
    aboutApp = json['about_app'];
    appTerms = json['app_terms'];
    appPrivacy = json['app_privacy'];
    if (json['payment_methods'] != null) {
      paymentMethods = <PaymentMethods>[];
      json['payment_methods'].forEach((v) {
        paymentMethods!.add(new PaymentMethods.fromJson(v));
      });
    }
    if( json['company_image']!=null)
      {
        company_image=json['company_image'];
      }
     else
       {
         company_image="";
       }
    adv_price =json['adv_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sitename'] = this.sitename.toString();
    data['email'] = this.email.toString();
    data['about_app'] = this.aboutApp.toString();
    data['app_terms'] = this.appTerms.toString();
    data['app_privacy'] = this.appPrivacy.toString();
    if (this.paymentMethods != null) {
      data['payment_methods'] =
          this.paymentMethods!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentMethods {
  int? paymentMethodId;
  String? paymentMethodAr;
  String? paymentMethodEn;
  String? paymentMethodCode;
  bool? isDirectPayment;
  double? serviceCharge;
  double? totalAmount;
  String? currencyIso;
  String? imageUrl;
  bool? isEmbeddedSupported;
  String? paymentCurrencyIso;

  PaymentMethods(
      {this.paymentMethodId,
        this.paymentMethodAr,
        this.paymentMethodEn,
        this.paymentMethodCode,
        this.isDirectPayment,
        this.serviceCharge,
        this.totalAmount,
        this.currencyIso,
        this.imageUrl,
        this.isEmbeddedSupported,
        this.paymentCurrencyIso});

  PaymentMethods.fromJson(Map<String, dynamic> json) {
    paymentMethodId = json['PaymentMethodId'];
    paymentMethodAr = json['PaymentMethodAr'].toString();
    paymentMethodEn = json['PaymentMethodEn'].toString();
    paymentMethodCode = json['PaymentMethodCode'].toString();
    isDirectPayment = json['IsDirectPayment'];
    serviceCharge = double.parse( json['ServiceCharge'].toString());
    totalAmount =  double.parse(json['TotalAmount'].toString());
    currencyIso = json['CurrencyIso'].toString();
    imageUrl = json['ImageUrl'];
    isEmbeddedSupported = json['IsEmbeddedSupported'];
    paymentCurrencyIso = json['PaymentCurrencyIso'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PaymentMethodId'] = this.paymentMethodId;
    data['PaymentMethodAr'] = this.paymentMethodAr;
    data['PaymentMethodEn'] = this.paymentMethodEn;
    data['PaymentMethodCode'] = this.paymentMethodCode;
    data['IsDirectPayment'] = this.isDirectPayment;
    data['ServiceCharge'] = this.serviceCharge;
    data['TotalAmount'] = this.totalAmount;
    data['CurrencyIso'] = this.currencyIso;
    data['ImageUrl'] = this.imageUrl;
    data['IsEmbeddedSupported'] = this.isEmbeddedSupported;
    data['PaymentCurrencyIso'] = this.paymentCurrencyIso;
    return data;
  }
}