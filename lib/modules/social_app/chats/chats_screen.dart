
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
      builder: (BuildContext context)
      {
        var users=SocialCubit.get(context).users;
        return BlocConsumer<SocialCubit,SocialStates>(
          listener: (context, state) {},
          builder: (context,state){
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildChatItem(context,users[index]),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: users.length,
            );
          },
        );
      },
    );
  }

  Widget buildChatItem(context,SocialUserModel model)=>InkWell(
    onTap: (){
      navigateTo(context, ChatDetailsScreen(userModel: model));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(children:  [
        CircleAvatar(
          radius: 25.0,
          backgroundImage: NetworkImage(
        model.image,
          ),
        ),
        const SizedBox(
          width: 15.0,
        ),
        Text(
          model.name,
          style: const TextStyle(
            height: 1.4,
          ),
        ),
      ]),
    ),
  );
}
