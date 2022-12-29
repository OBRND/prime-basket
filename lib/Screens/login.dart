// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:primebasket/Screens/login_page.dart';
//
// import 'home_page.dart';
//
// class login extends StatelessWidget {
//   const login({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:StreamBuilder(
//           stream: FirebaseAuth.instance.authStateChanges(),
//           builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//             if(snapshot.connectionState == ConnectionState.waiting){
//               return CircularProgressIndicator();
//             }
//             else if(snapshot.hasData){
//               print('This isnt workinnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn');
//               return HomePage();
//             }
//             else if(snapshot.hasError){
//               return Center(child: Text('Something went wrong'));
//             }
//             else {
//               print('This isnt workinnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn');
//               return LoginPage();
//             }}),
//     );
//   }
// }
