import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firstgp/models/doctor.dart';

import '../globals/globalVariables.dart';

class apiServices {
  String doctorsurl = "http://192.168.1.60:6666/api/getdoctors";
  Dio dio = new Dio();
  Future<int?> getdoctors() async {
    final response = await dio.get(
      doctorsurl,
    );
    if (response.statusCode == 200) {
      print("hereeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee11" +
          response.data['doctors'].toString() +
          "                   ");
/*
     return (response.data['contacts'] as List)
        .map<Contact>((json) => Contact.fromJson(json))
        .toList();
  }
 */
      doctors = (response.data['doctors'] as List)
          .map((data) => doctor.fromJson(data))
          .toList();

      print("hereeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee22");
      return response.statusCode;
    } else {
      throw Exception('failed to login');
    }
  }
}
