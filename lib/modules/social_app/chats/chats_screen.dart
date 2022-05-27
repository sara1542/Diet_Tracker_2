import 'package:firstgp/globals/globalVariables.dart';
import 'package:firstgp/models/patient.dart';
import 'package:firstgp/models/social_app/social-user_model.dart';
import 'package:firstgp/modules/social_app/chats/chat_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/social_app/cubit/cubit.dart';
import '../../../layout/social_app/cubit/states.dart';
import '../../../shared/components/components.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  buildChatItem(context),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: 1,  ////////will be 2 when doctor chat is added
            );
          },
        );
      },
    );
  }

  Widget buildChatItem(context) => InkWell(
        onTap: () {
          navigateTo(context, ChatDetailsScreen());
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(children: [
            const CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage(
                'https://cdn4.vectorstock.com/i/1000x1000/81/88/community-logo-icon-vector-19168188.jpg'
              ),
            ),
            const SizedBox(
              width: 15.0,
            ),
            Text(
              currentpatient.Case+ " Community",
              style: const TextStyle(
                height: 1.4,
              ),
            ),
          ]),
        ),
      );
}
