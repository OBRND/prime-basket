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
      backgroundColor: Colors.transparent,
      // title: Text('Do you have a referal code?'),
    elevation: 0,),
    body: Form(
      key: _formkey,
      child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text('Do you have a referal code?', style: TextStyle(fontSize: 22, color: Colors.black87, fontWeight: FontWeight.w700),),
        ),
         SizedBox(height: 20,),
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: TextFormField(
             controller: myController,
              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.005),
                labelText: "Enter a referal code",
              ),
              validator: (val) => val!.length != 28 ? ' Enter a valid referral code' : null,
            ),
         ),
        Card(
          elevation: 0,
          color: Colors.transparent,
          child: Text(Error, style: TextStyle(color: Colors.red),),),
        Container(
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            gradient: const LinearGradient(
                colors: [
                  Color(0xfff6ad16),
                  Colors.amberAccent,
                ]),
          ),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                elevation: 0,
                backgroundColor: Colors.transparent,
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
                  showDialog(context: context,
                      builder: (_) =>
                          StatefulBuilder(
                              builder: (context, setState) =>
                                  AlertDialog(
                                      contentPadding: EdgeInsets.all(10),
                                      scrollable: false,
                                      content: Container(
                                        height: 120,
                                        child: Column(
                                          children: [
                                            Text('You received \$3 for free.\n'
                                                'Your balance refreshes everyday, so use it everyday.'),
                                            TextButton(onPressed: (){
                                              Navigator.of(context).pushReplacement(MaterialPageRoute(
                                                  builder: (context) => BottomTab(index: 0)));
                                            }
                                                , child: Text('OK'))
                                          ],
                                        ),
                                      )
                                  )));
                } } ,
              child:const Text('Continue')),
        ),
        SizedBox(height: 5,),
        Container(
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            gradient: const LinearGradient(
                colors: [
                  Colors.blueAccent,
                  Colors.lightBlue]),
          ),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
                minimumSize: Size.fromHeight(50),),
              onPressed: () async{
                showDialog(context: context,
                    builder: (_) =>
                        StatefulBuilder(
                            builder: (context, setState) =>
                                AlertDialog(
                                    contentPadding: EdgeInsets.all(10),
                                    scrollable: false,
                                    content: Container(
                                      height: 120,
                                      child: Column(
                                        children: [
                                          Text('You received \$3 for free.\n'
                                              'Your balance refreshes everyday, so use it everyday.'),
                                          TextButton(onPressed: (){
                                            Navigator.pop(context);
                                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                                                builder: (context) => BottomTab(index: 0)));
                                          }
                                              , child: Text('OK'))
                                        ],
                                      ),
                                    )
                                )));
              } ,
              child:const Text('Skip')),
        ),
      ],),
    ),
  );
}

