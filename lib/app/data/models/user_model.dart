class UserModel {
  late String uid;
  late String name;
  late String email;
  late int? createdAt;

  UserModel(
      {required this.uid,
      required this.name,
      required this.email,
      this.createdAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    email = json['email'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['email'] = this.email;
    data['created_at'] = DateTime.now().millisecondsSinceEpoch;
    data['taskCount'] = 0;
    return data;
  }
}
