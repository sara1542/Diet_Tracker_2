import 'package:firstgp/globals/globalVariables.dart';
import 'package:firstgp/layout/social_app/cubit/cubit.dart';
import 'package:firstgp/layout/social_app/social_layout.dart';
import 'package:firstgp/screens/classifier%20screen.dart';
import 'package:firstgp/screens/doctorsScreen.dart';
import 'package:flutter/material.dart';

import '../models/doctor.dart';

class doctorDetails extends StatelessWidget {
  doctor Doctor;

  doctorDetails({Key? key, required this.Doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 10),
      color: Colors.white,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 57,
                backgroundColor: Colors.blue[200],
                child: CircleAvatar(
                    radius: 55.0, backgroundImage: NetworkImage(Doctor.image)),
              ),
              const SizedBox(
                width: 5.0,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: Text(
                  Doctor.username,
                  style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 3.0,
        ),
        Container(
          height: 1.0,
          width: double.infinity,
          color: Colors.blue,
        ),
        const SizedBox(
          height: 50.0,
        ),
        Row(
          children: [
            Text("detection price: ",
                style: Theme.of(context).textTheme.bodyText2),
            Text(Doctor.price.toString(),
                style: Theme.of(context).textTheme.bodyText1)
          ],
        ),
        const SizedBox(
          height: 50.0,
        ),
        Row(
          children: [
            Text("Gender: ", style: Theme.of(context).textTheme.bodyText2),
            Text(Doctor.Gender, style: Theme.of(context).textTheme.bodyText1)
          ],
        ),
        const SizedBox(
          height: 50.0,
        ),
        Row(
          children: [
            Text("clinic phone :",
                style: Theme.of(context).textTheme.bodyText2),
            Text(Doctor.cliniquePhone,
                style: Theme.of(context).textTheme.bodyText1)
          ],
        ),
        const SizedBox(
          height: 50.0,
        ),
        FlatButton(
            onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => classifier(
                      doc: Doctor,
                    ),
                  ),
                  (route) => false,
                ),
            child: Text('give your feedback about doctor ' + Doctor.username,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 15, color: Colors.blueAccent[100]))),
        Material(
          color: Colors.white,
          child: Column(
            children: [
              FlatButton(
                  onPressed: () => api.registerAdoctor(Doctor.uId),
                  child: Row(
                    children: [
                      Icon(
                        Icons.read_more,
                        size: 20,
                        color: Colors.green[400],
                      ),
                      Text(
                        " subsribe",
                        style:
                            TextStyle(fontSize: 20, color: Colors.green[400]),
                      )
                    ],
                  )),
              IconButton(
                  onPressed: ()  {
                   SocialCubit.get(context).addPatientToDoctorList(doctorUID: Doctor.uId);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const SocialLayout(),
                        ),
                        (route) => false,
                      );
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.green[400],
                    size: 50,
                  )),
            ],
          ),
        )
      ]),
    );
  }


}
