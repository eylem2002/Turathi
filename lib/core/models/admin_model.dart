
// Model class representing a Admin
class AdminModel {
  String? adminId;
  String? password;

  AdminModel({this.adminId, this.password});

//This is a factory Constructor to create AdminModel instance from JSON obj
  AdminModel.fromJson(Map<String, dynamic> json) {
    adminId = json['adminId'];
    password = json['password'];
  }
//convert the AdminModel instance to a JSON object
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adminId'] = this.adminId;
    data['password'] = this.password;
    return data;
  }
}
