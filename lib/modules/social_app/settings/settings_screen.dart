

import 'package:firstgp/modules/social_app/edit_profile/edit_profile_screen.dart';
import 'package:firstgp/modules/social_app/social_login/social_login_screen.dart';
import 'package:firstgp/shared/components/components.dart';
import 'package:firstgp/shared/components/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/social_app/cubit/cubit.dart';
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
    var user = cubit.userModel;
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
                 backgroundImage: NetworkImage(user.image),
               ),
             ),
            const SizedBox(
               width: 5.0,
             ),
             Padding(
               padding: const EdgeInsets.only(bottom: 50.0),
               child: Text(
                 user.name,
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
              user.weight.toString()+ ' Kg',
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
              user.height.toString()+ ' Cm',
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
              user.currentCase,
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
        ),//Height
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
              user.email,
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
                  navigateAndFinish(
                    context,
                    SocialLoginScreen(),
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
