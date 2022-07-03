import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:firstgp/globals/globalVariables.dart';
import 'package:flutter/material.dart';

import '../globals/globalFunctions.dart';
import '../globals/globalwidgets.dart';

enum gender { male, female }

class user {
  late String username, email, password;
  late String Gender;
  late String uId;
  late String role;
  String image =
      'https://iptc.org/wp-content/uploads/2018/05/avatar-anonymous-300x300.png';
  late bool isEmailVerified;
  // int age;
  user.empty();
  user.inlogin(this.uId, this.username, this.role, this.image);
  user.withnames(this.uId, this.username, this.email, this.password,
      this.Gender, this.image);
  Dio dio = new Dio();

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["username"] = username;
    map["password"] = password;
    return map;
  }

  factory user.fromJson(dynamic json) {
    debugPrint("heloooooo");
    debugPrint("44444444444" + json["_id"] + "     " + json["username"]);
    return user.inlogin(
        json["_id"] as String,
        json["username"] as String,
        json["itemtype"] as String,
        (json["image"] != null)
            ? json["image"] as String
            : 'https://iptc.org/wp-content/uploads/2018/05/avatar-anonymous-300x300.png');
  }
  Future<void> login(String username, String password) async {
    try {
      debugPrint("******************************88");
      final response = await dio.post(GlobalUrl + 'login',
          /*     options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status! <= 500;
            },
          ),*/
          data: json.encode(<String, String>{
            "email": username,
            "password": password,
          }));
      //  if (response.statusCode == 200) {
      debugPrint("in login FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF");
      debugPrint("in login" + response.data.toString());
      currentuser = user.fromJson(response.data["data"]["User"]);
      debugPrint(currentuser.uId + " 7777777777777777");
      uId = currentuser.uId;
      if (currentuser.role == 'doctor') {
        await getDoctor(uId);
        debugPrint("get doctor successfully " + currentdoctor.uId);
      } else {
        //to get info of current patient
        await getpatient(uId);
        await getinbody(uId);
        await getPatientDoctor(uId);
      }

      //debugPrint("**********************88 in login" + response.data);
      //  return response.data["error"];
      //}
    } on DioError catch (e) {
      /* if (e.response!.statusCode == 404) {
        print(e.response!.statusCode);
      } else {
        print(e.message);
        // print(e.request);
      }
*/
      button_provider.togglesigninOrsignupProgressIndicator();
      if (e.response!.statusCode == 404) {
        showToast(false, 'incorrect email or password');
      } else {
        showToast(false, 'check your internet connection and try again');
      }
      print('failed to sign in : $e');
      debugPrint(e.response!.statusCode.toString());
    }

    // print("shott");
    //showToast(false, "please check your internet connection");
    //throw Exception('failed to login');
  }

  Future<int?> register() async {} //overrided by patient, doctor

}
