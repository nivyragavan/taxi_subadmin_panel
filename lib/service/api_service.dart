import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../constant/api.dart';
import '../model/booked_rides_model.dart';
import '../model/cancelled_rides_model.dart';
import '../model/completed_rides_model.dart';
import '../model/in_progress_rides_model.dart';
import '../model/profile_view_model.dart';
import '../model/rides_count_model.dart';
import '../model/scheduled_rides_model.dart';


class ApiService{

  final box = GetStorage();

  Future subAdminLogin(String email, password) async {
    var client = http.Client();
    var completeUrl = ApiConstant.baseUrl + ApiConstant.subAdminLogin;
    var uri = Uri.parse(completeUrl);
    final response = await client.post(uri,body: {
      'email' : email,
      'password' : password
    });
    if(response.statusCode == 200){
      debugPrint(response.body.toString());
      var convertedDataToJson = jsonDecode(response.body);
      return convertedDataToJson;
    }
  }

  Future<ProfileViewModel?> profileView() async {
    var client = http.Client();
    var subadminId = box.read('subadminId');
    var params = {'Id' : '$subadminId'};
    var completeUrl = ApiConstant.baseUrl + ApiConstant.profileView;
    var uri = Uri.parse(completeUrl);
    var newUri = uri.replace(queryParameters: params);
    final response = await client.get(newUri);
    if(response.statusCode == 200){
      var json = response.body;
      return profileViewModelFromJson(json);
    }
    return null;
  }

  Future manualBookingAdd(String name, contact, pickup,pickupDate,drop,dropDate, cab, rentalhour, package) async {
    var client = http.Client();
    var subadminId = box.read("subadminId");
    var completeUrl = ApiConstant.baseUrl + ApiConstant.manualBookingAdd;
    var uri = Uri.parse(completeUrl);
    print(completeUrl);
    print(subadminId);
    final response = await client.post(uri,body: {
      'name' : name,
      'contact' : contact,
      'pickup' : pickup,
      'pickupDate' : pickupDate,
      'drop': drop,
      'dropDate' : dropDate,
      'subadminId' : '$subadminId',
      'cab' : cab,
      'rentalhour' : rentalhour,
      'package' : package
    });
    print(response.statusCode);
    if(response.statusCode == 200){
      debugPrint(response.body.toString());
      var convertedDataToJson = jsonDecode(response.body);
      return convertedDataToJson;
    }
  }


  Future<BookedRidesModel?> bookedRides() async{
    var client = http.Client();
    var subadminId = box.read("subadminId");
    var params = {'subadminId' : '$subadminId'};
    var completeUrl = ApiConstant.baseUrl + ApiConstant.bookedRides;
    var uri = Uri.parse(completeUrl);
    var newUri = uri.replace(queryParameters: params);
    final response = await client.get(newUri);
    print(subadminId);
    print(newUri);
    print(response.statusCode);
    if(response.statusCode == 200){
      print(response.body.toString());
      var json = response.body;
      return bookedRidesModelFromJson(json);
    }
    return null;
  }

  Future<InProgressRidesModel?> inProgressRides() async {
    var client = http.Client();
    var subadminId = box.read("subadminId");
    var params = {'subadminId' : '$subadminId'};
    var completeUrl = ApiConstant.baseUrl + ApiConstant.progressRides;
    var uri = Uri.parse(completeUrl);
    var newUri = uri.replace(queryParameters: params);
    final response = await client.get(newUri);
    print(subadminId);
    print(newUri);
    print(response.statusCode);
    if(response.statusCode == 200){
      print(response.body.toString());
      var json = response.body;
      return inProgressRidesModelFromJson(json);
    }
    return null;
  }

  Future<CompletedRidesModel?> completedRides() async {
    var client = http.Client();
    var subadminId = box.read("subadminId");
    var params = {'subadminId' : '$subadminId'};
    var completeUrl = ApiConstant.baseUrl + ApiConstant.completedRides;
    var uri = Uri.parse(completeUrl);
    var newUri = uri.replace(queryParameters: params);
    final response = await client.get(newUri);
    print(subadminId);
    print(newUri);
    print(response.statusCode);
    if(response.statusCode == 200){
      print(response.body.toString());
      var json = response.body;
      return completedRidesModelFromJson(json);
    }
    return null;
  }

  Future<CancelledRidesModel?> cancelledRides() async {
    var client = http.Client();
    var subadminId = box.read("subadminId");
    var params = {'subadminId' : '$subadminId'};
    var completeUrl = ApiConstant.baseUrl + ApiConstant.cancelledRides;
    var uri = Uri.parse(completeUrl);
    var newUri = uri.replace(queryParameters: params);
    final response = await client.get(newUri);
    print(subadminId);
    print(newUri);
    print(response.statusCode);
    if(response.statusCode == 200){
      print(response.body.toString());
      var json = response.body;
      return cancelledRidesModelFromJson(json);
    }
    return null;
  }

  Future<ScheduledRidesModel?> scheduledRides() async {
    var client = http.Client();
    var subadminId = box.read("subadminId");
    var params = {'subadminId' : '$subadminId'};
    var completeUrl = ApiConstant.baseUrl + ApiConstant.scheduledRides;
    var uri = Uri.parse(completeUrl);
    var newUri = uri.replace(queryParameters: params);
    final response = await client.get(newUri);
    print(subadminId);
    print(newUri);
    print(response.statusCode);
    if(response.statusCode == 200){
      print(response.body.toString());
      var json = response.body;
      return scheduledRidesModelFromJson(json);
    }
    return null;
  }

  Future<RidesCountModel?> ridesCount() async {
    var client = http.Client();
    var subadminId = box.read("subadminId");
    var params = {'subadminId' : '$subadminId'};
    var completeUrl = ApiConstant.baseUrl + ApiConstant.ridesCount;
    var uri = Uri.parse(completeUrl);
    var newUri = uri.replace(queryParameters: params);
    final response = await client.get(newUri);
    print(subadminId);
    print(newUri);
    print(response.statusCode);
    if(response.statusCode == 200){
      print(response.body.toString());
      var json = response.body;
      return ridesCountModelFromJson(json);
    }
    return null;
  }

}