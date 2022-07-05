import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import '../../../globals/globalFunctions.dart';
import '../../../globals/globalVariables.dart';
import '../../../models/dish/dish_model.dart';
import '../generator/generator_screen.dart';

class logMeals extends StatefulWidget {
  const logMeals({Key? key}) : super(key: key);

  @override
  State<logMeals> createState() => _logMeals();
}

class _logMeals extends State<logMeals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          // ElevatedButton(
          //     style: ElevatedButton.styleFrom(
          //       primary: Color.fromARGB(255, 13, 164, 28),
          //     ),
          //     child: const Text('get Meals'),
          //     onPressed: () async {
          //       await getAllMeals();
          //     }),
          Container(
            child: GFMultiSelect(
              items: allMealsStr,
              onSelect: (value) {
                Selected = value;
              },
              dropdownTitleTileText: 'Select',
              dropdownTitleTileColor: Colors.grey[200],
              dropdownTitleTileMargin:
                  EdgeInsets.only(top: 22, left: 18, right: 18, bottom: 5),
              dropdownTitleTilePadding: EdgeInsets.all(10),
              dropdownUnderlineBorder:
                  const BorderSide(color: Colors.transparent, width: 2),
              dropdownTitleTileBorder:
                  Border.all(color: Color.fromARGB(255, 89, 84, 84), width: 1),
              dropdownTitleTileBorderRadius: BorderRadius.circular(5),
              expandedIcon: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.black54,
              ),
              collapsedIcon: const Icon(
                Icons.keyboard_arrow_up,
                color: Colors.black54,
              ),
              submitButton: Text('OK'),
              dropdownTitleTileTextStyle:
                  const TextStyle(fontSize: 14, color: Colors.black54),
              padding: const EdgeInsets.all(6),
              margin: const EdgeInsets.all(6),
              type: GFCheckboxType.basic,
              activeBgColor: Colors.green.withOpacity(0.5),
              inactiveBorderColor: Color.fromARGB(255, 158, 136, 136),
            ),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 13, 164, 28),
              ),
              child: const Text('Done'),
              onPressed: () async {
                await afterLog();
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => Generator()),
                // );
              }),
        ]),
      ),
    );
  }
}
