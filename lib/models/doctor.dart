import 'dart:convert';

import 'package:firstgp/models/patient.dart';
import 'package:firstgp/models/user.dart';
import 'package:flutter/material.dart';

import '../globals/globalVariables.dart';

class doctor extends user {
  late double ratingScore;
  late String cliniqueLocation;
  late String detailedLocation;
  num price;
  String cliniquePhone;
  late String visitaUrl;
  late List<patient> patients;
  doctor(
      String uid,
      String username,
      String email,
      String password,
      String Gender,
      // String cliniqueLoc,
      num pr,
      //  String detailedLoc,
      String cliniquePh)
      :
        //: cliniqueLocation = cliniqueLoc,
        price = pr,
        //detailedLocation = detailedLoc,
        cliniquePhone = cliniquePh,
        super.withnames(uid, username, email, password, Gender);
  /*
 {
        "_id": "626c055c0e024a300b316d1e",
        "patients": [],
        "clinicPhone": "123456789",
        "price": 270,
        "ratingScore": 4.4,
        "email": "haww@",
        "username": "hwwaar",
        "password": "$2b$10$Jj8699qHHC71B8eQfkuOxeBZFpWseEy8ALKXTjrG6kH.omHDG6wX2",
        "gender": "female",
        "itemtype": "doctor",
        "__v": 0
    }
 
  */
  factory doctor.fromJson(dynamic json) {
    debugPrint("heloooooo");
    //debugPrint("44444444444" + json["_id"] + "     " + json["username"]);
    return doctor(json["id"], json["username"], json["email"], json["password"],
        json["gender"], json["price"], json["clinicPhone"]);
  }
  Future<int?> register() async {
    print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
    if (authData['visita url (optional)'] != '') {
      final getScore = await dio.post('http://192.168.56.1:6666/api/getscore',
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
    final response = await dio.post(usersUrl + "doctorRegister",
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
