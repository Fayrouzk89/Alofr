class ProductCategory {
  ProductCategory({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.image,
    required this.parentId,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String nameAr;
  late final String nameEn;
  late final String image;
  late final int parentId;
  late final String createdAt;
  late final String updatedAt;

  ProductCategory.fromJson(Map<String, dynamic> json){
    id = json['id'];
    nameAr = json['name_ar'].toString()??"";
    nameEn = json['name_en'].toString()??"";
    image = json['image'].toString()??"";
    parentId = json['parent_id'];
    createdAt = json['created_at'].toString()??"";
    updatedAt = json['updated_at'].toString()??"";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name_ar'] = nameAr;
    _data['name_en'] = nameEn;
    _data['image'] = image;
    _data['parent_id'] = parentId;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}