import 'package:firstgp/globals/globalVariables.dart';

import '../../../layout/social_app/cubit/cubit.dart';
import '../../../layout/social_app/cubit/states.dart';
import 'package:firstgp/modules/social_app/edit_profile/scan_inbody_screen.dart';
import 'package:firstgp/shared/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../shared/styles/icon_broken.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var ageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialUserUpdateSuccessState) {
          showToast(
            text: 'Updated',
            state: ToastStates.SUCCESS,
          );
        }
      },
      builder: (context, state) {
        nameController.text = currentpatient.username;
        emailController.text = currentpatient.email;
        ageController.text = currentpatient.Age.toString();
        var profileImage = SocialCubit.get(context).profileImage;
        return Scaffold(
          appBar: defaultAppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                IconBroken.Arrow___Left_2,
              ),
            ),
            context: context,
            title: 'Edit Profile',
            actions: [
              defaultTextButton(
                function: () {
                  if (SocialCubit.get(context).profileImage == null) {
                    SocialCubit.get(context).updateUserProfile(
                      name: nameController.text,
                      email: emailController.text,
                      age: int.parse(ageController.text),
                    );
                  } else {
                    SocialCubit.get(context).uploadProfileImage(
                        name: nameController.text,
                        email: emailController.text,
                        age: int.parse(ageController.text));

                  }
                  setState(() {});
                },
                text: 'Update',
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  if (state is SocialGetUserLoadingState ||
                      state is SocialUserUpdateLoadingState)
                    const SizedBox(
                      height: 10.0,
                    ),
                  if (state is SocialGetUserLoadingState ||
                      state is SocialUserUpdateLoadingState)
                    const LinearProgressIndicator(),
                  if (state is SocialGetUserLoadingState ||
                      state is SocialUserUpdateLoadingState)
                    const SizedBox(
                      height: 10.0,
                    ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      CircleAvatar(
                        radius: 62,
                        backgroundColor: Colors.blue[200],
                        child: CircleAvatar(
                          radius: 60.0,
                          backgroundImage: profileImage == null
                              ? NetworkImage(currentuser.image)
                              : (FileImage(profileImage)) as ImageProvider,
                        ),
                      ),
                      IconButton(
                        icon: const CircleAvatar(
                            radius: 20.0,
                            // backgroundColor: Colors.blue[300],
                            child: Icon(IconBroken.Camera)),
                        onPressed: () {
                          SocialCubit.get(context).getProfileImage();
                        },
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Name can not be empty';
                      }
                      return null;
                    },
                    label: 'Name',
                    prefix: IconBroken.User,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Email can not be empty';
                      }
                      return null;
                    },
                    label: 'Email address',
                    prefix: IconBroken.Message,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    label: ' Enter your age',
                    prefix: IconBroken.User,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Age can not be empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ScanInbodyScreen()),
                            ).then((value) => setState(() {}));
                          },
                          child: const Text('Scan InBody'),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
