import 'package:flutter/material.dart';

import '../globals/globalVariables.dart';
import '../layout/social_app/cubit/cubit.dart';
import '../models/doctor.dart';
import '../widgets/customContainerWidget.dart';

class doctorsScreen extends StatefulWidget {
//  final List<doctor> temp;

  //const MyApp({Key? key, required this.temp}) : super(key: key);

  @override
  _doctorsScreenState createState() => _doctorsScreenState();
}

class _doctorsScreenState extends State<doctorsScreen> {
  @override
  void initState() {
    //f = SocialCubit.get(context).getdoctors();
    tempDoctors = doctors;

    // print('%%%%%%%%%%%%%%%%%%' + tempDoctors[1].uId);
  }

  bool viewTextField = false;
  TextEditingController priceController = new TextEditingController();

  String dropdownValue = 'all';
  double inputPrice = 200;
  List<doctor> viewDoctors = [];
  List<doctor> tempDoctors = [];
  bool init = true;
  @override
  Widget build(BuildContext context) {
    print("heyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy");

    return SizedBox(
      height: 700,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Text('filter by: ',
                    style: Theme.of(context).textTheme.bodyText1),
                DropdownButton<String>(
                    value: dropdownValue,
                    focusColor: Colors.cyan,
                    onChanged: (String? value) async {
                      dropdownValue = value!;
                      viewDoctors.clear();
                      if (value == 'price') {
                        setState(() {
                          viewTextField = true;
                        });
                        print("priceeeeeeeeeeeeeeeee");
                        //List<doctor> viewDoctors = [];
                      } else if (value == 'all') {
                        viewDoctors = doctors;
                        setState(() {
                          viewTextField = false;
                          tempDoctors = viewDoctors;
                        });
                      }
                    },
                    items: <String>['all', 'price', 'nearest location']
                        .map((String val) {
                      return DropdownMenuItem(
                        value: val,
                        child: new Text(val),
                      );
                    }).toList()),
              ],
            ),
            if (viewTextField)
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                onSubmitted: (val) {
                  viewDoctors.clear();
                  inputPrice = double.parse(val);
                  double mindiff = 100000000000000;
                  int index = -1;
                  for (int i = 0; i < doctors.length; i++) {
                    print(doctors[i].price - inputPrice);
                    if ((doctors[i].price - inputPrice).abs() <= mindiff) {
                      index = i;
                      mindiff = (doctors[i].price - inputPrice).abs();
                    }
                  }
                  if (!viewDoctors.contains(doctors[index])) {
                    viewDoctors.add(doctors[index]);
                  }
                  setState(() {
                    print("vieww doctors: " + viewDoctors.toString());
                    tempDoctors = viewDoctors;
                  });
                },
              ),
            FutureBuilder<void>(
                future: SocialCubit.get(context).getdoctors(),
                builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                  List<Widget> children;
                  if (snapshot.connectionState == ConnectionState.done) {
                    tempDoctors = (init) ? doctors : tempDoctors;
                    init = false;
                    children = <Widget>[
                      SizedBox(
                        height: 400,
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: tempDoctors.length,
                            itemBuilder: (BuildContext context, int index) {
                              return CustomContainer_HomePage(
                                Doctor: tempDoctors[index],
                              );
                            }),
                      ),
                    ];
                  } else if (snapshot.hasError) {
                    children = <Widget>[
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text('Error: ${snapshot.error}'),
                      )
                    ];
                    return CircularProgressIndicator();
                  } else {
                    children = const <Widget>[
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: CircularProgressIndicator(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Text('Awaiting result...'),
                      ),
                    ];
                  }
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: children,
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
