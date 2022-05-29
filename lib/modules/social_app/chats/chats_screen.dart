import 'package:firstgp/globals/globalVariables.dart';
import 'package:firstgp/modules/social_app/chats/chat_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/social_app/cubit/cubit.dart';
import '../../../layout/social_app/cubit/states.dart';
import '../../../shared/components/components.dart';

class ChatsScreen extends StatelessWidget {
  String receiver;
  ChatsScreen({Key? key, required this.receiver}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildChatItem(context, receiver),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: 1, ////////will be 2 when doctor chat is added
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
            const CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage(
                  'https://cdn4.vectorstock.com/i/1000x1000/81/88/community-logo-icon-vector-19168188.jpg'),
            ),
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
