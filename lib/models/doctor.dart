import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firstgp/globals/globalwidgets.dart';
import 'package:firstgp/models/patient.dart';
import 'package:firstgp/models/user.dart';
import 'package:flutter/material.dart';

import '../globals/globalVariables.dart';

class doctor extends user {
  late num ratingScore;
  late String cliniqueLocation;
  late String detailedLocation;
  late num price;
  late String cliniquePhone;
  late String visitaUrl;
  late List<patient> patients;
  List<dynamic> newsfeed = [];
  doctor.empty() : super.empty();

  doctor(
    String uid,
    String username,
    String email,
    String password,
    String Gender,
    num pr,
    String cliniquePh,
    String image,
  )   : price = pr,
        cliniquePhone = cliniquePh,
        super.withnames(uid, username, email, password, Gender, image);
  doctor.withscore(String uid, String username, String email, String password,
      String Gender, num pr, String cliniquePh, String image, num ratingsc)
      : price = pr,
        cliniquePhone = cliniquePh,
        ratingScore = ratingsc,
        super.withnames(uid, username, email, password, Gender, image);
  factory doctor.fromJson(dynamic json) {
    return doctor.withscore(
        json["_id"],
        json["username"],
        json["email"],
        json["password"],
        json["gender"],
        json["price"],
        json["clinicPhone"],
        json["image"],
        json["ratingScore"]);
  }
  Future<int?> register() async {
    final getScoreAndDocId = await dio.post(GlobalUrl + 'getscore',
        data: json
            .encode(<String, String>{"url": authData['Veseeta profile URL']!}));

    if (getScoreAndDocId.statusCode == 200) {
      print("rating score::: " + getScoreAndDocId.data.toString());
      ratingScore = double.parse(getScoreAndDocId.data['data'][0]);
      print("res" + ratingScore.toString());
      if (getScoreAndDocId.data['data'][1] != authData['Doctor Vezeeta id']) {
        showToast(false, 'incorrect doctor id! ');
        throw Exception('Doctor Vezeeta id is false! ');
      }
      //  return getScore.statusCode;
    } else {
      throw Exception('failed to get data from veseeta');
    }

    print("after condition");
    try {
      final response = await dio.post(GlobalUrl + "doctorRegister",
          data: json.encode(<String, dynamic>{
            "username": username.trim(),
            "email": email.trim(),
            "password": password.trim(),
            "gender": Gender,
            "ratingScore": ratingScore,
            // "visitaurl": visitaUrl,
            "clinicPhone": cliniquePhone,
            "price": price
          }));
      if (response.statusCode == 200) {
        uId = currentuser.uId = currentdoctor.uId = uId.trim();
        return response.statusCode;
      }
    } on DioError catch (e) {
      /* if (e.response!.statusCode == 404) {
        print(e.response!.statusCode);
      } else {
        print(e.message);
        // print(e.request);
      }
*/
      button_provider.togglesigninOrsignupProgressIndicator();
      print(e.response!.data['error'].toString());
      print("jjjjjkkk " + e.error.toString());
      if (e.response!.statusCode == 400) {
        showToast(false, e.response!.data['error'].toString());
      } else {
        showToast(false, 'check your internet connection and try again');
      }
      print('failed to sign in : $e');
      debugPrint(e.response!.toString());
      throw Exception("failed to register");
    }
  }
}
