import 'package:firstgp/globals/globalVariables.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../layout/social_app/cubit/cubit.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (!isDoctor)
        ? FutureBuilder<void>(
            future: SocialCubit.get(context).getPatientMeals(),
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              List<Widget> children;
              if (snapshot.connectionState == ConnectionState.done) {
                children = <Widget>[
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        getmeal("Breakfast", patientmeal.breakfast,
                            const Icon(Icons.breakfast_dining_outlined)),
                        const SizedBox(
                          height: 15,
                        ),
                        getmeal("Lunch", patientmeal.lunch,
                            const Icon(Icons.lunch_dining_outlined)),
                        const SizedBox(
                          height: 15,
                        ),
                        getmeal("Dinner", patientmeal.dinner,
                            const Icon(Icons.dinner_dining)),
                        const SizedBox(
                          height: 15,
                        ),
                        getmeal("Snacks", patientmeal.snacks,
                            const Icon(Icons.food_bank_outlined)),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  )
                ];
              } else if (snapshot.hasError) {
                children = <Widget>[
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('no meals'),
                  )
                ];
                return const CircularProgressIndicator();
              } else {
                children = <Widget>[
                  Center(
                    child: Column(
                      children: const [
                        CircularProgressIndicator(),
                        Text('Awaiting result...')
                      ],
                    ),
                  )
                ];
              }
              return Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: children,
                ),
              );
            })
        : const Text("");
  }
}

Widget getmeal(String title, String content, Icon icon) => Container(
      color: Colors.white70,
      child: Column(children: [
        Row(
          children: [icon, const SizedBox(width: 10), Text(title)],
        ),
        const SizedBox(
          height: 15,
          width: double.infinity,
          child: Divider(
            color: Colors.black45,
          ),
        ),
        content != null ? Text(content) : Text("no meal today"),
        const SizedBox(
          height: 10,
        )
      ]),
    );
