import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:primebasket/Screens/login_page.dart';
import 'package:primebasket/Screens/order_fulfullment_page.dart';
import 'package:primebasket/Screens/top_up_page.dart';
import 'package:primebasket/Screens/withrawal_deposit.dart';
import 'package:primebasket/Services/Database.dart';
import 'package:primebasket/Services/User.dart';
import 'package:primebasket/Widget/bottom_tab.dart';
import 'package:primebasket/Widget/animated_text.dart';
import 'package:primebasket/Widget/app_bar.dart';
import 'package:provider/provider.dart';

import '../Services/Auth.dart';

class HomePage extends StatelessWidget {
  // const HomePage({Key? key}) : super(key: key);

  late List accountdata = [];

  Future userInfo(context) async{
    final user = Provider.of<UserFB?>(context);
    List details = await DatabaseService(uid: user!.uid).getuserInfo();
    accountdata = details;
    return details;
  }


  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final Auth_service _auth = Auth_service();
    final Size size = MediaQuery.of(context).size;
    print('$user');

    return Scaffold(
      // bottomNavigationBar: const BottomTab(),
      backgroundColor: Color(0xffc0c0c4),
      body: ListView(
        children: [
          AppBarWidget(user: user),
          const BuildAnimatedText(),

          FutureBuilder(
            future: userInfo(context),
            // initialData: Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.circular(15),
            //     child: Card(
            //       shape: (
            //           RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(18.0),
            //           )),
            //       color: Color(0xff344381),
            //       child: Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Row(
            //               children: [
            //                 SizedBox(width: size.width*.7,),
            //                 Row(
            //                   children: [
            //                     Text("Tier ", style: TextStyle(
            //                         fontSize: size.width*0.07, fontWeight: FontWeight.w200, color: Colors.white60),),
            //                     Text('loading...', style: TextStyle(
            //                         fontSize: size.width*0.07, fontWeight: FontWeight.w200, color: Colors.white60),)
            //                   ],
            //                 ),
            //               ],
            //             ),
            //             Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Padding(
            //                   padding: const EdgeInsets.all(8.0),
            //                   child: Text("Actual Balance",
            //                     style: TextStyle(color: Colors.white, fontSize: size.width*0.06, fontWeight: FontWeight.w300),),
            //                 ),
            //                 Row(
            //                   children: [
            //                     Text("\$", style: TextStyle(color: Colors.white60,fontSize: size.width*0.1),),
            //                     Text('0',
            //                       style: TextStyle(color: Colors.white60,fontSize: size.width*0.15, fontWeight: FontWeight.w200),),
            //                   ],
            //                 )
            //               ],
            //             ),
            //             SizedBox(
            //               height: size.height*0.01,
            //             ),
            //             Row(
            //               children: [
            //                 Column(
            //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                   children: [
            //                     Text("Est Earnings",
            //                       style: TextStyle(color: Colors.white, fontSize: size.width*0.06, fontWeight: FontWeight.w200),),
            //                     Text("\$ 0'}", style: TextStyle(
            //                         color: Colors.white,fontSize: size.width*0.06, fontWeight: FontWeight.w300),)
            //                   ],
            //                 ),
            //                 SizedBox(width: 30,),
            //                 Column(
            //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                   children: [
            //                     Text("Virtual Balance",
            //                       style: TextStyle(color: Colors.white, fontSize: size.width*0.06, fontWeight: FontWeight.w200),),
            //                     Text("\$ 0", style: TextStyle(
            //                         color: Colors.white,fontSize: size.width*0.06, fontWeight: FontWeight.w300),)
            //                   ],
            //                 ),
            //               ],
            //             ),
            //             SizedBox(
            //               height: size.height*0.01,
            //             ),
            //             Row(
            //               children: [
            //                 SizedBox(width: size.width*.7,),
            //                 Text("Series loading", style: TextStyle(
            //                     fontSize: size.width*0.06, fontWeight: FontWeight.w200, color: Colors.white60),),
            //               ],
            //             ),
            //             SizedBox(
            //               height: size.height*0.01,
            //             ),
            //           ],
            //         ),
            //       ) /* add child content here */,
            //     ),
            //   ),
            // ),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              switch(snapshot.connectionState){
                case ConnectionState.waiting:
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Card(
                        shape: (
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            )),
                        color: Color(0xff344381),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: size.width*.5,),
                                  Row(
                                    children: [
                                      Text("Tier ", style: TextStyle(
                                          fontSize: size.width*0.07, fontWeight: FontWeight.w200, color: Colors.white60),),
                                      Text('loading...', style: TextStyle(
                                          fontSize: size.width*0.07, fontWeight: FontWeight.w200, color: Colors.white60),)
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Actual Balance",
                                      style: TextStyle(color: Colors.white, fontSize: size.width*0.06, fontWeight: FontWeight.w300),),
                                  ),
                                  Row(
                                    children: [
                                      Text("\$", style: TextStyle(color: Colors.white60,fontSize: size.width*0.1),),
                                      Text('0',
                                        style: TextStyle(color: Colors.white60,fontSize: size.width*0.15, fontWeight: FontWeight.w200),),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: size.height*0.01,
                              ),
                              Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Est Earnings",
                                        style: TextStyle(color: Colors.white, fontSize: size.width*0.06, fontWeight: FontWeight.w200),),
                                      Text("\$ 0'}", style: TextStyle(
                                          color: Colors.white,fontSize: size.width*0.06, fontWeight: FontWeight.w300),)
                                    ],
                                  ),
                                  SizedBox(width: 30,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Virtual Balance",
                                        style: TextStyle(color: Colors.white, fontSize: size.width*0.06, fontWeight: FontWeight.w200),),
                                      Text("\$ 0", style: TextStyle(
                                          color: Colors.white,fontSize: size.width*0.06, fontWeight: FontWeight.w300),)
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.height*0.01,
                              ),
                              Row(
                                children: [
                                  SizedBox(width: size.width*.5,),
                                  Text("Series loading", style: TextStyle(
                                      fontSize: size.width*0.06, fontWeight: FontWeight.w200, color: Colors.white60),),
                                ],
                              ),
                              SizedBox(
                                height: size.height*0.01,
                              ),
                            ],
                          ),
                        ) /* add child content here */,
                      ),
                    ),
                  );
                default: return  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Card(
                      shape: (
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          )),
                      color: Color(0xff344381),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: size.width*.7,),
                                Row(
                                  children: [
                                    Text("Tier ", style: TextStyle(
                                        fontSize: size.width*0.07, fontWeight: FontWeight.w200, color: Colors.white60),),
                                    Text(accountdata[3], style: TextStyle(
                                        fontSize: size.width*0.07, fontWeight: FontWeight.w200, color: Colors.white60),)
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Actual Balance",
                                    style: TextStyle(color: Colors.white, fontSize: size.width*0.06, fontWeight: FontWeight.w300),),
                                ),
                                Row(
                                  children: [
                                    Text("\$", style: TextStyle(color: Colors.white60,fontSize: size.width*0.1),),
                                    Text(accountdata[1],
                                      style: TextStyle(color: Colors.white60,fontSize: size.width*0.15, fontWeight: FontWeight.w200),),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: size.height*0.01,
                            ),
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Est Earnings",
                                      style: TextStyle(color: Colors.white, fontSize: size.width*0.06, fontWeight: FontWeight.w200),),
                                    Text("\$ ${accountdata[2].substring(0, 5)}", style: TextStyle(
                                        color: Colors.white,fontSize: size.width*0.06, fontWeight: FontWeight.w300),)
                                  ],
                                ),
                                SizedBox(width: 30,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Virtual Balance",
                                      style: TextStyle(color: Colors.white, fontSize: size.width*0.06, fontWeight: FontWeight.w200),),
                                    Text("\$${accountdata[0]}", style: TextStyle(
                                        color: Colors.white,fontSize: size.width*0.06, fontWeight: FontWeight.w300),)
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height*0.01,
                            ),
                            Row(
                              children: [
                                SizedBox(width: size.width*.68),
                                Text("Series 1", style: TextStyle(
                                    fontSize: size.width*0.06, fontWeight: FontWeight.w200, color: Colors.white60),),
                              ],
                            ),
                            SizedBox(
                              height: size.height*0.01,
                            ),
                          ],
                        ),
                      ) /* add child content here */,
                    ),
                  ),
                );
              }
            },
          ),


          SizedBox(height: size.height*0.015,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(25,5,10,5),
                child: Container(
                  height: 36,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [
                          Color(0xff49bb2b),
                          Color(0xff1c3d0a)]),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TopUpPage()));
                  },
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(35,0,35,0)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),)
                        ),
                        backgroundColor: MaterialStateColor.resolveWith((states) => Colors.transparent)),
                    child: Text('Top Up', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10,5,20,5),
                child: Container(
                  height: 36,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [
                          Color(0xff192456),
                          Color(0xff647cee)]),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.pushNamed(context, '/Withdraw');
                    },
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(30,5,30,5)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                             )
                        ),
                        backgroundColor: MaterialStateColor.resolveWith((states) => Colors.transparent)),
                    child: Text('Withdraw', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
                  ),
                ),
              ),
              ],
          ),
      SizedBox(height: 20,),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: StaggeredGrid.count(
              crossAxisCount: 4,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              children: [
                StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: .75,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [Color(0xFF26C9F1),
                              Color(0x9D4E76CC)
                            ]),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(elevation: 0, shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      ),
                                backgroundColor: Color(0x38344381)),
                          onPressed: (){Navigator.pushNamed(context, '/p2p');
                          },
                          child: Text('P2P trading',
                              style: TextStyle(fontSize: 18, color: Colors.white70))),
                    ),
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: .75,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [Color(0x9D4E76CC),
                              Color(0xFF26C9F1)
                            ]),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ElevatedButton(onPressed: (){
                        Navigator.pushNamed(context, '/share');
                      },
                          style: ElevatedButton.styleFrom(elevation: 0, shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                              backgroundColor:  Color(0x1D344381)),
                          child: Text('Share',  style: TextStyle(fontSize: 16, color: Colors.white70),)),
                    ),
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: .75,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [Color(0xFF26C9F1),
                              Color(0x9D4E76CC),
                            ]),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ElevatedButton(onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => OrderFulfilled()));
                      },
                          style: ElevatedButton.styleFrom(elevation: 0, shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                              backgroundColor:  Color(0x24344381)),
                          child: const Text('Order fulfillment       history',
                              style: TextStyle(fontSize: 16, color: Colors.white70))),
                    ),
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: .75,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [Color(0x9D4E76CC),
                              Color(0xFF26C9F1),
                              ]),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ElevatedButton(onPressed: (){
                        Navigator.pushNamed(context, '/withdrawal');
                      },
                          style: ElevatedButton.styleFrom(elevation: 0, shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                              backgroundColor:  Color(0x1A344381)),
                          child: Text('         Deposit/ Withdrawal history',
                              style: TextStyle(fontSize: 15, color: Colors.white70))),
                    ),
                  ),
                ),

                StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: .75,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [Color(0xFF26C9F1),
                              Color(0x9D4E76CC),
                            ]),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(elevation: 0, shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                              backgroundColor: Colors.transparent),
                          onPressed: (){
                          },
                          child: Text('Tier system',
                              style: TextStyle(fontSize: 16, color: Colors.white70))),
                    ),
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: .75,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [Color(0x9D4E76CC),
                              Color(0xFF26C9F1),
                              ]),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ElevatedButton(onPressed: (){

                      },
                          style: ElevatedButton.styleFrom(elevation: 0, shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                              backgroundColor:  Colors.transparent),
                          child: Text('FAQs',  style: TextStyle(fontSize: 16, color: Colors.white70),)),
                    ),
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: .75,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [Color(0xFF26C9F1),
                              Color(0x9D4E76CC),
                            ]),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ElevatedButton(onPressed: (){

                      },
                          style: ElevatedButton.styleFrom(elevation: 0, shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                              backgroundColor:  Colors.transparent),
                          child: const Text('change password',style: TextStyle(fontSize: 16, color: Colors.white70))),
                    ),
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: .75,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [Color(0x9D4E76CC),
                              Color(0xFF26C9F1),
                              ]),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ElevatedButton(onPressed: (){
                      },
                          style: ElevatedButton.styleFrom(elevation: 0, shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                              backgroundColor:  Colors.transparent),
                          child: Text('contact us',
                              style: TextStyle(fontSize: 16, color: Colors.white70))),
                    ),
                  ),
                ),
              ],
            ),
      ),
          //
          // HomeButtons(size: size, color: Colors.white, fontColor: Colors.black, text: "P2P Trading", ontap: (){
          //
          // },),
          // HomeButtons(size: size, color: Colors.white, fontColor: Colors.black, text: "Share", ontap: (){
          //   Navigator.pushNamed(context, '/share');
          // },),
          // HomeButtons(size: size, color: Colors.white, fontColor: Colors.black, text: "Order Fulfillment History", ontap: (){
          //   Navigator.pushNamed(context, '/orderfulfill');
          // },),
          // HomeButtons(size: size, color: Colors.white, fontColor: Colors.black, text: "Deposit/Withdrawal History", ontap: (){
          //   Navigator.pushNamed(context, '/withdrawal');
          // },),
          // HomeButtons(size: size, color: Colors.white, fontColor: Colors.black, text: "Tier System", ontap: (){
          //   Navigator.pushNamed(context, '/topup');
          // },),
          // HomeButtons(size: size, color: Colors.white, fontColor: Colors.black, text: "FAQs", ontap: (){
          //   Navigator.pushNamed(context, '/topup');
          // },),
          // HomeButtons(size: size, color: Colors.white, fontColor: Colors.black, text: "Change Password", ontap: (){
          //   Navigator.pushNamed(context, '/topup');
          // },),
          // HomeButtons(size: size, color: Colors.white, fontColor: Colors.black, text: "Contact Us", ontap: (){
          //   Navigator.pushNamed(context, '/topup');
          // },),
          // HomeButtons(size: size, color: Colors.white, fontColor: Colors.black, text: "Log out", ontap: (){
          //   Navigator.pushNamed(context, '/topup');
          // },),

          TextButton.icon(onPressed:() {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => LoginPage()));
            _auth.sign_out();
          },
            icon: const Icon(Icons.logout, color: Colors.black87,size: 25),
            label: const Text('Log Out', style: TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.w500),),
          )



        ],
      ),
    );
  }
}

class HomeButtons extends StatelessWidget {
  const HomeButtons({
    Key? key,
    required this.size,
    required this.color,
    required this.fontColor,
    required this.text,
    required this.ontap
  }) : super(key: key);

  final Size size;
  final Color color;
  final Color fontColor;
  final String text;
  final Function() ontap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width*0.02, vertical: size.height*0.006),
      child: MaterialButton(onPressed: ontap,
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: size.height*0.008),
          child: Text(text, style: TextStyle(fontSize: size.width*0.07, color: fontColor),),
        ),),
    );
  }
}
