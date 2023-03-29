import 'dart:convert';

InProgressRidesModel inProgressRidesModelFromJson(String str) => InProgressRidesModel.fromJson(json.decode(str));

String inProgressRidesModelToJson(InProgressRidesModel data) => json.encode(data.toJson());

class InProgressRidesModel {
  InProgressRidesModel({
    this.statusCode,
    this.code,
    this.message,
    this.body,
  });

  int? statusCode;
  int? code;
  String? message;
  Body? body;

  factory InProgressRidesModel.fromJson(Map<String, dynamic> json) => InProgressRidesModel(
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
    this.progressRides,
    this.progressCount,
  });

  List<ProgressRide>? progressRides;
  int? progressCount;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
    progressRides: List<ProgressRide>.from(json["progressRides"].map((x) => ProgressRide.fromJson(x))),
    progressCount: json["progressCount"],
  );

  Map<String, dynamic> toJson() => {
    "progressRides": List<dynamic>.from(progressRides!.map((x) => x.toJson())),
    "progressCount": progressCount,
  };
}

class ProgressRide {
  ProgressRide({
    this.id,
    this.name,
    this.phonenumber,
    this.pickupLocation,
    this.pickupDate,
    this.dropLocation,
    this.dropDate,
    this.package,
    this.rentalhour,
    this.cab,
    this.subadminId,
    this.km,
    this.price,
    this.driverName,
    this.startOtp,
    this.endOtp,
    this.cancelledBy,
    this.cancelledReason,
    this.tripStatus,
    this.status,
  });

  int? id;
  String? name;
  String? phonenumber;
  String? pickupLocation;
  DateTime? pickupDate;
  String? dropLocation;
  DateTime? dropDate;
  String? package;
  int? rentalhour;
  String? cab;
  int? subadminId;
  dynamic km;
  dynamic price;
  dynamic driverName;
  dynamic startOtp;
  dynamic endOtp;
  dynamic cancelledBy;
  dynamic cancelledReason;
  String? tripStatus;
  int? status;

  factory ProgressRide.fromJson(Map<String, dynamic> json) => ProgressRide(
    id: json["id"],
    name: json["name"],
    phonenumber: json["phonenumber"],
    pickupLocation: json["pickup_location"],
    pickupDate: DateTime.parse(json["pickup_date"]),
    dropLocation: json["drop_location"],
    dropDate: DateTime.parse(json["drop_date"]),
    package: json["package"],
    rentalhour: json["rentalhour"],
    cab: json["cab"],
    subadminId: json["subadmin_id"],
    km: json["km"],
    price: json["price"],
    driverName: json["driver_name"],
    startOtp: json["start_otp"],
    endOtp: json["end_otp"],
    cancelledBy: json["cancelled_by"],
    cancelledReason: json["cancelled_reason"],
    tripStatus: json["trip_status"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phonenumber": phonenumber,
    "pickup_location": pickupLocation,
    "pickup_date": pickupDate!.toIso8601String(),
    "drop_location": dropLocation,
    "drop_date": dropDate!.toIso8601String(),
    "package": package,
    "rentalhour": rentalhour,
    "cab": cab,
    "subadmin_id": subadminId,
    "km": km,
    "price": price,
    "driver_name": driverName,
    "start_otp": startOtp,
    "end_otp": endOtp,
    "cancelled_by": cancelledBy,
    "cancelled_reason": cancelledReason,
    "trip_status": tripStatus,
    "status": status,
  };
}
