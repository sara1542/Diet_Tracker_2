import 'dart:convert';

import 'package:firstgp/models/patient.dart';
import 'package:firstgp/models/user.dart';

import '../globals/globalVariables.dart';


class doctor extends user {
  late double ratingScore;
  late String cliniqueLocation;
  late String detailedLocation;
  double price;
  String cliniquePhone;
  late String visitaUrl;
  late List<patient> patients;
  doctor(
      String username,
      String email,
      String password,
      String Gender,
      // String cliniqueLoc,
      double pr,
      //  String detailedLoc,
      String cliniquePh)
      :
        //: cliniqueLocation = cliniqueLoc,
        price = pr,
        //detailedLocation = detailedLoc,
        cliniquePhone = cliniquePh,
        super(username, email, password, Gender);

  Future<int?> register() async {
    if (authData['visita url (optional)'] != '') {
      final getScore = await dio.post('http://192.168.56.1:6666/api/getscore',
          data: json.encode(
              <String, String>{"url": authData['visita url (optional)']!}));
      if (getScore.statusCode == 200) {
        print("rating score::: " + getScore.data.toString());
        ratingScore = double.parse(getScore.data['score']);
        return getScore.statusCode;
      } else {
        throw Exception('failed to register');
      }
    }

    final response = await dio.post(usersUrl + "doctorRegister",
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
      return response.statusCode;
    } else {
      throw Exception('failed to register');
    }
  }
}
