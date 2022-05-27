

import 'package:firstgp/globals/globalVariables.dart';
import 'package:firstgp/models/patient.dart';
import 'package:firstgp/models/inbody.dart';
import 'package:firstgp/models/user.dart';
import 'package:firstgp/modules/social_app/edit_profile/edit_profile_screen.dart';
import 'package:firstgp/shared/components/components.dart';
import 'package:firstgp/shared/components/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/social_app/cubit/cubit.dart';
import '../../../screens/loginandregister.dart';
import '../edit_profile/scan_inbody_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();

}

class _SettingsScreenState extends State<SettingsScreen> {

  @override
  Widget build(BuildContext context) {
    var cubit=SocialCubit.get(context);

    setState(() {
      cubit.getUserData();
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

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
                 radius: 55.0,
                 backgroundImage: NetworkImage(currentuser.image),
               ),
             ),
            const SizedBox(
               width: 5.0,
             ),
             Padding(
               padding: const EdgeInsets.only(bottom: 50.0),
               child: Text(
                 currentpatient.username,
                 style: TextStyle(
                     fontSize: 20.0,
                     fontWeight: FontWeight.bold,
                     color: Colors.grey[600]
                 ),
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
          children:  [
            const Text(
              '  Weight:  ',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
                  ,color: Colors.blue
              ),
            ),
            Text(
              currentInbody.weight.toString()+ ' Kg',
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
                fontSize: 17.0,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        Row(
          children:  [
            const Text(
              '  Height:  ',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
                  ,color: Colors.blue
              ),
            ),
            Text(
              currentInbody.height.toString()+ ' Cm',
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
                fontSize: 17.0,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        Row(
          children:  [
            const Text(
              '  Case:     ',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
                  ,color: Colors.blue
              ),
            ),
            Text(
              currentpatient.Case,
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
                fontSize: 17.0,
              ),
            ),

          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        Row(
          children:  [
            const Text(
              '  Age:     ',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
                  ,color: Colors.blue
              ),
            ),
            Text(

              currentpatient.Age.toString(),
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
                fontSize: 17.0,
              ),
            ),

          ],
        ),
        const SizedBox(
          height: 10.0,
        ),///Height
        Row(
          children:  [
            const Text(
              '  Email:    ',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
                  ,color: Colors.blue
              ),
            ),
            Text(
              currentpatient.email,
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ), //Email
        const SizedBox(
          height: 100.0,
        ),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(

                onPressed: (){

                  Navigator.push( context, MaterialPageRoute( builder: (context) => EditProfileScreen()), ).then((value) => setState(() {}));
                },
                child: const Text('Edit Profile'),
              ),
            )
          ],
        ),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: (){
                  SocialCubit.get(context).currentIndex=0;
                 navigateAndFinish(
                    context,
                    LoginScreen(),
                  );
                  },
                child: const Text('Log Out'),
              ),
            )
          ],
        ),
      ],
    );
  }
}
