// @dart=2.9
//null safety problem solved by previous line


import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstgp/layout/social_app/social_layout.dart';
import 'package:firstgp/modules/social_app/social_login/social_login_screen.dart';
import 'package:firstgp/shared/bloc_observer.dart';
import 'package:firstgp/shared/components/constants.dart';
import 'package:firstgp/shared/cubit/cubit.dart';
import 'package:firstgp/shared/cubit/states.dart';
import 'package:firstgp/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'layout/social_app/cubit/cubit.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  BlocOverrides.runZoned(
        () {
      AppCubit();
    },
    blocObserver: MyBlocObserver(),
  );
await CacheHelper.init();
  Widget widget;
  uId=CacheHelper.getData(key: 'uId');

 if(uId != null){
   widget=SocialLayout();
   print('111111'+uId);
 }
 else{
   widget=SocialLoginScreen();
   print('222222');
 }

  runApp(MyApp(

    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  // constructor
  // build
   Widget startWidget;

  MyApp({
    this.startWidget,
  });

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => AppCubit(),
          ),
          BlocProvider(
        create: (BuildContext context)=>SocialCubit()..getUserData(),
          )  ],
        child: BlocConsumer<AppCubit,AppStates>(
          listener: (context,state){

           // debugPrint('Current state: ' +state.toString());
          },
          builder: (context,state){
          //  SocialCubit.get(context).getUserData();
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: startWidget,
            );
          },
        )
    );
  }


}

// MultiBlocProvider(
// providers: [
// BlocProvider(
// create: (BuildContext context) => AppCubit(),
// ),
// BlocProvider(
// create: (BuildContext context)=>SocialCubit()..getUserData(),
// )  ],
// child: BlocConsumer<AppCubit,AppStates>(
// listener: (context,state){
//
// debugPrint('Current state: ' +state.toString());
// },
// builder: (context,state){
// SocialCubit.get(context).getUserData();
// return MaterialApp(
// debugShowCheckedModeBanner: false,
// home: startWidget,
// );
// },
// )
// );