import 'package:firstgp/shared/styles/icon_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../globals/globalVariables.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/cache_helper.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if (isDoctor && reloadChats) {
            SocialCubit.get(context).getDoctorPatients();
          }

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
                SingleChildScrollView(child: cubit.screens[cubit.currentIndex]),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.green,
              currentIndex: cubit.currentIndex,
              onTap: (int index) {
                cubit.ChangeBottomNav(index);
              },
              items: [
                const BottomNavigationBarItem(
                    icon: Icon(
                      IconBroken.Home,
                    ),
                    label: 'Home'),
                const BottomNavigationBarItem(
                    icon: Icon(
                      IconBroken.Chat,
                    ),
                    label: 'Chats'),
                const BottomNavigationBarItem(
                    icon: Icon(
                      IconBroken.Setting,
                    ),
                    label: 'Settings'),
                !isDoctor
                    ? const BottomNavigationBarItem(
                        icon: Icon(
                          Icons.how_to_reg_sharp,
                        ),
                        label: 'doctors')
                    : const BottomNavigationBarItem(
                        icon: Icon(
                          Icons.playlist_add_circle_outlined,
                        ),
                        label: 'patients'),
              ],
            ),
          );
        });
  }
}
