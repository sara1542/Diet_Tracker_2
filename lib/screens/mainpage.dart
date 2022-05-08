// import 'package:firstgp/screens/scannerScreen.dart';
// import 'package:flutter/material.dart';
//
// import '../main.dart';
//
// class mainPage extends StatefulWidget {
//   @override
//   _mainPageState createState() => _mainPageState();
// }
//
// class _mainPageState extends State<mainPage> {
//   List<Widget> selectedPage = [MyApp(), HomePage()];
//   late int index;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     index = 0;
//     //future = getDoctorsData().then((value) => temp = doctors);
//   }
//
//   void SelectedPage(int i) {
//     setState(() {
//       index = i;
//     });
//   }
//
//   final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _drawerKey,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         leading: Container(
//           margin: EdgeInsets.all(10),
//           child: Center(
//             child: IconButton(
//                 icon: Icon(Icons.menu),
//                 onPressed: () {
//                   if (_drawerKey.currentState!.isDrawerOpen) {
//                     Navigator.pop(context);
//                   } else {
//                     _drawerKey.currentState!.openDrawer();
//                   }
//                 }),
//           ),
//           decoration: BoxDecoration(
//               border: Border.all(color: Colors.black12),
//               borderRadius: BorderRadius.circular(5)),
//         ),
//       ),
//       drawer: Builder(
//           builder: (context) => Drawer(
//                 child: ListView(
//                   padding: EdgeInsets.zero,
//                   children: [
//                     //SizedBox(height: 15,),
//                     ListTile(
//                       title: const Text("Home"),
//                       leading: Icon(
//                         Icons.home,
//                         color: Colors.black,
//                       ),
//                       onTap: () {
//                         Navigator.pop(context);
//                         SelectedPage(1);
//                       },
//                     ),
//                     ListTile(
//                       title: const Text("view doctors"),
//                       leading: Icon(
//                         Icons.person,
//                         color: Colors.black,
//                       ),
//                       onTap: () {
//                         Navigator.pop(context);
//                         SelectedPage(0);
//                       },
//                     ),
//                   ],
//                 ),
//               )),
//       body: selectedPage[index],
//     );
//   }
// }
