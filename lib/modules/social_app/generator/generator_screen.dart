import 'package:firstgp/modules/social_app/filter/snack_filter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ffi';

import '../../../globals/globalFunctions.dart';
import '../../../globals/globalVariables.dart';
import '../../../globals/globalwidgets.dart';
import '../../../models/dish/dish_model.dart';
import '../filter/breakfast_filter_screen.dart';
import '../filter/lunch_filter_screen.dart';

class Generator extends StatefulWidget {
  String patientId;
  Generator({Key? key, required this.patientId}) : super(key: key);
  String text = 'Generate';
  bool isPressed=false;
  @override
  State<Generator> createState() => _Generator();
}

class _Generator extends State<Generator> {
  generateMeals() {
    setState(() {
      Breakfast = generateBreakfastMeals();
      Lunch = generateLunchMeals();

      Dinner = generateDinnerMeals();

      cur_calories =
          (bfCalories + lCalories + dCalories + s1Calories + s2Calories)
              .round();
      cur_carb = (bfCarb + lCarb + dCarb + s1Carb + s2Carb).round();
      cur_protein =
          (bfProtein + lProtein + dProtein + s1Protein + s2Protein).round();
      cur_fat = (bfProtein + lFat + dFat + s1Fat + s2Fat).round();

      generateSnacks();

      cur_calories =
          (bfCalories + lCalories + dCalories + s1Calories + s2Calories)
              .round();
      cur_carb = (bfCarb + lCarb + dCarb + s1Carb + s2Carb).round();
      cur_protein =
          (bfProtein + lProtein + dProtein + s1Protein + s2Protein).round();
      cur_fat = (bfProtein + lFat + dFat + s1Fat + s2Fat).round();
      bfCaloriesList.add(bfCalories);
      lCaloriesList.add(lCalories);
      dCaloriesList.add(dCalories);
      sCaloriesList.add(s1Calories + s2Calories);
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
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    caloriesBurnt = double.parse(value);
                  },
                  decoration: const InputDecoration(
                    labelText: "Calories To Be Burnt",
                    fillColor: Colors.green,
                    //filled: true,
                  ),
                ),
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
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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

               if(widget.isPressed)
                 Text('Day '+counter.toString()),
                if(widget.isPressed)  const SizedBox(
                   height: 20.0,
                 ),
                if(widget.isPressed) Container(
                     decoration: const BoxDecoration(
                         borderRadius: BorderRadius.all(Radius.circular(5))),
                     width: MediaQuery.of(context).size.width / 1.1,
                     child: Column(
                       children: [
                         Text(
                           "Calories: $cur_calories",
                           style: const TextStyle(fontSize: 15.0),
                         ),
                         Text("Carbohydrates: $cur_carb",
                             style: const TextStyle(fontSize: 15.0)),
                         Text("Protein: $cur_protein",
                             style: const TextStyle(fontSize: 15.0)),
                         Text("Fat: $cur_fat",
                             style: const TextStyle(fontSize: 15.0)),
                       ],
                     )),
                if(widget.isPressed) const SizedBox(
                   height: 20.0,
                 ),
                if(widget.isPressed) Text(
                   " Breakfast:\n $Breakfast",
                   style: TextStyle(fontSize: 13.0),
                 ),
                if(widget.isPressed)  ElevatedButton(
                   child: const Text('Filter'),
                   onPressed: () {
                     Filter = "breakfast";
                     createBadCombination(Breakfast);
                     Navigator.push(
                       context,
                       MaterialPageRoute(
                           builder: (context) => BreakfastFilter(
                             patientId: widget.patientId,
                           )),
                     );
                   },
                 ),
                if(widget.isPressed)  const SizedBox(
                   height: 20.0,
                 ),
                if(widget.isPressed) Text(
                   " Lunch:\n $Lunch",
                   style: TextStyle(fontSize: 13.0),
                 ),
                if(widget.isPressed)ElevatedButton(
                   child: const Text('Filter'),
                   onPressed: () {
                     Filter = "lunch";
                     createBadCombination(Lunch);
                     Navigator.push(
                       context,
                       MaterialPageRoute(
                           builder: (context) => LunchFilter(
                             patientId: widget.patientId,
                           )),
                     );
                   },
                 ),
                if(widget.isPressed)const SizedBox(
                   height: 20.0,
                 ),
                if(widget.isPressed) Text(
                   " Dinner:\n $Dinner",
                   style: TextStyle(fontSize: 13.0),
                 ),
                if(widget.isPressed) ElevatedButton(
                   child: const Text('Filter'),
                   onPressed: () {
                     Filter = "dinner";
                     createBadCombination(Dinner);
                     Navigator.push(
                       context,
                       MaterialPageRoute(
                           builder: (context) => BreakfastFilter(
                             patientId: widget.patientId,
                           )),
                     );
                   },
                 ),
                if(widget.isPressed) const SizedBox(
                   height: 20.0,
                 ),
                if(widget.isPressed)Text(
                   " First Snack:\n $First_Snack",
                   style: TextStyle(fontSize: 13.0),
                 ),
                if(widget.isPressed) const SizedBox(
                   height: 20.0,
                 ),
                if(widget.isPressed)Text(
                   " Second Snack:\n $Second_Snack",
                   style: TextStyle(fontSize: 13.0),
                 ),
                if(widget.isPressed) ElevatedButton(
                   child: const Text('Filter'),
                   onPressed: () {
                     Navigator.push(
                       context,
                       MaterialPageRoute(
                           builder: (context) => SnacksFilter(
                             patientId: widget.patientId,
                           )),
                     );
                   },
                 ),
                if(widget.isPressed) const SizedBox(
                   height: 20.0,
                 ),
                 ElevatedButton(
                     style: ElevatedButton.styleFrom(
                       primary: Color.fromARGB(255, 36, 189, 51),
                     ),
                     child: Text(widget.text),
                     onPressed: () async {
                       if(!widget.isPressed) {
                         widget.isPressed = true;
                         setState(() {});
                       }
                       await getMeals();
                       // await Future.delayed(const Duration(seconds: 2), () {});
                       await generateMeals();
                       counter++;
                       if (counter == 7) {
                         widget.text = 'Save';
                         setState(() {});
                       }
                       if (counter == 8) {
                         await createDiet(widget.patientId);
                         showToast(true, 'Meals saved successfully');
                         setAllMealsToZero();
                         Navigator.pop(context);
                       }
                     }),

              ]),
        ),
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
