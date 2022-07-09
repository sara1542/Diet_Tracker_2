import 'package:flutter/material.dart';

import '../../../globals/globalFunctions.dart';
import '../../../globals/globalVariables.dart';
import '../../../models/dish/dish_model.dart';
import '../generator/generator_screen.dart';

class LunchFilter extends StatefulWidget {
  String patientId;
  LunchFilter({Key? key,
    required this.patientId}) :
        super(key: key);

  @override
  State<LunchFilter> createState() => _LunchFilter();
}

class _LunchFilter extends State<LunchFilter> {
  void setAll() {
    cur_calories =
        (bfCalories + lCalories + dCalories + s1Calories + s2Calories).round();
    cur_carb = (bfCarb + lCarb + dCarb + s1Carb + s2Carb).round();
    cur_protein =
        (bfProtein + lProtein + dProtein + s1Protein + s2Protein).round();
    cur_fat = (bfProtein + lFat + dFat + s1Fat + s2Fat).round();
    bfCaloriesList[bfCaloriesList.length - 1] = bfCalories;
    lCaloriesList[lCaloriesList.length - 1] = (lCalories);
    dCaloriesList[dCaloriesList.length - 1] = (dCalories);
    sCaloriesList[sCaloriesList.length - 1] = (s1Calories + s2Calories);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              amountFilterLunchProtein = double.parse(value);
            },
            decoration: const InputDecoration(
              labelText: "Amount",
              fillColor: Color.fromARGB(255, 36, 189, 51),
              filled: true,
            ),
          ),
          DropdownButton<Dish>(
            //isDense: true,
            hint: Text('Choose'),
            value: filterLunchProtein,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            underline: Container(
              height: 2,
              color: Color.fromARGB(255, 36, 189, 51),
            ),
            onChanged: (Dish? newValue) {
              setState(() {
                filterLunchProtein = newValue!;
              });
            },
            items: lunchProtein.map<DropdownMenuItem<Dish>>((Dish value) {
              return DropdownMenuItem<Dish>(
                value: value,
                child: Text(value.Name),
              );
            }).toList(),
          ),
          TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              amountFilterLunchCarb = double.parse(value);
            },
            decoration: const InputDecoration(
              labelText: "Amount",
              fillColor: Color.fromARGB(255, 36, 189, 51),
              filled: true,
            ),
          ),
          DropdownButton<Dish>(
            //isDense: true,
            hint: Text('Choose'),
            value: filterLunchCarb,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            underline: Container(
              height: 2,
              color: Color.fromARGB(255, 36, 189, 51),
            ),
            onChanged: (Dish? newValue) {
              setState(() {
                filterLunchCarb = newValue!;
              });
            },
            items: lunchCarb.map<DropdownMenuItem<Dish>>((Dish value) {
              return DropdownMenuItem<Dish>(
                value: value,
                child: Text(value.Name),
              );
            }).toList(),
          ),
          TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              amountFilterLunchVegeiesAndLegumes = double.parse(value);
            },
            decoration: const InputDecoration(
              labelText: "Amount",
              fillColor: Color.fromARGB(255, 36, 189, 51),
              filled: true,
            ),
          ),
          DropdownButton<Dish>(
            //isDense: true,
            hint: Text('Choose'),
            value: filterLunchVegeiesAndLegumes,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            underline: Container(
              height: 2,
              color: Color.fromARGB(255, 36, 189, 51),
            ),
            onChanged: (Dish? newValue) {
              setState(() {
                var filterLunchVegeiesAndLegumes = newValue!;
              });
            },
            items: lunchVegeiesAndLegumes
                .map<DropdownMenuItem<Dish>>((Dish value) {
              return DropdownMenuItem<Dish>(
                value: value,
                child: Text(value.Name),
              );
            }).toList(),
          ),
          const SizedBox(
            height: 40.0,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 36, 189, 51),
            ),
            child: const Text('Save'),
            onPressed: () {
              saveChange();
              setAll();
              Navigator.pop(
                context);
            },
          ),
        ]),
      ),
    );
  }
}
