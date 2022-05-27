import 'dart:convert';

import 'package:firstgp/models/patient.dart';
import 'package:firstgp/models/user.dart';
import 'package:flutter/material.dart';

import '../globals/globalVariables.dart';

class doctor extends user {
  late double ratingScore;
  late String cliniqueLocation;
  late String detailedLocation;
  late num price;
  late String cliniquePhone;
  late String visitaUrl;
  late List<patient> patients;

  doctor.empty() : super.empty();
  doctor(
      String uid,
      String username,
      String email,
      String password,
      String Gender,
      // String cliniqueLoc,
      num pr,
      //  String detailedLoc,
      String cliniquePh,
  String image)
      :
        //: cliniqueLocation = cliniqueLoc,
        price = pr,
        //detailedLocation = detailedLoc,
        cliniquePhone = cliniquePh,
        super.withnames(uid, username, email, password, Gender,image);

  factory doctor.fromJson(dynamic json) {
    return doctor(json["id"], json["username"], json["email"], json["password"],
        json["gender"], json["price"], json["clinicPhone"], json["image"]);
  }
  Future<int?> register() async {
    if (authData['visita url (optional)'] != '') {
      final getScore = await dio.post(GlobalUrl+'getscore',
          data: json.encode(
              <String, String>{"url": authData['visita url (optional)']!}));
      if (getScore.statusCode == 200) {
        print("rating score::: " + getScore.data.toString());
        ratingScore = double.parse(getScore.data['score']);
        //  return getScore.statusCode;
      } else {
        throw Exception('failed to register');
      }
    }
    print("after condition");
    final response = await dio.post(GlobalUrl + "doctorRegister",
        data: json.encode(<String, dynamic>{
          "username": username.trim(),
          "email": email.trim(),
          "password": password.trim(),
          "gender": Gender,
          "ratingScore":
              (authData['visita url (optional)'] != '') ? ratingScore : 0,
          // "visitaurl": visitaUrl,
          "clinicPhone": cliniquePhone,
          "price": price
        }));
    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      throw Exception('failed to register');
    }
  }
}
