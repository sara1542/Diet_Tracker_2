import 'package:flutter/material.dart';

import '../../../globals/globalFunctions.dart';
import '../../../globals/globalVariables.dart';
import '../../../models/dish/dish_model.dart';
import '../generator/generator_screen.dart';

class SnacksFilter extends StatefulWidget {
  const SnacksFilter({Key? key}) : super(key: key);

  @override
  State<SnacksFilter> createState() => _SnacksFilter();
}

class _SnacksFilter extends State<SnacksFilter> {
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
              amountSnack1 = double.parse(value);
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
            value: filterSnack1,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            underline: Container(
              height: 2,
              color: Color.fromARGB(255, 36, 189, 51),
            ),
            onChanged: (Dish? newValue) {
              setState(() {
                filterSnack1 = newValue!;
              });
            },
            items: snacks.map<DropdownMenuItem<Dish>>((Dish value) {
              return DropdownMenuItem<Dish>(
                value: value,
                child: Text(value.Name),
              );
            }).toList(),
          ),
          TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              amountSnack2 = double.parse(value);
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
            value: filterSnack2,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            underline: Container(
              height: 2,
              color: Color.fromARGB(255, 36, 189, 51),
            ),
            onChanged: (Dish? newValue) {
              setState(() {
                filterSnack2 = newValue!;
              });
            },
            items: snacks.map<DropdownMenuItem<Dish>>((Dish value) {
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
              First_Snack =
                  amountSnack1.toString() + " " + filterSnack1.Name.toString();
              s1Calories = filterSnack1.Name.contains("Gram")
                  ? filterSnack1.Calories * (amountSnack1 / 100)
                  : filterSnack1.Calories * amountSnack1;
              s1Carb = filterSnack1.Name.contains("Gram")
                  ? filterSnack1.Carbohydrates * (amountSnack1 / 100)
                  : filterSnack1.Carbohydrates * amountSnack1;
              s1Protein = filterSnack1.Name.contains("Gram")
                  ? filterSnack1.Protein * (amountSnack1 / 100)
                  : filterSnack1.Protein * amountSnack1;
              s1Fat = filterSnack1.Name.contains("Gram")
                  ? filterSnack1.Fat * (amountSnack1 / 100)
                  : filterSnack1.Fat * amountSnack1;

              Second_Snack =
                  amountSnack2.toString() + " " + filterSnack2.Name.toString();
              s2Calories = filterSnack2.Name.contains("Gram")
                  ? filterSnack2.Calories * (amountSnack2 / 100)
                  : filterSnack2.Calories * amountSnack2;
              s2Carb = filterSnack2.Name.contains("Gram")
                  ? filterSnack2.Carbohydrates * (amountSnack2 / 100)
                  : filterSnack2.Carbohydrates * amountSnack2;
              s2Protein = filterSnack2.Name.contains("Gram")
                  ? filterSnack2.Protein * (amountSnack2 / 100)
                  : filterSnack2.Protein * amountSnack2;
              s2Fat = filterSnack2.Name.contains("Gram")
                  ? filterSnack2.Fat * (amountSnack2 / 100)
                  : filterSnack2.Fat * amountSnack2;

              sMeals[sMeals.length - 1] = Second_Snack;
              sMeals[sMeals.length - 1] = Second_Snack;
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
