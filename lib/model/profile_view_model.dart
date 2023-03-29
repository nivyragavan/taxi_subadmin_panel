import 'dart:convert';

ProfileViewModel profileViewModelFromJson(String str) => ProfileViewModel.fromJson(json.decode(str));

String profileViewModelToJson(ProfileViewModel data) => json.encode(data.toJson());

class ProfileViewModel {
  ProfileViewModel({
    this.statusCode,
    this.code,
    this.message,
    this.body,
  });

  int? statusCode;
  int? code;
  String? message;
  Body? body;

  factory ProfileViewModel.fromJson(Map<String, dynamic> json) => ProfileViewModel(
    statusCode: json["statusCode"],
    code: json["code"],
    message: json["message"],
    body: Body.fromJson(json["body"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "code": code,
    "message": message,
    "body": body!.toJson(),
  };
}

class Body {
  Body({
    this.subadminprofile,
  });

  List<Subadminprofile>? subadminprofile;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
    subadminprofile: List<Subadminprofile>.from(json["subadminprofile"].map((x) => Subadminprofile.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "subadminprofile": List<dynamic>.from(subadminprofile!.map((x) => x.toJson())),
  };
}

class Subadminprofile {
  Subadminprofile({
    this.id,
    this.name,
    this.email,
    this.phonenumber,
    this.password,
    this.passwordText,
    this.designation,
    this.image,
    this.status,
  });

  int? id;
  String? name;
  String? email;
  String? phonenumber;
  String? password;
  String? passwordText;
  String? designation;
  String? image;
  int? status;

  factory Subadminprofile.fromJson(Map<String, dynamic> json) => Subadminprofile(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phonenumber: json["phonenumber"],
    password: json["password"],
    passwordText: json["password_text"],
    designation: json["designation"],
    image: json["image"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phonenumber": phonenumber,
    "password": password,
    "password_text": passwordText,
    "designation": designation,
    "image": image,
    "status": status,
  };
}
