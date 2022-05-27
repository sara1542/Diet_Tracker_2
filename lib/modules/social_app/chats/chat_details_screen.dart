import 'package:firstgp/globals/globalVariables.dart';
import 'package:firstgp/layout/social_app/cubit/cubit.dart';
import 'package:firstgp/layout/social_app/cubit/states.dart';
import 'package:firstgp/models/social_app/chat_model.dart';
import 'package:firstgp/models/social_app/social-user_model.dart';
import 'package:firstgp/shared/styles/icon_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../globals/globalVariables.dart';
import '../../../models/patient.dart';

class ChatDetailsScreen extends StatefulWidget {
  //receiver model

  ChatDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        SocialCubit.get(context).getMessages();
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(children: [
                  const CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage(
                     'https://cdn4.vectorstock.com/i/1000x1000/81/88/community-logo-icon-vector-19168188.jpg'
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Text(
                    currentpatient.Case,
                    style: const TextStyle(
                      height: 1.4,
                    ),
                  ),
                ]),
              ),
              body: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            var message =
                                SocialCubit.get(context).messages[index];
                            if (currentpatient.uId == message.senderId) {
                              return buildMyMessage(message);
                            } else {
                              return buildMessage(message);
                            }
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 10.0,
                              ),
                          itemCount: SocialCubit.get(context).messages.length),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: messageController,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Type your message here ...'),
                            ),
                          ),
                          Container(
                            height: 50.0,
                            color: Colors.blue,
                            child: MaterialButton(
                              onPressed: () {
                                SocialCubit.get(context).sendMessageTogroup(
                                    dateTime: DateTime.now().toString(),
                                    text: messageController.text);
                                messageController.text="";
                              },
                              minWidth: 1.0,
                              child: const Icon(
                                IconBroken.Send,
                                size: 16.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildMessage(MessageModel message) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Row(
          children: [
             CircleAvatar(
              radius: 20.0,
              backgroundImage: NetworkImage(
                message.imageOfSender
              ),
            ),
            const SizedBox(
              width: 15.0,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(10.0),
                  topEnd: Radius.circular(10.0),
                  topStart: Radius.circular(10.0),
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              child: Text(
                message.text,
              ),
            ),
          ],
        ),
      );

  Widget buildMyMessage(MessageModel message) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue[100],
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          child: Text(
            message.text,
          ),
        ),
      );
}
