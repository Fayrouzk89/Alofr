class CreateAccountResponse {
  CreateAccountResponse({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });
  late final bool status;
  late final String code;
  late final String message;
  late final String data;

  CreateAccountResponse.fromJson(Map<String, dynamic> json){
    status = json['status'];
    code = json['code'].toString()??"";
    message = json['message'].toString()??"";
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['code'] = code;
    _data['message'] = message;
    _data['data'] = data;
    return _data;
  }
}