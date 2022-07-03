import 'package:firstgp/globals/globalVariables.dart';
import 'package:firstgp/layout/social_app/cubit/cubit.dart';
import 'package:firstgp/layout/social_app/social_layout.dart';
import 'package:firstgp/screens/classifier%20screen.dart';
import 'package:firstgp/screens/doctorsScreen.dart';
import 'package:flutter/material.dart';

import '../models/doctor.dart';

class doctorDetails extends StatefulWidget {
  doctor Doctor;

  doctorDetails({Key? key, required this.Doctor}) : super(key: key);

  @override
  State<doctorDetails> createState() => _doctorDetailsState();
}

class _doctorDetailsState extends State<doctorDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30),
      //margin: EdgeInsets.only(top: 20),
      color: Colors.white,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center,
          //  mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 57,
                        backgroundColor: Colors.green[400],
                        child: CircleAvatar(
                            radius: 55.0,
                            backgroundImage: NetworkImage(widget.Doctor.image)),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, bottom: 50.0),
                        child: Text(
                          widget.Doctor.username,
                          style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
                if (currentPatientDoctor == null)
                  Padding(
                    padding: EdgeInsets.only(left: 100),
                    child: FlatButton(
                        onPressed: () => {
                              api.registerAdoctor(widget.Doctor.uId),
                              setState(() {
                                currentpatient.Doctor = widget.Doctor;
                              })
                            },
                        child: Row(
                          children: [
                            Icon(
                              Icons.read_more,
                              size: 20,
                              color: Colors.green[400],
                            ),
                            Text(
                              " subsribe ",
                              style: TextStyle(
                                  fontSize: 20, color: Colors.green[400]),
                            )
                          ],
                        )),
                  ),
              ],
            ),
            Container(
              height: 1.0,
              width: double.infinity,
              color: Colors.green[400],
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Text("detection price: ",
                    style: Theme.of(context).textTheme.bodyText2),
                Text(widget.Doctor.price.toString(),
                    style: Theme.of(context).textTheme.bodyText1)
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Text("Gender: ", style: Theme.of(context).textTheme.bodyText2),
                Text(widget.Doctor.Gender,
                    style: Theme.of(context).textTheme.bodyText1)
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Text("clinic phone :",
                    style: Theme.of(context).textTheme.bodyText2),
                Text(widget.Doctor.cliniquePhone,
                    style: Theme.of(context).textTheme.bodyText1)
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Material(
              color: Colors.white,
              child: Column(
                children: [
                  if (currentPatientDoctor != null)
                    FlatButton(
                        onPressed: () => Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => classifier(
                                  doc: widget.Doctor,
                                ),
                              ),
                              (route) => false,
                            ),
                        child: Container(
                          //color: Colors.green[400]!.withOpacity(0.5),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.green[400]!.withOpacity(0.1),
                              border: Border.all(
                                width: 1,
                                color: Colors.black45,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: Text(
                              'click here to give your feedback about doctor ' +
                                  widget.Doctor.username,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      fontSize: 15, color: Colors.black45)),
                        )),
                  IconButton(
                      onPressed: () {
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
