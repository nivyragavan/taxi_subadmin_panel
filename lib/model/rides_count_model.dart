// To parse this JSON data, do
//
//     final ridesCountModel = ridesCountModelFromJson(jsonString);

import 'dart:convert';

RidesCountModel ridesCountModelFromJson(String str) => RidesCountModel.fromJson(json.decode(str));

String ridesCountModelToJson(RidesCountModel data) => json.encode(data.toJson());

class RidesCountModel {
  RidesCountModel({
    this.statusCode,
    this.code,
    this.message,
    this.body,
  });

  int? statusCode;
  int? code;
  String? message;
  Body? body;

  factory RidesCountModel.fromJson(Map<String, dynamic> json) => RidesCountModel(
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
    this.completedCount,
    this.scheduledCount,
    this.cancelledCount,
    this.bookedRides,
  });

  int? completedCount;
  int? scheduledCount;
  int? cancelledCount;
  int? bookedRides;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
    completedCount: json["completedCount"],
    scheduledCount: json["scheduledCount"],
    cancelledCount: json["cancelledCount"],
    bookedRides: json["bookedRides"],
  );

  Map<String, dynamic> toJson() => {
    "completedCount": completedCount,
    "scheduledCount": scheduledCount,
    "cancelledCount": cancelledCount,
    "bookedRides": bookedRides,
  };
}
