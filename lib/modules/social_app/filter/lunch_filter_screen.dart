import 'package:flutter/material.dart';

import '../../../globals/globalFunctions.dart';
import '../../../globals/globalVariables.dart';
import '../../../models/dish/dish_model.dart';
import '../generator/generator_screen.dart';

class LunchFilter extends StatefulWidget {
  const LunchFilter({Key? key}) : super(key: key);

  @override
  State<LunchFilter> createState() => _LunchFilter();
}

class _LunchFilter extends State<LunchFilter> {
  void setAll() {

      cur_calories = bfCalories + lCalories + dCalories;
      cur_carb = bfCarb + lCarb + dCarb;
      cur_protein = bfProtein + lProtein + dProtein;
      cur_fat = bfProtein + lFat + dFat;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const SizedBox(
              width: 20.0,
            ),
            Flexible(
              child: TextField(
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
            ),
            const SizedBox(
              width: 20.0,
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
            const SizedBox(
              width: 20.0,
            ),
          ]),
        ),
        Container(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const SizedBox(
              width: 20.0,
            ),
            Flexible(
              child: TextField(
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
            ),
            const SizedBox(
              width: 20.0,
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
            const SizedBox(
              width: 20.0,
            ),
          ]),
        ),
        Container(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const SizedBox(
              width: 20.0,
            ),
            Flexible(
              child: TextField(
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
            ),
            const SizedBox(
              width: 20.0,
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
              width: 20.0,
            ),
          ]),
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Generator()),
            );
          },
        ),
      ]),
    );
  }
}
