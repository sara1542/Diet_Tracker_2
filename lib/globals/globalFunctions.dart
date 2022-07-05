import 'package:firstgp/layout/social_app/social_layout.dart';

import 'package:flutter/material.dart';

import '../apiServices/api.dart';
import '../models/dish/dish_model.dart';
import '../models/doctor.dart';
import '../models/inbody.dart';
import '../models/patient.dart';
import '../shared/network/local/cache_helper.dart';
import 'globalVariables.dart';
import 'globalwidgets.dart';

import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

String getLocation(String fullAdress) {
  String res = "";
  for (int i = 0; i < fullAdress.length; i++) {
    if (fullAdress[i] == ':') return res;
    res = res + fullAdress[i];
  }
  return res;
}

apiServices api = new apiServices();
Future<void> getinbody(String uId) async {
  await api.getInbody(uId);
}

Future<void> getpatient(String uId) async {
  await api.getpatient(uId);
}

Future<void> getPatientDoctor(String uId) async {
  await api.getPatientDoctor(uId);
}

Future<void> getDoctor(String uId) async {
  await api.getDoctor(uId);
}

void submit(context) async {
  print("in submit " + authData.toString());
  if (provider.isLogin) {
    await currentuser
        .login(authData['email']!, authData['password']!)
        .then((value) {
      showToast(true, 'signed in succesfully');
      print('signed in succesfully');

      //currentuser.email = authData['email']!;
      authData['email'] = '';
      authData['password'] = '';
      isDoctor = currentuser.role == 'doctor' ? true : false;

      button_provider.togglesigninOrsignupProgressIndicator();
    }).then((value) {
      return CacheHelper.saveData(
        key: 'uId',
        value: currentuser.uId,
      );
    }).then((value) => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => SocialLayout(),
              ),
              (route) => false,
            ));
    /*.catchError((error) {
          button_provider.togglesigninOrsignupProgressIndicator();
          if (error.response.statusCode == 404) {
            showToast(false, 'incorrect email or password');
          } else {
            showToast(false, 'check your internet connection and try again');
          }
          print('failed to sign in : $error');
          debugPrint(error.response.statusCode.toString());
        });*/
  } else {
    if (authData['isdoctor'] == 'true') {
      print('registering a doctor');
      currentuser = doctor(
          "",
          authData['username']!,
          authData['email']!,
          authData['password']!,
          authData['gender']!,
          double.parse(authData['detection price']!),
          authData['clinic number']!,
          authData['image']!);
    } else {
      print('registering a patient');
      double height = double.parse(authData['height']!);
      double weight = double.parse(authData['weight']!);

      currentInbody =
          inbody(height, weight, weight / (height / 100.0), 0.0, 0.0);

      currentuser = patient(
        '',
        authData['username']!,
        authData['email']!,
        authData['password']!,
        authData['gender']!,
        int.parse(authData['age']!),
        authData['case']!,
        authData['image']!,
      );
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

Future getMeals() async {
  await getBreakfastMeals();
  await getLunchMeals();
  await getSnacks();
}

Future getSnacks() async {
  var responce = await http.get(Uri.parse(GlobalUrl + 'getsnacks'));
  var jsonData = jsonDecode(responce.body);
  for (var i in jsonData) {
    Dish dish = Dish(
        i["Category"],
        i["Name"],
        i["Calories"].toDouble(),
        i["Carbohydrates"].toDouble(),
        i["Protein"].toDouble(),
        i["Fat"].toDouble(),
        i["Meal"]);

    snacks.add(dish);
  }
  filterSnack1 = snacks[0];
  filterSnack2 = snacks[1];
}

generateSnacks() {
  var sCalories = ((calories - cur_calories) * 0.5).abs();
  if (sCalories < 10) {
    sCalories = 20;
  }
  do {
    var rand = Random();

    int len = snacks.length;
    int randomNumber = rand.nextInt(len);
    var amount;
    amount = Is_Meal(snacks[randomNumber], sCalories);
    if (snacks[randomNumber].Name.contains('Gram')) {
      First_Snack = (100 * amount).round().toString() +
          " " +
          snacks[randomNumber].Name +
          "\n";
    } else {
      First_Snack = amount.toString() + " " + snacks[randomNumber].Name;
    }
    s1Calories = snacks[randomNumber].Calories * amount;

    randomNumber = rand.nextInt(len);
    amount = Is_Meal(snacks[randomNumber], sCalories);

    if (snacks[randomNumber].Name.contains('Gram')) {
      Second_Snack = (100 * amount).round().toString() +
          " " +
          snacks[randomNumber].Name +
          "\n";
    } else {
      Second_Snack = amount.toString() + " " + snacks[randomNumber].Name;
    }
    s2Calories = snacks[randomNumber].Calories * amount;
    print("here");
    print(((s1Calories + s2Calories) - (calories - cur_calories).abs()).abs());
  } while (
      ((s1Calories + s2Calories) - (calories - cur_calories).abs()).abs() >=
          50);
  sMeals.add(First_Snack);
  sMeals.add(Second_Snack);
}

Future getBreakfastMeals() async {
  var responce = await http.get(Uri.parse(GlobalUrl + 'getbreakfast'));
  var jsonData = jsonDecode(responce.body);
  for (var i in jsonData) {
    Dish dish = Dish(
        i["Category"],
        i["Name"],
        i["Calories"].toDouble(),
        i["Carbohydrates"].toDouble(),
        i["Protein"].toDouble(),
        i["Fat"].toDouble(),
        i["Meal"]);

    if (dish.Category == "proteins") {
      breakfastProtein.add(dish);
    } else if (dish.Category == "carb") {
      breakfastCarb.add(dish);
    } else if (dish.Category == "vegetables") {
      breakfastVegeies.add(dish);
    } else if (dish.Category == "dairy" || dish.Category == "legumes") {
      breakfastDairyAndLegumes.add(dish);
    }
  }
  filterBreakfastProtein = breakfastProtein[0];
  filterBreakfastCarb = breakfastCarb[0];
  filterBreakfastVegeies = breakfastVegeies[0];
  filterBreakfastDairyAndLegumes = breakfastDairyAndLegumes[0];
}

double Is_Meal(Dish dish, var value) {
  double amount = 0.0;
  while (value - (amount * dish.Calories) >= 10) {
    if (dish.Name.contains('Gram')) {
      amount += 0.10;
    } else {
      amount++;
    }
  }
  return amount;
}

String generateBreakfastMeals() {
  String breakfast = "";
  var breakfastCalories = calories * 0.35;
  do {
    breakfast = "";
    var rand = Random();

    int len = breakfastProtein.length;
    int randomNumber = rand.nextInt(len);
    var amount;
    var value = 0.4 * breakfastCalories * 0.5;
    //print(breakfastProtein[randomNumber].Calories);
    //print(value);
    //print(breakfastProtein[randomNumber].Name);

    if (breakfastProtein[randomNumber].Meal == 1) {
      amount = Is_Meal(breakfastProtein[randomNumber], breakfastCalories);

      bfCalories = breakfastProtein[randomNumber].Calories * amount;

      bfCarb = breakfastProtein[randomNumber].Carbohydrates * amount;
      bfFat = breakfastProtein[randomNumber].Fat * amount;
      bfProtein = breakfastProtein[randomNumber].Protein * amount;

      if (breakfastProtein[randomNumber].Name.contains('Gram')) {
        breakfast = (100 * amount).round().toString() +
            " " +
            breakfastProtein[randomNumber].Name +
            "\n";
      } else {
        breakfast =
            amount.toString() + " " + breakfastProtein[randomNumber].Name;
      }
      break;
    } else {
      amount = Is_Meal(breakfastProtein[randomNumber], value);
    }

    if (breakfastProtein[randomNumber].Name.contains('Gram')) {
      breakfast += (100 * amount).round().toString() +
          " " +
          breakfastProtein[randomNumber].Name +
          "\n";
    } else {
      breakfast +=
          amount.toString() + " " + breakfastProtein[randomNumber].Name + "\n";
    }

    bfCalories = breakfastProtein[randomNumber].Calories * amount;
    bfCarb = breakfastProtein[randomNumber].Carbohydrates * amount;
    bfFat = breakfastProtein[randomNumber].Fat * amount;
    bfProtein = breakfastProtein[randomNumber].Protein * amount;

    len = breakfastDairyAndLegumes.length;
    randomNumber = rand.nextInt(len);

    value = 0.4 * breakfastCalories * 0.5;
    //print(breakfastDairyAndLegumes[randomNumber].Calories);
    //print(value);
    //print(breakfastDairyAndLegumes[randomNumber].Name);

    if (breakfastDairyAndLegumes[randomNumber].Meal == 1) {
      amount =
          Is_Meal(breakfastDairyAndLegumes[randomNumber], breakfastCalories);

      bfCalories = breakfastDairyAndLegumes[randomNumber].Calories * amount;
      bfCarb = breakfastDairyAndLegumes[randomNumber].Carbohydrates * amount;
      bfFat = breakfastDairyAndLegumes[randomNumber].Fat * amount;
      bfProtein = breakfastDairyAndLegumes[randomNumber].Protein * amount;

      if (breakfastDairyAndLegumes[randomNumber].Name.contains('Gram')) {
        breakfast = (100 * amount).round().toString() +
            " " +
            breakfastDairyAndLegumes[randomNumber].Name;
      } else {
        breakfast = amount.toString() +
            " " +
            breakfastDairyAndLegumes[randomNumber].Name;
      }

      break;
    } else {
      amount = Is_Meal(breakfastDairyAndLegumes[randomNumber], value);
    }
    if (breakfastDairyAndLegumes[randomNumber].Name.contains('Gram')) {
      breakfast += " " +
          (100 * amount).round().toString() +
          " " +
          breakfastDairyAndLegumes[randomNumber].Name +
          "\n";
    } else {
      breakfast += " " +
          amount.toString() +
          " " +
          breakfastDairyAndLegumes[randomNumber].Name +
          "\n";
    }

    bfCalories += breakfastDairyAndLegumes[randomNumber].Calories * amount;
    bfCarb += breakfastDairyAndLegumes[randomNumber].Carbohydrates * amount;
    bfFat += breakfastDairyAndLegumes[randomNumber].Fat * amount;
    bfProtein += breakfastDairyAndLegumes[randomNumber].Protein * amount;

    len = breakfastVegeies.length;
    randomNumber = rand.nextInt(len);

    value = 0.4 * breakfastCalories * 0.2;
    //print(breakfastVegeies[randomNumber].Calories);
    //print(value);
    //print(breakfastVegeies[randomNumber].Name);

    if (breakfastVegeies[randomNumber].Meal == 1) {
      amount = Is_Meal(breakfastVegeies[randomNumber], breakfastCalories);

      bfCalories = breakfastVegeies[randomNumber].Calories * amount;
      bfCarb = breakfastVegeies[randomNumber].Carbohydrates * amount;
      bfFat = breakfastVegeies[randomNumber].Fat * amount;
      bfProtein = breakfastVegeies[randomNumber].Protein * amount;

      if (breakfastVegeies[randomNumber].Name.contains('Gram')) {
        breakfast = (100 * amount).round().toString() +
            " " +
            breakfastVegeies[randomNumber].Name;
      } else {
        breakfast =
            amount.toString() + " " + breakfastVegeies[randomNumber].Name;
      }
      break;
    } else {
      amount = Is_Meal(breakfastVegeies[randomNumber], value);
    }
    if (breakfastVegeies[randomNumber].Name.contains('Gram')) {
      breakfast += " " +
          (100 * amount).round().toString() +
          " " +
          breakfastVegeies[randomNumber].Name +
          "\n";
    } else {
      breakfast += " " +
          amount.toString() +
          " " +
          breakfastVegeies[randomNumber].Name +
          "\n";
    }

    bfCalories += breakfastVegeies[randomNumber].Calories * amount;
    bfCarb += breakfastVegeies[randomNumber].Carbohydrates * amount;
    bfFat += breakfastVegeies[randomNumber].Fat * amount;
    bfProtein += breakfastVegeies[randomNumber].Protein * amount;

    len = breakfastCarb.length;
    randomNumber = rand.nextInt(len);

    value = 0.4 * breakfastCalories * 0.8;
    //print(breakfastCarb[randomNumber].Calories);
    //print(value);
    //print(breakfastCarb[randomNumber].Name);

    if (breakfastCarb[randomNumber].Meal == 1) {
      amount = Is_Meal(breakfastCarb[randomNumber], breakfastCalories);

      bfCalories = breakfastCarb[randomNumber].Calories * amount;
      bfCarb = breakfastCarb[randomNumber].Carbohydrates * amount;
      bfFat = breakfastCarb[randomNumber].Fat * amount;
      bfProtein = breakfastCarb[randomNumber].Protein * amount;

      if (breakfastCarb[randomNumber].Name.contains('Gram')) {
        breakfast = (100 * amount).round().toString() +
            " " +
            breakfastCarb[randomNumber].Name;
      } else {
        breakfast = amount.toString() + " " + breakfastCarb[randomNumber].Name;
      }
      break;
    } else {
      amount = Is_Meal(breakfastCarb[randomNumber], value);
    }

    if (breakfastCarb[randomNumber].Name.contains('Gram')) {
      breakfast += " " +
          (100 * amount).round().toString() +
          " " +
          breakfastCarb[randomNumber].Name +
          "\n";
    } else {
      breakfast += " " +
          amount.toString() +
          " " +
          breakfastCarb[randomNumber].Name +
          "\n";
    }

    bfCalories += breakfastCarb[randomNumber].Calories * amount;
    bfCarb += breakfastCarb[randomNumber].Carbohydrates * amount;
    bfFat += breakfastCarb[randomNumber].Fat * amount;
    bfProtein += breakfastCarb[randomNumber].Protein * amount;
  } while (bfCalories > (breakfastCalories) ||
      bfFat > fat * 0.4 ||
      bfCarb > carb * 0.4 ||
      bfProtein > protein * 0.4);

  if (checkBad(breakfast)) {
    generateBreakfastMeals();
  }
  bfMeals.add(breakfast.replaceAll("\n", ""));
  //print(bfCalories);
  return breakfast;
}

Future getLunchMeals() async {
  var responce = await http.get(Uri.parse(GlobalUrl + 'getlunch'));
  var jsonData = jsonDecode(responce.body);
  for (var i in jsonData) {
    Dish dish = Dish(
        i["Category"],
        i["Name"],
        i["Calories"].toDouble(),
        i["Carbohydrates"].toDouble(),
        i["Protein"].toDouble(),
        i["Fat"].toDouble(),
        i["Meal"]);

    if (dish.Category == "proteins" || dish.Category == "seafood") {
      lunchProtein.add(dish);
    } else if (dish.Category == "carb") {
      lunchCarb.add(dish);
    } else if (dish.Category == "vegetables" || dish.Category == "legumes") {
      lunchVegeiesAndLegumes.add(dish);
    }
  }
  filterLunchProtein = lunchProtein[0];
  filterLunchCarb = lunchCarb[0];
  filterLunchVegeiesAndLegumes = lunchVegeiesAndLegumes[0];
}

String generateLunchMeals() {
  //print("im in here");
  String lunch = "";
  var lunchCalories = calories * 0.45;
  do {
    lunch = "";
    var rand = Random();

    int len = lunchProtein.length;
    int randomNumber = rand.nextInt(len);

    var amount;
    var value = 0.4 * lunchCalories;
    //print(lunchProtein[randomNumber].Calories);
    //print(value);
    //print(lunchProtein[randomNumber].Name);

    if (lunchProtein[randomNumber].Meal == 1) {
      amount = Is_Meal(lunchProtein[randomNumber], lunchCalories);
      lCalories = lunchProtein[randomNumber].Calories * amount;
      lCarb = lunchProtein[randomNumber].Carbohydrates * amount;
      lFat = lunchProtein[randomNumber].Fat * amount;
      lProtein = lunchProtein[randomNumber].Protein * amount;

      if (lunchProtein[randomNumber].Name.contains('Gram')) {
        lunch = (100 * amount).round().toString() +
            " " +
            lunchProtein[randomNumber].Name;
      } else {
        lunch = amount.toString() + " " + lunchProtein[randomNumber].Name;
      }
      break;
    } else {
      amount = Is_Meal(lunchProtein[randomNumber], value);
    }

    if (lunchProtein[randomNumber].Name.contains('Gram')) {
      lunch += (100 * amount).round().toString() +
          " " +
          lunchProtein[randomNumber].Name +
          "\n";
    } else {
      lunch += amount.toString() + " " + lunchProtein[randomNumber].Name + "\n";
    }

    lCalories = lunchProtein[randomNumber].Calories * amount;
    lCarb = lunchProtein[randomNumber].Carbohydrates * amount;
    lFat = lunchProtein[randomNumber].Fat * amount;
    lProtein = lunchProtein[randomNumber].Protein * amount;

    len = lunchVegeiesAndLegumes.length;
    randomNumber = rand.nextInt(len);

    value = 0.4 * lunchCalories * 0.5;
    //print(lunchVegeiesAndLegumes[randomNumber].Calories);
    //print(value);
    //print(lunchVegeiesAndLegumes[randomNumber].Name);

    if (lunchVegeiesAndLegumes[randomNumber].Meal == 1) {
      amount = Is_Meal(lunchVegeiesAndLegumes[randomNumber], lunchCalories);

      lCalories = lunchVegeiesAndLegumes[randomNumber].Calories * amount;
      lCarb = lunchVegeiesAndLegumes[randomNumber].Carbohydrates * amount;
      lFat = lunchVegeiesAndLegumes[randomNumber].Fat * amount;
      lProtein = lunchVegeiesAndLegumes[randomNumber].Protein * amount;

      if (lunchVegeiesAndLegumes[randomNumber].Name.contains('Gram')) {
        lunch = (100 * amount).round().toString() +
            " " +
            lunchVegeiesAndLegumes[randomNumber].Name;
      } else {
        lunch =
            amount.toString() + " " + lunchVegeiesAndLegumes[randomNumber].Name;
      }
      break;
    } else {
      amount = Is_Meal(lunchVegeiesAndLegumes[randomNumber], value);
    }

    if (lunchVegeiesAndLegumes[randomNumber].Name.contains('Gram')) {
      lunch += " " +
          (100 * amount).round().toString() +
          " " +
          lunchVegeiesAndLegumes[randomNumber].Name +
          "\n";
    } else {
      lunch += " " +
          amount.toString() +
          " " +
          lunchVegeiesAndLegumes[randomNumber].Name +
          "\n";
    }

    lCalories += lunchVegeiesAndLegumes[randomNumber].Calories * amount;
    lCarb += lunchVegeiesAndLegumes[randomNumber].Carbohydrates * amount;
    lFat += lunchVegeiesAndLegumes[randomNumber].Fat * amount;
    lProtein += lunchVegeiesAndLegumes[randomNumber].Protein * amount;

    len = lunchCarb.length;
    randomNumber = rand.nextInt(len);

    value = 0.4 * lunchCalories * 0.2;
    //print(lunchCarb[randomNumber].Calories);
    //print(value);
    //print(lunchCarb[randomNumber].Name);

    if (lunchCarb[randomNumber].Meal == 1) {
      amount = Is_Meal(lunchCarb[randomNumber], lunchCalories);

      lCalories = lunchCarb[randomNumber].Calories * amount;
      lCarb = lunchCarb[randomNumber].Carbohydrates * amount;
      lFat = lunchCarb[randomNumber].Fat * amount;
      lProtein = lunchCarb[randomNumber].Protein * amount;

      if (lunchCarb[randomNumber].Name.contains('Gram')) {
        lunch = (100 * amount).round().toString() +
            " " +
            lunchCarb[randomNumber].Name;
      } else {
        lunch = amount.toString() + " " + lunchCarb[randomNumber].Name;
      }
      break;
    } else {
      amount = Is_Meal(lunchCarb[randomNumber], value);
    }

    if (lunchCarb[randomNumber].Name.contains('Gram')) {
      lunch += " " +
          (100 * amount).round().toString() +
          " " +
          lunchCarb[randomNumber].Name +
          "\n";
    } else {
      lunch +=
          " " + amount.toString() + " " + lunchCarb[randomNumber].Name + "\n";
    }
    lCalories += lunchVegeiesAndLegumes[randomNumber].Calories * amount;
    lCarb += lunchVegeiesAndLegumes[randomNumber].Carbohydrates * amount;
    lFat += lunchVegeiesAndLegumes[randomNumber].Fat * amount;
    lProtein += lunchVegeiesAndLegumes[randomNumber].Protein * amount;
  } while (lCalories > lunchCalories ||
      lFat > fat * 0.5 ||
      lCarb > carb * 0.5 ||
      lProtein > protein * 0.5);

  if (checkBad(lunch)) {
    generateLunchMeals();
  }

  lMeals.add(lunch.replaceAll("\n", ""));
  //print(lCalories);
  return lunch;
}

String generateDinnerMeals() {
  //print("im in here");
  String dinner = "";
  var breakfastCalories = calories * 0.25;
  do {
    dinner = "";
    var rand = Random();

    int len = breakfastProtein.length;
    int randomNumber = rand.nextInt(len);
    var amount;
    var value = 0.4 * breakfastCalories * 0.5;
    //print(breakfastProtein[randomNumber].Calories);
    //print(value);
    //print(breakfastProtein[randomNumber].Name);

    if (breakfastProtein[randomNumber].Meal == 1) {
      amount = Is_Meal(breakfastProtein[randomNumber], breakfastCalories);

      dCalories = breakfastProtein[randomNumber].Calories * amount;
      dCarb = breakfastProtein[randomNumber].Carbohydrates * amount;
      dFat = breakfastProtein[randomNumber].Fat * amount;
      dProtein = breakfastProtein[randomNumber].Protein * amount;

      if (breakfastProtein[randomNumber].Name.contains('Gram')) {
        dinner = (100 * amount).round().toString() +
            " " +
            breakfastProtein[randomNumber].Name;
      } else {
        dinner = amount.toString() + " " + breakfastProtein[randomNumber].Name;
      }

      break;
    } else {
      amount = Is_Meal(breakfastProtein[randomNumber], value);
    }

    if (breakfastProtein[randomNumber].Name.contains('Gram')) {
      dinner += (100 * amount).round().toString() +
          " " +
          breakfastProtein[randomNumber].Name +
          "\n";
    } else {
      dinner +=
          amount.toString() + " " + breakfastProtein[randomNumber].Name + "\n";
    }

    dCalories = breakfastProtein[randomNumber].Calories * amount;
    dCarb = breakfastProtein[randomNumber].Carbohydrates * amount;
    dFat = breakfastProtein[randomNumber].Fat * amount;
    dProtein = breakfastProtein[randomNumber].Protein * amount;

    len = breakfastDairyAndLegumes.length;
    randomNumber = rand.nextInt(len);

    value = 0.4 * breakfastCalories * 0.5;
    //print(breakfastDairyAndLegumes[randomNumber].Calories);
    //print(value);
    //print(breakfastDairyAndLegumes[randomNumber].Name);

    if (breakfastDairyAndLegumes[randomNumber].Meal == 1) {
      amount =
          Is_Meal(breakfastDairyAndLegumes[randomNumber], breakfastCalories);

      dCalories = breakfastDairyAndLegumes[randomNumber].Calories * amount;
      dCarb = breakfastDairyAndLegumes[randomNumber].Carbohydrates * amount;
      dFat = breakfastDairyAndLegumes[randomNumber].Fat * amount;
      dProtein = breakfastDairyAndLegumes[randomNumber].Protein * amount;

      if (breakfastDairyAndLegumes[randomNumber].Name.contains('Gram')) {
        dinner = (100 * amount).round().toString() +
            " " +
            breakfastDairyAndLegumes[randomNumber].Name;
      } else {
        dinner = amount.toString() +
            " " +
            breakfastDairyAndLegumes[randomNumber].Name;
      }

      break;
    } else {
      amount = Is_Meal(breakfastDairyAndLegumes[randomNumber], value);
    }
    if (breakfastDairyAndLegumes[randomNumber].Name.contains('Gram')) {
      dinner += " " +
          (100 * amount).round().toString() +
          " " +
          breakfastDairyAndLegumes[randomNumber].Name +
          "\n";
    } else {
      dinner += " " +
          amount.toString() +
          " " +
          breakfastDairyAndLegumes[randomNumber].Name +
          "\n";
    }

    dCalories += breakfastDairyAndLegumes[randomNumber].Calories * amount;
    dCarb += breakfastDairyAndLegumes[randomNumber].Carbohydrates * amount;
    dFat += breakfastDairyAndLegumes[randomNumber].Fat * amount;
    dProtein += breakfastDairyAndLegumes[randomNumber].Protein * amount;

    len = breakfastVegeies.length;
    randomNumber = rand.nextInt(len);

    value = 0.4 * breakfastCalories * 0.2;
    //print(breakfastVegeies[randomNumber].Calories);
    //print(value);
    //print(breakfastVegeies[randomNumber].Name);

    if (breakfastVegeies[randomNumber].Meal == 1) {
      amount = Is_Meal(breakfastVegeies[randomNumber], breakfastCalories);

      dCalories = breakfastVegeies[randomNumber].Calories * amount;
      dCarb = breakfastVegeies[randomNumber].Carbohydrates * amount;
      dFat = breakfastVegeies[randomNumber].Fat * amount;
      dProtein = breakfastVegeies[randomNumber].Protein * amount;

      if (breakfastVegeies[randomNumber].Name.contains('Gram')) {
        dinner = (100 * amount).round().toString() +
            " " +
            breakfastVegeies[randomNumber].Name;
      } else {
        dinner = amount.toString() + " " + breakfastVegeies[randomNumber].Name;
      }

      break;
    } else {
      amount = Is_Meal(breakfastVegeies[randomNumber], value);
    }
    if (breakfastVegeies[randomNumber].Name.contains('Gram')) {
      dinner += " " +
          (100 * amount).round().toString() +
          " " +
          breakfastVegeies[randomNumber].Name +
          "\n";
    } else {
      dinner += " " +
          amount.toString() +
          " " +
          breakfastVegeies[randomNumber].Name +
          "\n";
    }

    dCalories += breakfastVegeies[randomNumber].Calories * amount;
    dCarb += breakfastVegeies[randomNumber].Carbohydrates * amount;
    dFat += breakfastVegeies[randomNumber].Fat * amount;
    dProtein += breakfastVegeies[randomNumber].Protein * amount;

    len = breakfastCarb.length;
    randomNumber = rand.nextInt(len);

    value = 0.4 * breakfastCalories * 0.8;
    //print(breakfastCarb[randomNumber].Calories);
    //print(value);
    //print(breakfastCarb[randomNumber].Name);

    if (breakfastCarb[randomNumber].Meal == 1) {
      amount = Is_Meal(breakfastCarb[randomNumber], breakfastCalories);

      dCalories = breakfastCarb[randomNumber].Calories * amount;
      dCarb = breakfastCarb[randomNumber].Carbohydrates * amount;
      dFat = breakfastCarb[randomNumber].Fat * amount;
      dProtein = breakfastCarb[randomNumber].Protein * amount;

      if (breakfastCarb[randomNumber].Name.contains('Gram')) {
        dinner = (100 * amount).round().toString() +
            " " +
            breakfastCarb[randomNumber].Name;
      } else {
        dinner = amount.toString() + " " + breakfastCarb[randomNumber].Name;
      }
      break;
    } else {
      amount = Is_Meal(breakfastCarb[randomNumber], value);
    }

    if (breakfastCarb[randomNumber].Name.contains('Gram')) {
      dinner += " " +
          (100 * amount).round().toString() +
          " " +
          breakfastCarb[randomNumber].Name +
          "\n";
    } else {
      dinner += " " +
          amount.toString() +
          " " +
          breakfastCarb[randomNumber].Name +
          "\n";
    }

    dCalories += breakfastCarb[randomNumber].Calories * amount;
    dCarb += breakfastCarb[randomNumber].Carbohydrates * amount;
    dFat += breakfastCarb[randomNumber].Fat * amount;
    dProtein += breakfastCarb[randomNumber].Protein * amount;
  } while (dCalories > (breakfastCalories) ||
      dFat > fat * 0.4 ||
      dCarb > carb * 0.4 ||
      dProtein > protein * 0.4);

  if (checkBad(dinner)) {
    generateDinnerMeals();
  }
  dMeals.add(dinner.replaceAll("\n", ""));
  //print(dCalories);
  return dinner;
}

Future<http.Response> createBadCombination(String bad) {
  return http.post(
    Uri.parse(GlobalUrl + 'postameal'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, List<String>>{
      'meal': toStrArr(bad),
    }),
  );
}

Future<http.Response> createDiet() {
  return http
      .post(Uri.parse(GlobalUrl + 'postameal'), headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  }, body: {
    '_id': " ",
    'breakfast': bfMeals,
    'lunch': lMeals,
    'dinner': dMeals,
    'caloriesToBeBurntPerDay': caloriesBurnt,
    'caloriesPerDay': calories,
  });
}

Future getBadCombo() async {
  var responce = await http.get(Uri.parse(GlobalUrl + 'getbadmeals'));
  var jsonData = jsonDecode(responce.body);
  for (var i in jsonData) {
    List<dynamic> list = <dynamic>[];
    list = i["meal"];
    badCombo.add(list);
  }
}

List<String> toStrArr(String meals) {
  String meal = meals
      .replaceAll(RegExp('[0-9]'), '')
      .replaceAll("Medium", "")
      .replaceAll("Gram", "")
      .replaceAll("Slice", "")
      .replaceAll("tbsp", "")
      .replaceAll("Medium", "")
      .replaceAll("of", "")
      .replaceAll("Of", "")
      .replaceAll("  ", "")
      .replaceAll(",", "")
      .replaceAll(".", "")
      .replaceAll("\n", "");

  //print(meal);
  List<String> strarray = meal.split(" ");
  //print(strarray);
  return strarray;
}

bool checkBad(var meal) {
  bool res = false;
  meal = toStrArr(meal);
  for (int i = 0; i < badCombo.length; i++) {
    if (listEquals(meal, badCombo[i])) {
      res = true;
      break;
    }
  }
  //print(res);
  //print(meal);
  return res;
}

saveChange() {
  String strMeal = "";
  double curcalories = 0.0;
  if (Filter == "lunch") {
    if (filterLunchProtein.Name.contains('Gram')) {
      strMeal += " " +
          (amountFilterLunchProtein).toString() +
          " " +
          filterLunchProtein.Name +
          "\n";
      curcalories +=
          (amountFilterLunchProtein / 100) * filterLunchProtein.Calories;
    } else {
      strMeal += " " +
          amountFilterLunchProtein.toString() +
          " " +
          filterLunchProtein.Name +
          "\n";
      curcalories += amountFilterLunchProtein * filterLunchProtein.Calories;
    }
    if (filterLunchVegeiesAndLegumes.Name.contains('Gram')) {
      strMeal += " " +
          (amountFilterLunchVegeiesAndLegumes).toString() +
          " " +
          filterLunchVegeiesAndLegumes.Name +
          "\n";
      curcalories += (amountFilterLunchVegeiesAndLegumes / 100) *
          filterLunchVegeiesAndLegumes.Calories;
    } else {
      strMeal += " " +
          amountFilterLunchVegeiesAndLegumes.toString() +
          " " +
          filterLunchVegeiesAndLegumes.Name +
          "\n";
      curcalories += amountFilterLunchVegeiesAndLegumes *
          filterLunchVegeiesAndLegumes.Calories;
    }
    if (filterLunchCarb.Name.contains('Gram')) {
      strMeal += " " +
          (amountFilterLunchCarb).toString() +
          " " +
          filterLunchCarb.Name +
          "\n";
      curcalories += (amountFilterLunchCarb / 100) * filterLunchCarb.Calories;
    } else {
      strMeal += " " +
          amountFilterLunchCarb.toString() +
          " " +
          filterLunchCarb.Name +
          "\n";
      curcalories += amountFilterLunchCarb * filterLunchCarb.Calories;
    }
  } else if (Filter == "breakfast" || Filter == "dinner") {
    if (filterBreakfastProtein.Name.contains('Gram')) {
      strMeal += " " +
          (amountFilterBreakfastProtein).toString() +
          " " +
          filterBreakfastProtein.Name +
          "\n";
      curcalories += (amountFilterBreakfastProtein / 100) *
          filterBreakfastProtein.Calories;
    } else {
      strMeal += " " +
          amountFilterBreakfastProtein.toString() +
          " " +
          filterBreakfastProtein.Name +
          "\n";
      curcalories +=
          (amountFilterBreakfastProtein) * filterBreakfastProtein.Calories;
    }
    if (filterBreakfastDairyAndLegumes.Name.contains('Gram')) {
      strMeal += " " +
          (amountFilterBreakfastDairyAndLegumes).toString() +
          " " +
          filterBreakfastDairyAndLegumes.Name +
          "\n";
      curcalories += (amountFilterBreakfastDairyAndLegumes / 100) *
          filterBreakfastDairyAndLegumes.Calories;
    } else {
      strMeal += " " +
          amountFilterBreakfastDairyAndLegumes.toString() +
          " " +
          filterBreakfastDairyAndLegumes.Name +
          "\n";
      curcalories += (amountFilterBreakfastDairyAndLegumes) *
          filterBreakfastDairyAndLegumes.Calories;
    }
    if (filterBreakfastVegeies.Name.contains('Gram')) {
      strMeal += " " +
          (amountFilterBreakfastVegeies).toString() +
          " " +
          filterBreakfastVegeies.Name +
          "\n";
      curcalories += (amountFilterBreakfastVegeies / 100) *
          filterBreakfastVegeies.Calories;
    } else {
      strMeal += " " +
          amountFilterBreakfastVegeies.toString() +
          " " +
          filterBreakfastVegeies.Name +
          "\n";
      curcalories +=
          (amountFilterBreakfastVegeies) * filterBreakfastVegeies.Calories;
    }
    if (filterBreakfastCarb.Name.contains('Gram')) {
      strMeal += " " +
          (amountFilterBreakfastCarb).toString() +
          " " +
          filterBreakfastCarb.Name +
          "\n";
      curcalories +=
          (amountFilterBreakfastCarb / 100) * filterBreakfastCarb.Calories;
    } else {
      strMeal += " " +
          amountFilterBreakfastCarb.toString() +
          " " +
          filterBreakfastCarb.Name +
          "\n";
      curcalories += (amountFilterBreakfastCarb) * filterBreakfastCarb.Calories;
    }
  }
  if (Filter == "breakfast") {
    bfMeals[bfMeals.length - 1] = strMeal.replaceAll("\n", "");
    Breakfast = strMeal;
    bfCalories = curcalories;
    bfCarb = filterBreakfastCarb.Carbohydrates +
        filterBreakfastDairyAndLegumes.Carbohydrates +
        filterBreakfastProtein.Carbohydrates +
        filterBreakfastVegeies.Carbohydrates;
    bfFat = filterBreakfastCarb.Fat +
        filterBreakfastDairyAndLegumes.Fat +
        filterBreakfastProtein.Fat +
        filterBreakfastVegeies.Fat;
    bfProtein = filterBreakfastCarb.Protein +
        filterBreakfastDairyAndLegumes.Protein +
        filterBreakfastProtein.Protein +
        filterBreakfastVegeies.Protein;

    //print(Breakfast);
  } else if (Filter == "lunch") {
    lMeals[lMeals.length - 1] = strMeal.replaceAll("\n", "");
    Lunch = strMeal;
    lCalories = curcalories;
    lFat = filterLunchCarb.Fat +
        filterLunchProtein.Fat +
        filterLunchVegeiesAndLegumes.Fat;
    lCarb = filterLunchCarb.Calories +
        filterLunchProtein.Calories +
        filterLunchVegeiesAndLegumes.Calories;
    lProtein = filterLunchCarb.Protein +
        filterLunchProtein.Protein +
        filterLunchVegeiesAndLegumes.Protein;

    //print(Lunch);
  } else if (Filter == "dinner") {
    dMeals[dMeals.length - 1] = strMeal.replaceAll("\n", "");
    Dinner = strMeal;
    dCalories = curcalories;
    dCarb = filterBreakfastCarb.Carbohydrates +
        filterBreakfastDairyAndLegumes.Carbohydrates +
        filterBreakfastProtein.Carbohydrates +
        filterBreakfastVegeies.Carbohydrates;
    dFat = filterBreakfastCarb.Fat +
        filterBreakfastDairyAndLegumes.Fat +
        filterBreakfastProtein.Fat +
        filterBreakfastVegeies.Fat;
    dProtein = filterBreakfastCarb.Protein +
        filterBreakfastDairyAndLegumes.Protein +
        filterBreakfastProtein.Protein +
        filterBreakfastVegeies.Protein;
    //print(Dinner);
  }
}

Future getAllMeals() async {
  var responce = await http.get(Uri.parse(GlobalUrl + 'getbreakfast'));
  var jsonData = jsonDecode(responce.body);
  for (var i in jsonData) {
    Dish dish = Dish(
        i["Category"],
        i["Name"],
        i["Calories"].toDouble(),
        i["Carbohydrates"].toDouble(),
        i["Protein"].toDouble(),
        i["Fat"].toDouble(),
        i["Meal"]);

    allMeals.add(dish);
    allMealsStr.add(dish.Name);
  }

  responce = await http.get(Uri.parse(GlobalUrl + 'getlunch'));
  jsonData = jsonDecode(responce.body);
  for (var i in jsonData) {
    Dish dish = Dish(
        i["Category"],
        i["Name"],
        i["Calories"].toDouble(),
        i["Carbohydrates"].toDouble(),
        i["Protein"].toDouble(),
        i["Fat"].toDouble(),
        i["Meal"]);

    allMeals.add(dish);
    allMealsStr.add(dish.Name);
  }

  responce = await http.get(Uri.parse(GlobalUrl + 'getsnacks'));
  jsonData = jsonDecode(responce.body);
  for (var i in jsonData) {
    Dish dish = Dish(
        i["Category"],
        i["Name"],
        i["Calories"].toDouble(),
        i["Carbohydrates"].toDouble(),
        i["Protein"].toDouble(),
        i["Fat"].toDouble(),
        i["Meal"]);

    allMeals.add(dish);
    allMealsStr.add(dish.Name);
  }
}

afterLog() {}
