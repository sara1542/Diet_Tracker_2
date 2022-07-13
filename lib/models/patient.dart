import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:firstgp/globals/globalVariables.dart';
import 'package:firstgp/globals/globalFunctions.dart';

import '../globals/globalwidgets.dart';
import 'diet.dart';
import 'doctor.dart';
import 'inbody.dart';
import 'user.dart';

class patient extends user {
  late inbody Inbody;
  late doctor? Doctor;
  late diet Diet;
  late int Age;
  late String Case;

  patient.empty() : super.empty();

  patient(String uId, String username, String email, String password,
      String Gender, int age, String c, String image)
      : Age = age,
        Case = c,
        super.withnames(uId, username, email, password, Gender, image);

  factory patient.fromJson(dynamic json) {
    return patient(
        json["_id"],
        json["username"],
        json["email"],
        json["password"],
        json["gender"],
        json["age"],
        json["case"],
        json["image"]);
  }

  @override
  Future<int?> register() async {
    Inbody = currentInbody;
    print("herrrrrrrrrrrrrrrrrrrrrrr register" + Inbody.BMI.toString());
    try {
      final response = await dio.post(GlobalUrl + "patientRegister",
          data: json.encode(<String, dynamic>{
            "username": username.trim(),
            "email": email.trim(),
            "password": password.trim(),
            "gender": Gender,
            "age": Age,
            "Case": Case,
            "height": Inbody.height,
            "weight": Inbody.weight,
            "BMI": Inbody.BMI,
          }));
      uId = currentuser.uId = currentpatient.uId = uId.trim();
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
      //debugPrint(e.response!.toString());
      throw Exception("failed to register");
    }
    //  if (response.statusCode == 200 && response.statusMessage == 'OK') {

    //return response.statusCode;
    //} else {
    //throw Exception('failed to register' + response.statusMessage!);
    //}
  }
}
