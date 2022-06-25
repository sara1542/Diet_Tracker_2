// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ffi';

import '../../../globals/globalFunctions.dart';
import '../../../globals/globalVariables.dart';
import '../../../models/dish/dish_model.dart';
import '../filter/breakfast_filter_screen.dart';
import '../filter/lunch_filter_screen.dart';

class Generator extends StatefulWidget {
  const Generator({Key? key}) : super(key: key);

  @override
  State<Generator> createState() => _Generator();
}

class _Generator extends State<Generator> {
  generateMeals() {
    setState(() {
      Breakfast = generateBreakfastMeals();


      Lunch = generateLunchMeals();


      Dinner = generateDinnerMeals();



      cur_calories = bfCalories + lCalories + dCalories;
      cur_carb = bfCarb + lCarb + dCarb;
      cur_protein = bfProtein + lProtein + dProtein;
      cur_fat = bfProtein + lFat + dFat;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: const Text(
          "Meals Generator",
          style: TextStyle(fontSize: 20.0),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:
        Column(
              mainAxisAlignment: MainAxisAlignment.center, children: <
              Widget>[
            Container(
              child: Row(children: [
                const SizedBox(
                  width: 20.0,
                ),
                Flexible(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      calories = double.parse(value);
                    },
                    decoration: const InputDecoration(
                      labelText: "Calories",
                      fillColor: Colors.green,
                      //filled: true,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Flexible(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      carb = double.parse(value);
                    },
                    decoration: const InputDecoration(
                      //filled: true,
                      labelText: "Carb",
                      fillColor: Colors.green,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Flexible(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      protein = double.parse(value);
                    },
                    decoration: const InputDecoration(
                      fillColor: Colors.green,
                      //filled: true,
                      labelText: "Protein",
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Flexible(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      fat = double.parse(value);
                    },
                    decoration: const InputDecoration(
                      fillColor: Colors.green,
                      //filled: true,
                      labelText: "Fat",
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
              ]),
            ),

            const SizedBox(
              height: 20.0,
            ),
            Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5))),

                width: MediaQuery.of(context).size.width / 1.1,
                child: Column(
                  children: [

                          Text("Calories: $cur_calories",style: const TextStyle(fontSize: 15.0),),
                          Text("Carbohydrates: $cur_carb",style: const TextStyle(fontSize: 15.0)),
                          Text("Protein: $cur_protein",style: const TextStyle(fontSize: 15.0)),
                          Text("Fat: $cur_fat",style: const TextStyle(fontSize: 15.0)),

                  ],
                )),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              decoration: const BoxDecoration(
                // color: Color.fromARGB(255, 36, 189, 51),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              height: 50,
              width: MediaQuery.of(context).size.width / 1.1,
              child: Row(children: [
                const SizedBox(
                  width: 10.0,
                ),
                ElevatedButton(
                  child: const Text('Filter'),
                  onPressed: () {
                    Filter = "breakfast";
                    createBadCombination(Breakfast);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BreakfastFilter()),
                    );
                  },
                ),
                Text(" Breakfast:\n $Breakfast",
                  style: TextStyle(fontSize: 15.0),
                 ),
              ]),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              decoration: const BoxDecoration(
                // color: Color.fromARGB(255, 36, 189, 51),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              height: 50,
              width: MediaQuery.of(context).size.width / 1.1,
              child: Row(children: [
                const SizedBox(
                  width: 10.0,
                ),
                ElevatedButton(
                  child: const Text('Filter'),
                  onPressed: () {
                    Filter = "lunch";
                    createBadCombination(Lunch);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LunchFilter()),
                    );
                  },
                ),
                Text(" Lunch:\n $Lunch",style: TextStyle(fontSize: 15.0),),
              ]),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              decoration: const BoxDecoration(
                //  color: Color.fromARGB(255, 36, 189, 51),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              height: 50,
              width: MediaQuery.of(context).size.width / 1.1,
              child: Row(children: [
                const SizedBox(
                  width: 10.0,
                ),
                ElevatedButton(
                  child: const Text('Filter'),
                  onPressed: () {
                    Filter = "Dinner";
                    createBadCombination(Dinner);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BreakfastFilter()),
                    );
                  },
                ),
                Text(" Dinner:\n $Dinner",style: TextStyle(fontSize: 15.0),),
              ]),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.1,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 20.0,
                    ),
                    Flexible(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          amountSnack1 = double.parse(value);
                        },
                        decoration: const InputDecoration(
                          hintText: "1",
                          fillColor: Colors.green,
                          //filled: true,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    DropdownButton<Dish>(
                      //isDense: true,
                      hint: Text('Choose'),
                      value: snack1,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      underline: Container(
                        height: 2,
                        color: Color.fromARGB(255, 36, 189, 51),
                      ),
                      onChanged: (Dish? newValue) {
                        setState(() {
                          snack1 = newValue!;
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
                      width: 20.0,
                    ),
                  ]),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.1,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 20.0,
                    ),
                    Flexible(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          amountSnack2 = double.parse(value);
                        },
                        decoration: const InputDecoration(
                          hintText: "1",
                          fillColor: Colors.green,
                          //filled: true,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    DropdownButton<Dish>(
                      //isDense: true,
                      hint: Text('Choose'),
                      value: snack2,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      underline: Container(
                        height: 2,
                        color: Color.fromARGB(255, 36, 189, 51),
                      ),
                      onChanged: (Dish? newValue) {
                        setState(() {
                          snack2 = newValue!;
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
                      width: 20.0,
                    ),
                  ]),
            ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 36, 189, 51),
                ),
                child: const Text('Generate'),
                onPressed: () async {
                  await getMeals();
                  // await Future.delayed(const Duration(seconds: 2), () {});
                  await generateMeals();
                }),
          ]),


      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
