import 'package:firstgp/modules/social_app/generator/generator_screen.dart';
import 'package:flutter/material.dart';

import '../../../globals/globalFunctions.dart';
import '../../../globals/globalVariables.dart';
import '../../../models/dish/dish_model.dart';

class BreakfastFilter extends StatefulWidget {
  const BreakfastFilter({Key? key}) : super(key: key);

  @override
  State<BreakfastFilter> createState() => _BreakfastFilter();
}

class _BreakfastFilter extends State<BreakfastFilter> {
  void setAll() {
    cur_calories =
        (bfCalories + lCalories + dCalories + s1Calories + s2Calories).round();
    cur_carb = (bfCarb + lCarb + dCarb + s1Carb + s2Carb).round();
    cur_protein =
        (bfProtein + lProtein + dProtein + s1Protein + s2Protein).round();
    cur_fat = (bfProtein + lFat + dFat + s1Fat + s2Fat).round();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              amountFilterBreakfastProtein = double.parse(value);
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
            value: filterBreakfastProtein,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            underline: Container(
              height: 2,
              color: Color.fromARGB(255, 36, 189, 51),
            ),
            onChanged: (Dish? newValue) {
              setState(() {
                filterBreakfastProtein = newValue!;
              });
            },
            items: breakfastProtein.map<DropdownMenuItem<Dish>>((Dish value) {
              return DropdownMenuItem<Dish>(
                value: value,
                child: Text(value.Name),
              );
            }).toList(),
          ),
          TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              amountFilterBreakfastCarb = double.parse(value);
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
            value: filterBreakfastCarb,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            underline: Container(
              height: 2,
              color: Color.fromARGB(255, 36, 189, 51),
            ),
            onChanged: (Dish? newValue) {
              setState(() {
                filterBreakfastCarb = newValue!;
              });
            },
            items: breakfastCarb.map<DropdownMenuItem<Dish>>((Dish value) {
              return DropdownMenuItem<Dish>(
                value: value,
                child: Text(value.Name),
              );
            }).toList(),
          ),
          TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              amountFilterBreakfastVegeies = double.parse(value);
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
            value: filterBreakfastVegeies,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            underline: Container(
              height: 2,
              color: Color.fromARGB(255, 36, 189, 51),
            ),
            onChanged: (Dish? newValue) {
              setState(() {
                filterBreakfastVegeies = newValue!;
              });
            },
            items: breakfastVegeies.map<DropdownMenuItem<Dish>>((Dish value) {
              return DropdownMenuItem<Dish>(
                value: value,
                child: Text(value.Name),
              );
            }).toList(),
          ),
          TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              amountFilterBreakfastDairyAndLegumes = double.parse(value);
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
            value: filterBreakfastDairyAndLegumes,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            underline: Container(
              height: 2,
              color: Color.fromARGB(255, 36, 189, 51),
            ),
            onChanged: (Dish? newValue) {
              setState(() {
                filterBreakfastDairyAndLegumes = newValue!;
              });
            },
            items: breakfastDairyAndLegumes
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
            onPressed: () async {
              await saveChange();
              setAll();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Generator()),
              );
            },
          ),
        ]),
      ),
    );
  }
}
