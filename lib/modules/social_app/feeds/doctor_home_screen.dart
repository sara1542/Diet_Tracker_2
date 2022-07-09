import 'package:firstgp/globals/globalVariables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DoctorHome extends StatelessWidget {
  const DoctorHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 200.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Welcome'
                ,style: TextStyle(
                  fontSize: 40.0,
                  foreground: Paint()
                    ..style = PaintingStyle.fill
                    ..strokeWidth = 2.5
                    ..color = Colors.green[600]!,

                ),),
              SizedBox(
                height: 10.0,
              ),
              Text('Dr ' + currentdoctor.username
                ,style: TextStyle(
                  fontSize: 50.0,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 3
                    ..color = Colors.green[600]!,

                ),),
              SizedBox(
                height: 20.0,
              ),
              Text('to Dietido App'
                ,style: TextStyle(
                  fontSize: 50.0,
                  foreground: Paint()
                    ..style = PaintingStyle.fill
                    ..strokeWidth = 3
                    ..color = Colors.green[600]!,

                ),),

            ],
          ),
        ));
  }
}
