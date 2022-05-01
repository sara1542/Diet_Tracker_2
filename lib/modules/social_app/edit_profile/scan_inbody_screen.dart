import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/components/components.dart';
import '../../../shared/styles/icon_broken.dart';

class ScanInbodyScreen extends StatelessWidget {
  const ScanInbodyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(
          leading: IconButton(
            onPressed: ()
            {
              Navigator.pop(context);
            },
            icon: const Icon(
              IconBroken.Arrow___Left_2,
            ),
          ),
          context: context,
          title:'Scan InBody',
          actions: [
            defaultTextButton(
              function: (){

              },
              text: 'Update',
            )
          ]),
      body:Center(
      ),
    );
  }
}
