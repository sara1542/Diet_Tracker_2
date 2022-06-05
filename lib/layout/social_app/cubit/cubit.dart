import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firstgp/apiServices/api.dart';
import 'package:firstgp/globals/globalVariables.dart';
import 'package:firstgp/layout/social_app/cubit/states.dart';
import 'package:firstgp/models/patient.dart';
import 'package:firstgp/models/social_app/chat_model.dart';

import 'package:firstgp/models/social_app/social-user_model.dart';
import 'package:firstgp/modules/social_app/chats/chats_screen.dart';
import 'package:firstgp/modules/social_app/chats/displayChats.dart';
import 'package:firstgp/modules/social_app/feeds/feeds_screen.dart';
import 'package:firstgp/modules/social_app/settings/settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../screens/doctorsScreen.dart';
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
    }).catchError((error) {
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
    //ChatsScreen(receiver: 'community'),
    //ChatsScreen(receiver: 'chatbot'),
    allChats(),
    SettingsScreen(),
    doctorsScreen()
  ];

  void ChangeBottomNav(int index) {
    if (index == 1) {
      getPatientsOfSameCase();
    }
    if (index == 2) {
      getUserData();
    }
    currentIndex = index;
    emit(SocialChangeBottomNavState());
  }

  List<String> titles = ['News Feed', 'Chats', 'Settings', 'doctors'];

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
    required int age,
  }) {
    emit(SocialUserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        currentuser.image = value;
        updateUserProfile(name: name, email: email, image: value, age: age);
      }).catchError((error) {});
      emit(SocialUploadProfileImageErrorState());
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
      print(error);
    });
  }

  Dio dio = new Dio();

  Future<int?> updateUserProfile(
      {required String name,
      required String email,
      required int age,
      String? image}) async {
    emit(SocialUserUpdateLoadingState());
    final response = await dio.put(GlobalUrl + "updatepatient",
        data: json.encode(<String, dynamic>{
          "_id": currentuser.uId,
          "username": name,
          "email": email,
          "age": age,
          "Case": currentpatient.Case,
          "image": image ?? currentpatient.image,
        }));
    if (response.statusCode == 200 && response.statusMessage == 'OK') {
      print("Patient updated successfully");
      currentpatient.image = image ?? currentpatient.image;
      currentuser.image = image ?? currentpatient.image;
      currentpatient.username = name;
      currentpatient.email = email;
      currentpatient.Age = age;

      emit(SocialUserUpdateSuccessState());
      return response.statusCode;
    } else {
      throw Exception('failed to update patient' + response.statusMessage!);
    }
  }

  Future<int?> updateUserInBody(
      {required double height,
      required double weight,
      required num PBF,
      required num PBW}) async {
    emit(SocialUserUpdateLoadingState());
    print("entered inbody update");
    print(height.toString() +
        " " +
        weight.toString() +
        " " +
        PBF.toString() +
        " " +
        PBW.toString());
    final response = await dio.put(GlobalUrl + "updateinbody",
        data: json.encode(<String, dynamic>{
          "_id": currentuser.uId,
          "height": height,
          "weight": weight,
          "BMI": weight / (height / 100.0),
          "PBF": PBF,
          "PBW": PBW,
        }));
    if (response.statusCode == 200 && response.statusMessage == 'OK') {
      print("Patient updated successfully");
      currentInbody.height = height;
      currentInbody.weight = weight;
      currentInbody.BMI = weight / (height / 100.0);
      currentInbody.PBF = PBF;
      currentInbody.PBW = PBW;
      emit(SocialUserUpdateSuccessState());
      return response.statusCode;
    } else {
      throw Exception(
          'failed to update patient inbody' + response.statusMessage!);
    }
  }

  List<patient> patientsOfSameCase = [];
  Future<void> getdoctors() async {
    await api.getdoctors();
  }

  // Future<void> getpatients() async {
  //   await api.getpatients();
  // }
  Future<int?> getPatientsOfSameCase() async {
    patientsOfSameCase = [];

    final response = await dio.get(
      GlobalUrl + "getpatients",
    );

    if (response.statusCode == 200) {
      patients = (response.data['patients'] as List)
          .map((data) => patient.fromJson(data))
          .toList();

      //returning patients of same case for chatroom
      for (int i = 0; i < patients.length; i++) {
        if (patients[i].Case == currentpatient.Case &&
            patients[i].uId != currentpatient.uId) {
          print(
              "^^^^^^^^^^^^^^^^^^" + currentuser.uId + "  " + patients[i].uId);
          patientsOfSameCase.add(patients[i]);
        }
        emit(SocialGetAllUsersSuccessState());
      }
      return response.statusCode;
    } else {
      throw Exception('failed to get patients');
    }
  }

  void sendMessageTogroup({
    required String dateTime,
    required String text,
  }) {
    MessageModel model = MessageModel(
        senderId: currentpatient.uId,
        receiverId: currentpatient.Case,
        dateTime: dateTime,
        text: text);
    model.imageOfSender = currentpatient.image;

    //set my chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentpatient.Case)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessages() {
    for (int i = 0; i < patientsOfSameCase.length; i++) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(currentpatient.Case)
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

  bool isfirstMessage = true;
  // Dio dio = new Dio();
  String chatbotMessage = "";
  void sendMessageToChatbot({
    required String dateTime,
    required String text,
  }) {
    MessageModel model = MessageModel(
        senderId: userModel.uId,
        receiverId: 'chatBot',
        dateTime: dateTime,
        text: text);

    //set my chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .collection('chats')
        .doc('chatBot')
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).then((value) async {
      debugPrint('sending message to chatbot' + currentpatient.uId);
      if (isfirstMessage) text += ' ' + currentpatient.uId;
      isfirstMessage = false;
      debugPrint('text is : ' + text);
      final response = await dio.post(chatbotUrl,
          //options: Options(headers: {"Content-Type": "application/json"}),
          data: json.encode(<String, String>{
            "message": text,
            "sender": currentpatient.username,
          }));
      debugPrint(response.toString() + response.statusCode.toString());
      //currentuser.fromJson(response.data);
      if (response.statusCode == 200) {
        debugPrint("##############333");
        debugPrint("in chatbot message" + response.data[0]["text"]);
        chatbotMessage = (response.data[0]["text"]);
      } else {
        emit(SocialSendMessageErrorState());
      }
    }).then((value) {
      MessageModel botModel = MessageModel(
          senderId: 'chatBot',
          receiverId: currentpatient.uId,
          dateTime: dateTime,
          text: chatbotMessage);

      FirebaseFirestore.instance
          .collection('users')
          .doc('chatBot')
          .collection('chats')
          .doc(currentpatient.uId)
          .collection('messages')
          .add(botModel.toMap())
          .then((value) {
        emit(SocialSendMessageSuccessState());
      });
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });

    //set receiver chat
    FirebaseFirestore.instance
        .collection('users')
        .doc('chatBot')
        .collection('chats')
        .doc(currentpatient.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
  }

  // List<MessageModel> messages = [];

  void getMessagesfromChatbot() {
    FirebaseFirestore.instance
        .collection('users')
        .doc('chatBot')
        .collection('chats')
        .doc(currentpatient.uId)
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
