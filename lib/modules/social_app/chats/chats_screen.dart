import 'package:firstgp/globals/globalVariables.dart';
import 'package:firstgp/modules/social_app/chats/chat_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/social_app/cubit/cubit.dart';
import '../../../layout/social_app/cubit/states.dart';
import '../../../shared/components/components.dart';

class ChatsScreen extends StatelessWidget {
  String receiver;
  String background = "";
  ChatsScreen({Key? key, required this.receiver}) : super(key: key);

//receiver=='chatbot'? NetworkImage('https://cdn-icons-png.flaticon.com/512/2040/2040946.png'
  //               ):NetworkImage('https://cdn4.vectorstock.com/i/1000x1000/81/88/community-logo-icon-vector-19168188.jpg'),

  @override
  Widget build(BuildContext context) {
    if (receiver == 'chatbot') {
      background = 'https://cdn-icons-png.flaticon.com/512/2040/2040946.png';
    } else {
      background =
          'https://cdn4.vectorstock.com/i/1000x1000/81/88/community-logo-icon-vector-19168188.jpg';
    }
    debugPrint('heloooooooooooo');
    return Builder(
      builder: (BuildContext context) {
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return SizedBox(
              height: 100,
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildChatItem(context, receiver),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: 1, ////////will be 2 when doctor chat is added
              ),
            );
          },
        );
      },
    );
  }

  Widget buildChatItem(context, receiver) => InkWell(
        onTap: () {
          navigateTo(
              context,
              ChatDetailsScreen(
                receiver: receiver,
              ));
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(children: [
            CircleAvatar(
                radius: 25.0, backgroundImage: NetworkImage(background)),
            const SizedBox(
              width: 15.0,
            ),
            receiver == 'community'
                ? Text(currentpatient.Case + " Community",
                    style: const TextStyle(
                      height: 1.4,
                    ))
                : const Text('chat with chatbot',
                    style: TextStyle(
                      height: 1.4,
                    ))
          ]),
        ),
      );
}
