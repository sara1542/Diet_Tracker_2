
import 'package:firstgp/shared/styles/icon_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/constants.dart';
import '../../shared/network/local/cache_helper.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(listener: (context, state) {
      /*  if (FirebaseAuth.instance.currentUser!.emailVerified) {
        SocialCubit.get(context).userModel.isEmailVerified = true;
        FirebaseFirestore.instance
            .collection('users')
            .doc(SocialCubit.get(context).userModel.uId)
            .update({'isEmailVerified': true});
      }
      print('Current state: ' + state.toString());*/
    }, builder: (context, state) {
      CacheHelper.init();
      uId = CacheHelper.getData(key: 'uId');
      var cubit = SocialCubit.get(context);
      return Scaffold(
        appBar: AppBar(
          title: Text(cubit.titles[cubit.currentIndex]),
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(IconBroken.Notification))
          ],
        ),
        body:

            cubit.screens[cubit.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.green,
          currentIndex: cubit.currentIndex,
          onTap: (int index) {
            cubit.ChangeBottomNav(index);
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Home,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Chat,
                ),
                label: 'Chats'),
            BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Setting,
                ),
                label: 'Settings'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.how_to_reg_sharp,
                ),
                label: 'doctors'),
          ],
        ),
      );
    });
  }
}
