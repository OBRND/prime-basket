import 'package:flutter/material.dart';
import 'package:primebasket/Widget/bottom_tab.dart';
import 'package:primebasket/Widget/animated_text.dart';
import 'package:primebasket/Widget/app_bar.dart';
import 'package:provider/provider.dart';

import '../Services/Database.dart';
import '../Services/User.dart';
import '../Widget/bottomnavtab.dart';


class WithdrawalhistoryPage extends StatefulWidget {
  @override
  State<WithdrawalhistoryPage> createState() => _WithdrawalhistoryPageState();
}

class _WithdrawalhistoryPageState extends State<WithdrawalhistoryPage> {
  // const WithdrawalhistoryPage({Key? key}) : super(key: key);
  List history = [];

  Future getorders(BuildContext context) async{
    // final user = FirebaseAuth.instance.currentUser!;
    List orderlist = [];
    List orderlisttop = [];
    List orderlistest = [];
    final user = Provider.of<UserFB?>(context);
    final uid = user!.uid;
    orderlist = await DatabaseService(uid: user.uid).getwithdrawalhistory();
    orderlisttop = await DatabaseService(uid: user.uid).gettopuphistory();
    orderlistest = await DatabaseService(uid: user.uid).getearnings();
   for(int i = 0; i< orderlistest.length; i++){
    orderlist.add(orderlistest[i]);
   }
   for(int i = 0; i< orderlisttop.length; i++){
    orderlist.add(orderlisttop[i]);
   }
      orderlist.sort((a,b) =>
      b.tobeesorted.compareTo(a.tobeesorted)
      );
    return orderlist;
  }
  Future refreshedtrades() async{
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontSize: 20, fontWeight: FontWeight.w500,);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        bottomNavigationBar: bottomtabwidget(),
        appBar: AppBar(
          iconTheme: const IconThemeData(
              color: Colors.black
          ),
          elevation: 0,
          backgroundColor: Color(0xffadacac),
          title:  Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text("Withdrawal/Deposit History", style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20, color: Colors.black),),
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: refreshedtrades,
          child: ListView(
          children: [
           FutureBuilder(
              future: getorders(context),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: Column(
                      children: [
                        SizedBox(height: size.height*.3,),
                        CircularProgressIndicator(),
                      ],
                    ));
                  default:
                    List<Widget> list = <Widget>[];
                    for(var i = 0; i < snapshot.data.length; i++) {
                      list.add(snapshot.data[i].time == '-' && snapshot.data[i].status != '-'? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(
                            color: Colors.black54,
                            thickness: 3,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text('Est. earinigs', style: style.copyWith(fontSize: 18),),
                          ),
                          Card(
                            color: Colors.white,
                            elevation: 1,
                            child: Center(
                              child: Column(
                                children: [
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text('\$${double.parse(snapshot.data[i].amount).toStringAsFixed(2)} ', style: style.copyWith(fontSize: 22, color: Colors.black87, fontWeight: FontWeight.w700),),
                                            Text(snapshot.data[i].status == 'processing' ? 'has been added to Est. earinigs.': snapshot.data[i].status == 'Delivered' ?
                                            'has been added to actual earnings' : 'has been removed from Est. earnings' ,
                                                style:(snapshot.data[i].status == 'processing' ? style.copyWith(fontSize:18, color: Color(
                                                    0xffb69d1c),  fontWeight: FontWeight.w400) :
                                                snapshot.data[i].status == 'Delivered' ? style.copyWith(fontSize:18, color: Colors.lightGreen,  fontWeight: FontWeight.w400) :
                                                style.copyWith(fontSize:18, color: Colors.red,  fontWeight: FontWeight.w400)),),
                                          ],),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ) : snapshot.data[i].status == '-'? Card(
                        color: Colors.white,
                        elevation: 0,
                        child: Center(
                          child: Column(
                            children: [
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text('You have a top up of ',
                                                style: style.copyWith(fontSize:16, color: Color(0xff282727),  fontWeight: FontWeight.w400)),
                                            Text('\$${double.parse(snapshot.data[i].amount).toStringAsFixed(2)}', style: style.copyWith(fontSize: 22, color: Colors.black87, fontWeight: FontWeight.w700),),
                                          ],),
                                        Text(' on ${snapshot.data[i].time}', style: style.copyWith(fontSize: 15),),

                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ) :

                      Card(
                        color: Colors.white,
                        elevation: 0,
                        child: Center(
                          child: Column(
                            children: [
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text('You have a ${snapshot.data[i].status} withdrawal of ',
                                            style: style.copyWith(fontSize:16, color: Color(0xff282727),  fontWeight: FontWeight.w400)),
                                        Text('\$${(snapshot.data[i].amount).toStringAsFixed(2)}', style: style.copyWith(fontSize: 20, color: Colors.black87, fontWeight: FontWeight.w700),),
                                      ],),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Wrap(
                                  runSpacing: 15,
                                  children: [
                                    Text(" on ${snapshot.data[i].time}", style: style.copyWith(fontSize: 15),),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ));
                    }
                    return SingleChildScrollView(
                      child: Container(
                        width: MediaQuery.of(context).size.width*.9,
                        child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: list),
                      ),
                    );
                }
              }
              ), ]
      ),
        )
    );
  }
}
