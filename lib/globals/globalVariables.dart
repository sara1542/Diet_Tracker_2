// late Position position;
import '../models/doctor.dart';
import '../models/user.dart';

List<String> doctorsVisitaUrl = [
  'https://www.vezeeta.com/ar/dr/%D8%AF%D9%83%D8%AA%D9%88%D8%B1-%D9%85%D8%A7%D9%8A%DA%A4%D9%84-%D8%A5%D9%85%D9%8A%D9%84-%D8%AA%D8%AE%D8%B3%D9%8A%D8%B3-%D9%88%D8%AA%D8%BA%D8%B0%D9%8A%D8%A9#patients-reviews',
  'https://www.vezeeta.com/ar/dr/%D8%AF%D9%83%D8%AA%D9%88%D8%B1-%D9%85%D8%AD%D9%85%D8%AF-%D8%A7%D8%AD%D9%85%D8%AF-%D9%85%D9%86%D8%B5%D9%88%D8%B1#patients-reviews'
];
List<doctor> doctors = [];
late Future f;

//List<doctor> temp = [];
var provider;
var button_provider;
user currentuser = new user.empty();
Map<String, String> authData = {
  'email': '',
  'password': '',
  'username': '',
  'confirm password': '',
  'visita url (optional)': '',
  'isdoctor': '',
  'gender': '',
  'clinic number': '',
  'case': '',
  'height': '',
  'weight': '',
  'age': '',
  'detection price': ''
};
