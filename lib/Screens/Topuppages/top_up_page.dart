import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:primebasket/Widget/bottom_tab.dart';
import 'package:primebasket/Widget/animated_text.dart';
import 'package:primebasket/Widget/app_bar.dart';

import '../../Services/Database.dart';
import '../../Widget/bottomnavtab.dart';
import 'binance_page.dart';
import 'mobibank_wallet_page.dart';

class TopUpPage extends StatefulWidget {
  const TopUpPage({Key? key}) : super(key: key);

  @override
  State<TopUpPage> createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {

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
      backgroundColor: Color(0xfffffefe),
      bottomNavigationBar: bottomtabwidget(),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
            children: [
              Stack(
                  children:[
                  //   Container(
                  //   color: Colors.indigoAccent,
                  //   width: size.width,
                  //     height: size.width*.12,
                  // ),
                    Column(
                        children:[
                           Center(
                             // height: 60,
                           child: Card (
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(15.0),),
                               color: Colors.indigo,
                                 child: Padding(
                                     padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                                     child: Text("Top up",
                          style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w400),))),),
                          SizedBox(height: size.height*0.01,),
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
                                                color: Colors.green,
                                                fontSize: 22,
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
                        ]),

                  ]
            ),
              Padding(
                padding:EdgeInsets.symmetric(horizontal: size.width*0.1, vertical: size.height*0.04),
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BinancePage()));
                  },
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(15),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset('images/bsc.png', height: size.width*0.3,),
                    ),
                  ),
                ),
              ),

              Padding(
                padding:EdgeInsets.symmetric(horizontal: size.width*0.1, vertical: size.height*0.03),
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MobileWallet()));
                  },
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(15),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset('images/mobiwallet.png'),
                        ),
                      ],
                    )
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
