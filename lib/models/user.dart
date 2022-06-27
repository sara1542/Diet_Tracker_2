import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:firstgp/globals/globalVariables.dart';
import 'package:firstgp/layout/social_app/cubit/cubit.dart';
import 'package:flutter/material.dart';

import '../globals/globalFunctions.dart';

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
  Future<int?> login(String username, String password) async {
    debugPrint("******************************88");
    final response = await dio.post(GlobalUrl + 'login',
        //options: Options(headers: {"Content-Type": "application/json"}),
        data: json.encode(<String, String>{
          "email": username,
          "password": password,
        }));
    if (response.statusCode == 200) {
      debugPrint("in login FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF");
      debugPrint("in login" + response.data.toString());
      currentuser = user.fromJson(response.data["data"]["User"]);
      debugPrint(currentuser.uId + " 7777777777777777");
      uId = currentuser.uId;
      if (currentuser.role == 'doctor') {
        getDoctor(uId);
        debugPrint("get doctor successfully");

      } else {
        //to get info of current patient
        getpatient(uId);
        getinbody(uId);
        getPatientDoctor(uId);
      }
      debugPrint("**********************88 in login");
      return response.statusCode;
    } else {
      throw Exception('failed to login');
    }
  }

  Future<int?> register() async {} //overrided by patient, doctor

}
