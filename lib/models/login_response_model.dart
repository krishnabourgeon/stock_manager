class LoginResponseModel {
  bool? status;
  String? message;
  String? token;
  int? userid;
  LoginResponseModel({this.status, this.message, this.token,this.userid});
  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    token = json['token'];
    userid = json['user_id'];
  }
}
