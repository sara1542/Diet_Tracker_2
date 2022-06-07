import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firstgp/globals/globalwidgets.dart';
import 'package:firstgp/models/doctor.dart';
import 'package:firstgp/models/inbody.dart';
import 'package:firstgp/models/patient.dart';
import 'package:firstgp/shared/components/constants.dart';
import 'package:flutter/cupertino.dart';

import '../globals/globalVariables.dart';

class apiServices {
  String doctorsurl = GlobalUrl + "getdoctors";
  String patientsurl = GlobalUrl + "getpatients";
  String patienturl = GlobalUrl + "getpatient/";
  String inbodyurl = GlobalUrl + "getinbody/";
  String decScore = GlobalUrl + "decreaseScore";
  String incScore = GlobalUrl + "increaseScore";
  Dio dio = new Dio();
  Future<void> increaseScore(String docId) async {
    final response = await dio.put(incScore,
        data: json.encode(<String, dynamic>{
          "_id": docId,
        }));
    if (response.statusCode == 200) {
      showToast(true, 'your feedback is recorded successfuly');
    } else {
      throw Exception('failed to subscribe the doctor');
    }
  }

  Future<void> decreaseScore(String docId) async {
    final response = await dio.put(decScore,
        data: json.encode(<String, dynamic>{
          "_id": docId,
        }));
    if (response.statusCode == 200) {
      showToast(true, 'your feedback is recorded successfuly');
    } else {
      throw Exception('failed to subscribe the doctor');
    }
  }

  Future<void> registerAdoctor(String docId) async {
    debugPrint(GlobalUrl + 'subscribeAdoctor');
    debugPrint(docId);
    final response = await dio.put(GlobalUrl + 'subscribeAdoctor',
        data: json.encode(<String, dynamic>{
          "patientid": currentuser.uId,
          "doctorid": docId,
        }));
    if (response.statusCode == 200) {
      showToast(true, 'you subscibed the doctor successfuly');
    } else {
      throw Exception('failed to subscribe the doctor');
    }
  }

  Future<int?> getdoctors() async {
    final response = await dio.get(
      doctorsurl,
    );
    if (response.statusCode == 200) {
      doctors = (response.data['doctors'] as List)
          .map((data) => doctor.fromJson(data))
          .toList();

      //  print("hereeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee22" + doctors[1].uId);
      return response.statusCode;
    } else {
      throw Exception('failed to get doctors');
    }
  }

  ///subscribeAdoctor
  Future<num?> getInbody(String uId) async {
    final response = await dio.get(
      inbodyurl + uId,
    );

    if (response.statusCode == 200) {
      print("hereeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee11" +
          response.data['inbody'].toString() +
          "                   ");

      currentInbody = inbody.fromJson(response.data['inbody']);

      return response.statusCode;
    } else {
      throw Exception('failed to get inbody');
    }
  }

  Future<num?> getpatient(String uId) async {
    final response = await dio.get(
      patienturl + uId,
    );

    if (response.statusCode == 200) {
      print("hereeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee11" +
          response.data['patient'].toString() +
          "                   ");

      currentpatient = patient.fromJson(response.data['patient']);

      return response.statusCode;
    } else {
      throw Exception('failed to get patient');
    }
  }

  Future<int?> getpatients() async {
    final response = await dio.get(
      patientsurl,
    );
    if (response.statusCode == 200) {
      print("hereeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee11" +
          response.data['patients'].toString() +
          "                   ");

      patients = (response.data['patients'] as List)
          .map((data) => patient.fromJson(data))
          .toList();
      for (int i = 0; i < patients.length; i++) {
        if (patients[i].uId == currentuser.uId) {
          currentpatient.Age = patients[i].Age;
          currentpatient.Case = patients[i].Case;
          break;
        }
      }
      print("hereeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee22");
      return response.statusCode;
    } else {
      throw Exception('failed to get patients');
    }
  }
}
