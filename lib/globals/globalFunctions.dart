
import 'package:firstgp/layout/social_app/social_layout.dart';
import 'package:firstgp/modules/social_app/social_login/social_login_screen.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:flutter/material.dart';

import '../models/doctor.dart';
import '../models/inbody.dart';
import '../models/patient.dart';
import 'globalVariables.dart';
import 'globalwidgets.dart';

String getLocation(String fullAdress) {
  String res = "";
  for (int i = 0; i < fullAdress.length; i++) {
    if (fullAdress[i] == ':') return res;
    res = res + fullAdress[i];
  }
  return res;
}

void submit(context) {
  print("in submit " + authData.toString());
  if (provider.isLogin) {
    currentuser.login(authData['email']!, authData['password']!).then((value) {
      showToast(true, 'signed in succesfully');
      print('signed in succesfully');
      authData['email'] = '';
      authData['password'] = '';
      button_provider.togglesigninOrsignupProgressIndicator();

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => SocialLayout(),
        ),
        (route) => false,
      );
    }).catchError((error) {
      button_provider.togglesigninOrsignupProgressIndicator();
      showToast(false, 'failed to sign in : $error');
      print('failed to sign in : $error');
    });
  } else {
    /*'email': '',
  'password': '',
  'username': '',
  'confirm password': '',
  'visita url (optional)': '',
  'isdoctor': '',
  'gender': '',
  'clinic number': '',
  'case': '' */

    if (authData['isdoctor'] == 'true') {
      print('registering a doctor');
      currentuser = new doctor(
          authData['username']!,
          authData['email']!,
          authData['password']!,
          authData['gender']!,
          double.parse(authData['detection price']!),
          authData['clinic number']!);
    } else {
      print('registering a patient');
      double height = double.parse(authData['height']!);
      double weight = double.parse(authData['weight']!);
      inbody currentPatientInbody =
          new inbody(height / weight, 0.0, 0.0, height, weight);

      currentuser = new patient(
          authData['username']!,
          authData['email']!,
          authData['password']!,
          authData['gender']!,
          int.parse(authData['age']!),
          authData['case']!,
          currentPatientInbody);
    }
    currentuser.register().then((value) {
      button_provider.togglesigninOrsignupProgressIndicator();
       showToast(true, 'signed up succesfully');
      provider.toggleisLogin();
    }).catchError((error) {
      button_provider.togglesigninOrsignupProgressIndicator();
      showToast(false, 'failed to sign up : $error');
      print('error ' + error.toString());
    });
  }
}

String getDoctorName(String fullNameStatement) {
  String res = "";
  for (int i = 13; i < fullNameStatement.length; i++) {
    //skipping a7gez al2an ma3
    res = res + fullNameStatement[i];
  }
  return res;
}

String getMoneyValue(String money) {
  String res = "";
  for (int i = 0; i < money.length; i++) {
    if (money[i] == ' ') return res;
    res = res + money[i];
  }
  return res;
}

/*Future<doctor?> extractData(String visitaUrl) async {
//https://www.vezeeta.com/ar/dr/%D8%AF%D9%83%D8%AA%D9%88%D8%B1-%D8%A3%D8%AD%D9%85%D8%AF-%D9%85%D8%A7%D8%AC%D8%AF-%D8%AA%D8%AE%D8%B3%D9%8A%D8%B3-%D9%88%D8%AA%D8%BA%D8%B0%D9%8A%D8%A9#patients-reviews
  final translator = GoogleTranslator();
  final response1 = await http.Client()
      .get(Uri.parse(visitaUrl), headers: {"Content-Type": "application/json"});

  if (response1.statusCode == 200) {
    var document = parser.parse(response1.body);
    print(document.body.toString());
    try {
      var ratingScore = document.getElementsByClassName(
          'DoctorReviewsstyle__RatingText-sc-o1mk5u-14 hCBXNB')[0];

      print(ratingScore.text.trim());
      var responseString2 = document.getElementsByClassName(
          'ReservationDetailsstyle__ItemText-sc-iq98nc-18 eVEjap')[0];
      var doctorName = document
          .getElementsByClassName(
              'HeaderContentBackgroundstyle__Headlines-sc-1gstdfx-1 gNsfTb')[0]
          .children[0];
      print(getDoctorName(doctorName.text.trim()));
      //SelectClinicstyle__AddressText-sc-1gcjuvq-6 dokQEl
      var address = document
          .getElementsByClassName(
              'SelectClinicstyle__SelectClinicsConatiner-sc-1gcjuvq-0 SelectClinicstyle__PaddedConatiner-sc-1gcjuvq-3 iTBmoU')[0]
          .children[1];
      print(getLocation(address.text.trim()));
      String arabicMoney = responseString2.text.trim();
      String englishMoney = "0.0";
      await translator
          .translate(getMoneyValue(arabicMoney), from: 'ar', to: 'en')
          .then((value) {
        englishMoney = value.toString();
        print(value);
      });
      print(englishMoney);
      await translator
          .translate(getLocation(address.text.trim()), from: 'ar', to: 'en')
          .then((value) {
        print(value);
      });

      await translator
          .translate(getDoctorName(doctorName.text.trim()),
              from: 'ar', to: 'en')
          .then((value) {
        print(value);
      });
      return doctor(
          getDoctorName(doctorName.text.trim()),
          getLocation(address.text.trim()),
          double.parse(englishMoney),
          double.parse(ratingScore.text.trim()),
          address.text.trim());
    } catch (e) {
      print("error1");

      return null;
    }
  } else {
    print("error2");
    return null;
  }
}
*/
// Future<void> getCurrentPosition() async {
//   position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high);
//
//   // atCompany();
//   print(position.latitude);
//   print("            ");
//   print(position.longitude);
//   // notifyListeners();
// }

// double calculateDistance(double lat1, double long1, double lat2, double long2) {
//   double distanceInMeters =
//       Geolocator.distanceBetween(lat1, long1, lat2, long2);
//   return distanceInMeters;
// }

/*Future<void> getDoctorsData() async {
  print("in get doctores data");
  for (int i = 0; i < doctorsVisitaUrl.length; i++) {
    doctor? temp = await extractData(doctorsVisitaUrl[i]);
    temp!.price = (i == 0) ? 100 : 300;
    doctors.add(temp);
    print(temp.name + "  " + temp.price.toString() + "  is added");
  }
  print(" at the end in get doctores data");
  // doctor1 =
  // doctor2 = await extractData('');
}
*/
final String apikey = 'helloworld';
double h = 0, w = 0, bfm = 0, tbw = 0;
Widget defaultTextFormField(
        {required TextEditingController controller,
        required String text,
        required BuildContext context}) =>
    TextFormField(
        decoration: InputDecoration(
            // contentPadding: EdgeInsets.fromLTRB(5.0, 20, 5.0, 20.0),
            labelText: " $text ",
            labelStyle:
                TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
            enabledBorder: new OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
              borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.blue[300]!.withOpacity(0.6), width: 3),
            )),
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Invalid $text!';
          }
          print("in validatorrr");
          return null;
        },
        onSaved: (value) {
          if (text == 'height')
            h = double.parse(value!);
          else
            w = double.parse(value!);
        });
