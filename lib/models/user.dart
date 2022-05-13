import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:firstgp/globals/globalVariables.dart';
import 'package:flutter/material.dart';

enum gender { male, female }

class user {
  late String username, email, password;
  late String Gender;
  late String uId;
  late String image;
  late bool isEmailVerified;
  // int age;
  user.empty();
  user.inlogin(this.uId, this.username);
  user.withnames(
      this.uId, this.username, this.email, this.password, this.Gender);
  Dio dio = new Dio();

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["username"] = username;
    map["password"] = password;
    return map;
  }

  final usersUrl = 'http://192.168.1.60:6666/api/';
  factory user.fromJson(dynamic json) {
    debugPrint("heloooooo");
    debugPrint("44444444444" + json["_id"] + "     " + json["username"]);
    return user.inlogin(
      json["_id"] as String,
      json["username"] as String,
    );
  }
  Future<int?> login(String username, String password) async {
    debugPrint("******************************88");
    final response = await dio.post(usersUrl + 'login',
        //options: Options(headers: {"Content-Type": "application/json"}),
        data: json.encode(<String, String>{
          "email": username,
          "password": password,
        }));

    //currentuser.fromJson(response.data);
    if (response.statusCode == 200) {
      debugPrint("in login FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF");
      debugPrint("in login" + response.data["data"]["User"].toString());
      currentuser = user.fromJson(response.data["data"]["User"]);

      debugPrint("**********************88 in login");
      return response.statusCode;
    } else {
      throw Exception('failed to login');
    }
  }

  Future<int?> register() async {} //overrided by patient, doctor

}
