import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:firstgp/globals/globalVariables.dart';

enum gender { male, female }

class user {
  String username, email, password;
  String Gender;
  late String uId;
  late String image;
  late bool isEmailVerified;
  // int age;

  user(this.username, this.email, this.password, this.Gender);
  Dio dio = new Dio();

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["username"] = username;
    map["password"] = password;
    return map;
  }

  final usersUrl = 'http://192.168.56.1:6666/api/';
  factory user.fromJson(dynamic json) {
    return user(json["username"] as String, json["email"] as String,
        json["password"] as String, json["gender"] as String //,
        //json["age"] as int
        );
  }
  Future<int?> login(String username, String password) async {
    final response = await dio.post(usersUrl + 'login',
        //options: Options(headers: {"Content-Type": "application/json"}),
        data: json.encode(<String, dynamic>{
          "username": username,
          "password": password,
        }));
    print("in login" + response.data);
    //currentuser.fromJson(response.data);
    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      throw Exception('failed to login');
    }
  }

  Future<int?> register() async {} //overrided by patient, doctor
}
