import 'package:firstgp/modules/social_app/chats/chat_details_screen.dart';
import 'package:firstgp/modules/social_app/chats/chats_screen.dart';
import 'package:flutter/material.dart';

class allChats extends StatelessWidget {
  allChats({Key? key}) : super(key: key);
  List recievers = ['community', 'chatbot'];
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        ChatsScreen(receiver: 'community'),
        ChatsScreen(receiver: 'chatbot'),
      ],
    );

    /*return Container(
      height: 500,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            return ChatsScreen(receiver: recievers[index]);
          }),
    );*/
  }
}
