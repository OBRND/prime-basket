import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:primebasket/Services/Database.dart';
import 'package:primebasket/Widget/bottom_tab.dart';

class referalcheck extends StatefulWidget {
  const referalcheck({Key? key}) : super(key: key);

  @override
  State<referalcheck> createState() => _referalcheckState();
}

class _referalcheckState extends State<referalcheck> {

  bool isfirstlogin = true;

  @override
  void initState() {
    super.initState();
    // final user = FirebaseAuth.instance.currentUser!;
    // // user needs to be created before
    // isfirstlogin = await DatabaseService(uid: user.uid).isfirstlogin();
  }

  @override
  void dispose(){
    super.dispose();
  }
  final myController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final user = FirebaseAuth.instance.currentUser!;
  String Error = '';

  @override
  Widget build(BuildContext context)  => !isfirstlogin ? BottomTab(index: 0): Scaffold(
    appBar: AppBar(
      title: Text('Do you have a referal code?'),
    elevation: 0,),
    body: Form(
      key: _formkey,
      child: Column(
      children: [
         Padding(
          padding: EdgeInsets.all(10.0),
          child: Text('Please enter your refereal code below',style: TextStyle(fontSize: 22, color: Colors.black87, fontWeight: FontWeight.w700),),
        ),
         TextFormField(
           controller: myController,
            style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.06),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.005),
              labelText: "Enter a referal code",
            ),
            validator: (val) => val!.length != 28 ? ' Enter a valid referral code' : null,
          ),
        Card(
          elevation: 0,
          color: Colors.transparent,
          child: Text(Error, style: TextStyle(color: Colors.red),),),
        TextButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(50),),
            onPressed: () async{
             String error = await DatabaseService(uid: user.uid).doesreferalexist(myController.text);
             print(error);
             if(error == 'Does not exist'){
               setState(() {
                 Error = 'Sorry, Wrong referral code';
                 // loading = false;
               });
             }
              if(_formkey.currentState!.validate() && error == 'exists') {
                await DatabaseService(uid: user.uid).setreferal(myController.text);

                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => BottomTab(index: 0)));
              } } ,
            child:const Text('Continue')),
        TextButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(50),),
            onPressed: () async{
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => BottomTab(index: 0)));
            } ,
            child:const Text('Skip')),
      ],),
    ),
  );
}

