import 'package:firstgp/globals/globalVariables.dart';
import 'package:firstgp/modules/social_app/chats/chat_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/social_app/cubit/cubit.dart';
import '../../../layout/social_app/cubit/states.dart';
import '../../../shared/components/components.dart';

class ChatsScreen extends StatelessWidget {
  List<String> receivers = [];
  List<String> images = [];
  List<String> names = [];

  ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SocialCubit.get(context).isfirstMessage = true;
    debugPrint(SocialCubit.get(context).isfirstMessage.toString());
    return Builder(
      builder: (BuildContext context) {
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            if (reloadChats) {
              //add other receivers
              if (isDoctor) {
                receivers = [];
                images = [];
                names = [];
                for (int i = 0; i < patients.length; i++) {
                  receivers.add(patients[i].uId);
                  names.add(patients[i].username);
                  images.add(patients[i].image);
                }
              } else {
                receivers = ['chatbot', 'community'];
                images = [
                  'https://cdn-icons-png.flaticon.com/512/2040/2040946.png',
                  'https://cdn4.vectorstock.com/i/1000x1000/81/88/community-logo-icon-vector-19168188.jpg',
                ];
                names = ['Chat bot', currentpatient.Case + " Community"];

                if (currentPatientDoctor != null) {
                  receivers.add(currentPatientDoctor!.uId);
                  names.add(currentPatientDoctor!.username);
                  images.add(currentPatientDoctor!.image);
                }
              }
              reloadChats = false;
            }
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildChatItem(
                  context, receivers[index], names[index], images[index]),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: receivers.length,
            );
          },
        );
      },
    );
  }

  Widget buildChatItem(context, String receiver, String name, String image) =>
      InkWell(
        onTap: () {
          navigateTo(
              context,
              ChatDetailsScreen(
                receiver: receiver,
                name: name,
                image: image,
              ));
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(children: [
            CircleAvatar(radius: 25.0, backgroundImage: NetworkImage(image)),
            const SizedBox(
              width: 15.0,
            ),
            Text(name,
                style: const TextStyle(
                  height: 1.4,
                ))
          ]),
        ),
      );
}
