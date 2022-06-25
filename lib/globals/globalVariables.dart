// late Position position;
import 'package:firstgp/apiServices/api.dart';
import 'package:firstgp/models/inbody.dart';
import 'package:firstgp/models/patient.dart';

import '../models/doctor.dart';
import '../models/user.dart';
import '../models/dish/dish_model.dart';

List<String> doctorsVisitaUrl = [
  'https://www.vezeeta.com/ar/dr/%D8%AF%D9%83%D8%AA%D9%88%D8%B1-%D9%85%D8%A7%D9%8A%DA%A4%D9%84-%D8%A5%D9%85%D9%8A%D9%84-%D8%AA%D8%AE%D8%B3%D9%8A%D8%B3-%D9%88%D8%AA%D8%BA%D8%B0%D9%8A%D8%A9#patients-reviews',
  'https://www.vezeeta.com/ar/dr/%D8%AF%D9%83%D8%AA%D9%88%D8%B1-%D9%85%D8%AD%D9%85%D8%AF-%D8%A7%D8%AD%D9%85%D8%AF-%D9%85%D9%86%D8%B5%D9%88%D8%B1#patients-reviews'
];
List<doctor> doctors = [];
List<patient> patients = [];
late Future f;

//List<doctor> temp = [];
var provider;
var button_provider;
user currentuser = new user.empty();

patient currentpatient=new patient.empty();
inbody currentInbody=new inbody.empty();
doctor currentdoctor= new doctor.empty();

bool isDoctor=false;

String GlobalUrl="http://192.168.1.10:6666/api/";

apiServices api = new apiServices();
String chatbotUrl = 'http://192.168.1.10:5005/webhooks/rest/webhook';
Map<String, String> authData = {
  'email': '',
  'password': '',
  'username': '',
  'confirm password': '',
  'visita url (optional)': '',
  'isdoctor': '',
  'gender': '',
  'ratingScore':'',
  'clinic number': '',
  'case': '',
  'height': '',
  'weight': '',
  'age': '',
  'image':
      'https://iptc.org/wp-content/uploads/2018/05/avatar-anonymous-300x300.png',
  'detection price': ''
};


double calories = 0.0, carb = 0.0, protein = 0.0, fat = 0.0;
double cur_calories = 0.0, cur_carb = 0.0, cur_protein = 0.0, cur_fat = 0.0;
double bfCalories = 0.0, bfCarb = 0.0, bfProtein = 0.0, bfFat = 0.0;
double lCalories = 0.0, lCarb = 0.0, lProtein = 0.0, lFat = 0.0;
double dCalories = 0.0, dCarb = 0.0, dProtein = 0.0, dFat = 0.0;
String Breakfast = "";
String Lunch = "";
String Dinner = "";
String Filter = "";
List<Dish> snacks = [];
Dish snack1 = new Dish.empty();
double amountSnack1 = 0.0;
Dish snack2 = new Dish.empty();
double amountSnack2 = 0.0;
List<Dish> breakfastProtein = [];
Dish filterBreakfastProtein = new Dish.empty();
double amountFilterBreakfastProtein = 0.0;
List<Dish> breakfastCarb = [];
Dish filterBreakfastCarb = new Dish.empty();
double amountFilterBreakfastCarb = 0.0;
List<Dish> breakfastVegeies = [];
Dish filterBreakfastVegeies = new Dish.empty();
double amountFilterBreakfastVegeies = 0.0;
List<Dish> breakfastDairyAndLegumes = [];
Dish filterBreakfastDairyAndLegumes = new Dish.empty();
double amountFilterBreakfastDairyAndLegumes = 0.0;
List<Dish> lunchProtein = [];
Dish filterLunchProtein = new Dish.empty();
double amountFilterLunchProtein = 0.0;
List<Dish> lunchCarb = [];
Dish filterLunchCarb = new Dish.empty();
double amountFilterLunchCarb = 0.0;
List<Dish> lunchVegeiesAndLegumes = [];
Dish filterLunchVegeiesAndLegumes = new Dish.empty();
double amountFilterLunchVegeiesAndLegumes = 0.0;
List<List<dynamic>> badCombo = <List<dynamic>>[];
List<List<dynamic>> bfMeals = <List<dynamic>>[];
List<List<dynamic>> lMeals = <List<dynamic>>[];
List<List<dynamic>> dMeals = <List<dynamic>>[];