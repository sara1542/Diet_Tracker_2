import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../globals/globalFunctions.dart';
import '../globals/globalVariables.dart';
import '../globals/globalwidgets.dart';
import '../providers/buttonProviders.dart';
import '../providers/mainPageProvider.dart';
import '../widgets/RegisterWidget.dart';
import '../widgets/loginWidget.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<mainProvider>(context, listen: true);
    // final mediaQuery = MediaQuery.of(context);
    button_provider = Provider.of<buttonProvider>(context, listen: true);

    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: SingleChildScrollView(
                child: Container(

                    // width: 300 + (mediaQuery.size.width - 300) * 0.1,
                    //height: (provider.isLogin)
                    //  ? 400 + (mediaQuery.size.height - 400) * 0.25
                    //: 400 + (mediaQuery.size.height - 400) * 0.65,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.login,
                                    color: Colors.black45,
                                  ),
                                  Text(
                                    ' enter your information below',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3!
                                        .copyWith(
                                            color: Colors.black54,
                                            fontSize: 20),
                                  ),
                                ],
                              )),
                          SizedBox(
                            height: 30,
                            child: Divider(
                              color: Colors.grey[350],
                            ),
                          ),
                          Form(
                              key: _formKey,
                              child: provider.isLogin ? Login() : Register()),
                          SizedBox(
                            height: 15,
                          ),
                          (provider.isLogin)
                              ? signUPorLogin(
                                  context, _formKey, submit, 'sign in')
                              : signUPorLogin(
                                  context, _formKey, submit, 'sign up'),
                        ],
                      ),
                    )))));
  }
}
