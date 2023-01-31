import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:primebasket/Screens/Withdrawpages/binancewithdrawal.dart';
import 'package:primebasket/Screens/Withdrawpages/mobiwalletwithdraw.dart';

import '../../Services/Database.dart';
import '../../Widget/bottomnavtab.dart';

class Withdrawalpage extends StatefulWidget {
  const Withdrawalpage({Key? key}) : super(key: key);

  @override
  State<Withdrawalpage> createState() => _WithdrawalpageState();
}

class _WithdrawalpageState extends State<Withdrawalpage> {
  @override
  void initState() {
    getbalance();
    super.initState();
  }
  List userbal = [];

  Future getbalance() async{
    final user = FirebaseAuth.instance.currentUser!;
    List userinfo = await DatabaseService(uid: user!.uid).getuserInfo();
    setState(() {
      userbal = userinfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffe8e7e7),
      bottomNavigationBar: bottomtabwidget(),
      // bottomNavigationBar: const BottomTab(),
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              children: [
                Stack(
                    children: [
                      Container(
                        color: Color(0xff4a4b9f),
                        height: size.width * 0.5,
                        width: size.width,
                      ),
                      Column(
                          children: [
                            Padding(padding: EdgeInsets.symmetric(
                                vertical: size.height * 0.02,
                                horizontal: size.width * 0.15),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: size
                                    .height * 0.008),
                                child: Center(child: Text("Withdraw",
                                  style: TextStyle(fontSize: size.width * .05,
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w500),)),
                              ),
                            ),
                            SizedBox(height: size.height * 0.01,),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),),
                              child: Container(
                                  width: size.width * .7,
                                  height: size.width * .263,
                                  color: Colors.transparent,
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,

                                      children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 7, right: 7, top: 3),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Text("Actual Balance",
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 20, fontWeight: FontWeight.w300
                                            ),),
                                          Text(userbal.isEmpty ? '0': "\$${double.parse(userbal[1]).toStringAsFixed(2)}", style: TextStyle(
                                              color: Colors.redAccent,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w300),)
                                        ],),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 7, right: 7, top: 3),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Text("Est Balance", style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 20, fontWeight: FontWeight.w300),),
                                          Text(userbal.isEmpty ? '0':"\$${double.parse(userbal[2]).toStringAsFixed(2)}", style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 20, fontWeight: FontWeight.w300),)
                                        ],),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 7, right: 7, top: 4),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Text("Virtual Balance",
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 20, fontWeight: FontWeight.w300),),
                                          Text(userbal.isEmpty ? '0':"\$ ${double.parse(userbal[0]).toStringAsFixed(2)}", style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 20, fontWeight: FontWeight.w300),)
                                        ],
                                      ),
                                    ),
                                  ]
                                  )),
                            )
                          ])
                    ]
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.1,
                      vertical: size.height * 0.04),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => binancewithdraw()));

                    },
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(15),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          'images/bsc.png', height: size.width * 0.3,),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.1,
                      vertical: size.height * 0.03),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => mobiwalletwithdraw()));
                    },
                    child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(15),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset('images/mobiwallet.png'),
                        )
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w400, fontSize: 16),
                          children:[
                            TextSpan(
                                text: 'Withdrawals are charged with 20% services and proccessing fees. '),
                            TextSpan(text: 'A minimum of \$20 per withdrawal request. '),
                            TextSpan(text: 'Bank of mobile wallet withdrawals will take upto 3 days to complete.'),
                            TextSpan(text: 'Bank charges apply.'),
                          ]
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

