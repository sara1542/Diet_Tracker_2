import 'dart:ffi';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstgp/layout/social_app/cubit/states.dart';
import 'package:firstgp/models/social_app/chat_model.dart';

import 'package:firstgp/models/social_app/social-user_model.dart';
import 'package:firstgp/modules/social_app/chats/chats_screen.dart';
import 'package:firstgp/modules/social_app/feeds/feeds_screen.dart';
import 'package:firstgp/modules/social_app/settings/settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../shared/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  UserModel userModel = UserModel(
      name: 'name',
      email: 'email',
      phone: 'phone',
      uId: 'uId',
      image: 'image',
      isEmailVerified: false,
      currentCase: 'currentCase',
      height: 160,
      weight: 90,
      age: 30);

  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data() ?? userModel.toMap());
      emit(SocialGetUserSuccessState());
      print('yessssssssssssssssssssssssss');
    }).catchError((error) {
      print('npooooooooooooooooooooooooooooo');
      print(error.toString());
      emit(SocialGetUserErrorState(error));
    });
  }

  void verifyEmailSuccessfully() {
    emit(SocialVerifyUserEmailState());
  }

  int currentIndex = 0;
  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    SettingsScreen(),
  ];

  void ChangeBottomNav(int index) {
    if (index == 1) {
      getUsers();
    }
    if (index == 2) {
      getUserData();
    }
    currentIndex = index;
    emit(SocialChangeBottomNavState());
  }

  List<String> titles = ['News Feed', 'Chats', 'Settings'];

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('no image selected');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  String profileImageUrl = '';

  void uploadProfileImage({
    required String name,
    required String email,
  }) {
    emit(SocialUserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //emit(SocialUploadProfileImageSuccessState());
        userModel.image = value;
        updateUserProfile(name: name, email: email, image: value);
      }).catchError((error) {});
      emit(SocialUploadProfileImageErrorState());
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
      print(error);
    });
  }

  void updateUserProfile(
      {required String name, required String email, String? image}) {
    // if(profileImage!=null){
    //   uploadProfileImage();
    //
    // }
    // else{
    //   profileImageUrl=userModel.image;
    // }
    userModel.name = name;
    userModel.email = email;
    UserModel model = UserModel(
      name: name,
      email: email,
      phone: userModel.phone,
      uId: userModel.uId,
      image: image ?? userModel.image,
      isEmailVerified: userModel.isEmailVerified,
      age: userModel.age,
      weight: userModel.weight,
      height: userModel.height,
      currentCase: userModel.currentCase,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .update(model.toMap())
        .then((value) {
      //getUserData();
      emit(SocialUserUpdateSuccessState());
    }).catchError((error) {});
  }

  List<UserModel> users = [];

  void getUsers() {
    users = [];
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['uId'] != uId) {
          users.add(UserModel.fromJson(element.data()));
          print('hhhhhhhhhhhhhhhhhh');
          print(element.data());
        }
      });

      emit(SocialGetAllUsersSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetAllUsersErrorState(error));
    });
  }
  // void getUsers(){
  //   if(users.length==0) {
  //     FirebaseFirestore.instance
  //         .collection('users')
  //         .snapshots()
  //         .listen((event)
  //     {
  //       users=[];
  //       event.docs.forEach((element) {
  //         if(element.data()['uId']!=userModel.uId) {
  //         users.add(SocialUserModel.fromJson(element.data()));
  //         }
  //       });
  //       emit(SocialGetAllUsersSuccessState());
  //     });
  //   }
  // }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    MessageModel model = MessageModel(
        senderId: userModel.uId,
        receiverId: receiverId,
        dateTime: dateTime,
        text: text);

    //set my chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });

    //set receiver chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessages({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(SocialGetMessagesSuccessState());
    });
  }
}
