class NotificationModel {
  late int id;
  late String title;
  late String description;
  late String image;
  late  int status;
  late  String createdAt;
  late String updatedAt;

  NotificationModel(
      {
       required this.id,
        required this.title,
        required this.description,
        required this.image,
        required this.status,
        required this.createdAt,
        required this.updatedAt});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['body'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['image'] = this.image;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}