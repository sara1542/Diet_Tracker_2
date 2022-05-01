import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstgp/models/social_app/social-user_model.dart';
import 'package:firstgp/modules/social_app/social_register/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);


  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
    required bool isEmailVerified,
    required int age,
    required int height,
    required int weight,
    required String currentCase,
  })
  {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      userCreate(name: name, email: email, phone: phone, uId: value.user!.uid,isEmailVerified: isEmailVerified, age: age,
          weight: weight,
          currentCase: currentCase,
          height: height);

    })
    .catchError((error){
      emit(SocialRegisterErrorState(error.toString()));
    });

  }
  late SocialUserModel model;
  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
    required int age,
    required int height,
    required int weight,
    required String currentCase,
    bool isEmailVerified=false
}){
     model= SocialUserModel(name: name,
         email: email,
         phone: phone,
         uId: uId,
         image:'https://icon-library.com/images/anonymous-avatar-icon/anonymous-avatar-icon-25.jpg',
         isEmailVerified: isEmailVerified,
         age: age,
         weight: weight,
         currentCase: currentCase,
     height: height);
    FirebaseFirestore.instance.collection('users').doc(uId).set(model.toMap())
    .then((value) {
      emit(SocialCreateuserSuccessState());
    }).catchError((error){
      emit(SocialCreateUserErrorState(error));
    });

  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined ;

    emit(SocialRegisterChangePasswordVisibilityState());
  }
}