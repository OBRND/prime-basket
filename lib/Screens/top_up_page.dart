import 'package:flutter/material.dart';
import 'package:primebasket/Widget/bottom_tab.dart';
import 'package:primebasket/Widget/animated_text.dart';
import 'package:primebasket/Widget/app_bar.dart';

import 'binance_page.dart';

class TopUpPage extends StatelessWidget {
  const TopUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffe8e7e7),
      // bottomNavigationBar: const BottomTab(),
      body: SafeArea(
        child: Stack(
          children:[
            ListView(
            children: [
              Stack(
                  children:[
                    Container(
                    color: Colors.indigoAccent,
                    height: size.width*0.492,
                    width: size.width,
                  ),
                    Column(
                        children:[
                        Padding(padding: EdgeInsets.symmetric(vertical: size.height*0.02,horizontal: size.width*0.15),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: size.height*0.008),
                            child: Center(child: Text("Top up", style: TextStyle(fontSize: size.width*.1, color: Colors.white70, fontWeight: FontWeight.w500),)),
                          ),
                        ),
                    SizedBox(height: size.height*0.01,),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),) ,
                      child: Container(
                        width: size.width*.7,
                          height: size.width*.263,
                          color: Colors.transparent,
                          child: Column( children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 7, right: 7, top: 3),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Actual Balance", style: TextStyle(color: Colors.black87,fontSize: size.width*0.065),),
                                  Text("\$196.09", style: TextStyle(
                                      color: Colors.redAccent,fontSize: size.width*0.08, fontWeight: FontWeight.w500),)
                                ],),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 7, right: 7, top: 3),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Est Balance", style: TextStyle(color: Colors.black87,fontSize: size.width*0.06),),
                                  Text("\$0.00      ", style: TextStyle(color: Colors.black87,fontSize: size.width*0.06),)
                              ],),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 7, right: 7, top: 4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Virtual Balance", style: TextStyle(color: Colors.black87,fontSize: size.width*0.06),),
                                  Text("\$3         ", style: TextStyle(color: Colors.black87,fontSize: size.width*0.06),)
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
                padding:EdgeInsets.symmetric(horizontal: size.width*0.1, vertical: size.height*0.04),
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BinancePage()));
                  },
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset('images/bsc.png', height: size.width*0.3,),
                  ),
                ),
              ),

              Padding(
                padding:EdgeInsets.symmetric(horizontal: size.width*0.1, vertical: size.height*0.03),
                child: GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, '/mobiwallet');
                  },
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset('images/mobiwallet.png')
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
