class GeneralResponse {
  GeneralResponse({
    required this.status,
    required this.code,
    required this.message,
  });
  late final bool status;
  late final String code;
  late final String message;

  GeneralResponse.fromJson(Map<String, dynamic> json){
    status = json['status'];
    code = json['code'].toString();
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['code'] = code;
    _data['message'] = message;
    return _data;
  }
}