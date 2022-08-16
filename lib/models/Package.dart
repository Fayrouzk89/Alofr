class Package {
  Package({
    required this.id,
    required this.type,
    required this.nameAr,
    required this.nameEn,
    required this.months,
    required this.price,
    required this.numAdvs,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String type;
  late final String nameAr;
  late final String nameEn;
  late final int months;
  late final int price;
  late final int numAdvs;
  late final String createdAt;
  late final String updatedAt;

  Package.fromJson(Map<String, dynamic> json){
    id = json['id'];
    type = json['type']??"";
    nameAr = json['name_ar']??"";
    nameEn = json['name_en']??"";
    months = json['months']??0;
    price = json['price']??0;
    numAdvs = json['num_advs']??0;
    createdAt = json['created_at']??"";
    updatedAt = json['updated_at']??"";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['type'] = type;
    _data['name_ar'] = nameAr;
    _data['name_en'] = nameEn;
    _data['months'] = months;
    _data['price'] = price;
    _data['num_advs'] = numAdvs;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}