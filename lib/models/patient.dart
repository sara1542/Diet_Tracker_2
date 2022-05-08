import 'dart:convert';
import 'diet.dart';
import 'doctor.dart';
import 'inbody.dart';
import 'user.dart';

class patient extends user {
  inbody Inbody;
  late doctor Doctor;
  late diet Diet;
  int Age;
  String Case;
  patient(String username, String email, String password, String Gender,
      int age, String c, inbody inb)
      : Age = age,
        Case = c,
        Inbody = inb,
        super(username, email, password, Gender);

  Future<int?> register() async {
    print("herrrrrrrrrrrrrrrrrrrrrrr" + Inbody.BMI.toString());
    final response = await dio.post(usersUrl + "patientRegister",
        data: json.encode(<String, dynamic>{
          "username": username.trim(),
          "email": email.trim(),
          "password": password.trim(),
          "gender": Gender,
          "case": Case,
          "height": Inbody.height,
          "weight": Inbody.weight,
          "BMI": Inbody.BMI
        }));
    if (response.statusCode == 200 && response.statusMessage == 'OK') {
      return response.statusCode;
    } else {
      throw Exception('failed to register' + response.statusMessage!);
    }
  }
}
