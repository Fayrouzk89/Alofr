class BuyResponse {
  bool? status;
  String? code;
  String? message;
  String? data;
  String? payUrl;

  BuyResponse({this.status, this.code, this.message, this.data, this.payUrl});

  BuyResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    if(json['data']!=null) {
      data = json['data'];
      payUrl = json['pay-url'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    data['message'] = this.message;
    data['data'] = this.data;
    data['pay-url'] = this.payUrl;
    return data;
  }
}