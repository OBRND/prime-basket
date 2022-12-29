import 'package:flutter/material.dart';
import 'package:primebasket/Widget/bottom_tab.dart';
import 'package:primebasket/Widget/animated_text.dart';
import 'package:primebasket/Widget/app_bar.dart';
import 'package:provider/provider.dart';

import '../Services/Database.dart';
import '../Services/User.dart';

class OrderFulfilled extends StatelessWidget {
  // const OrderFulfilled({Key? key}) : super(key: key);
  List orders = [];

  Future getorders(BuildContext context) async{
  // final user = FirebaseAuth.instance.currentUser!;
    List orderlist = [];
  final user = Provider.of<UserFB?>(context);
  final uid = user!.uid;
  orderlist = await DatabaseService(uid: user.uid).getorderhistory();
  print("vvvvvvvv$orderlist");
  // setState(() {
    orders = orderlist;
  // });
  return orderlist;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    TextStyle style = TextStyle(fontSize: 20, fontWeight: FontWeight.w500,);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        elevation: 0,
        backgroundColor: Color(0xffadacac),
        title: Text('Order Fulfillment History', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 22),),
      ),
      // bottomNavigationBar: const BottomTab(),
      body: ListView(
        children: [
    // const AppBarWidget(),
          const BuildAnimatedText(),
          // Center(
          //   child: Text("Order Fulfillment History", style: TextStyle(fontWeight: FontWeight.bold,fontSize: size.width*0.07, color: Colors.black),),
          // ),
        Container(
          height: size.width*.9,
          child: FutureBuilder(
          future: getorders(context),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
                default:
                      List<Widget> list = <Widget>[];
                      for(var i = 0; i < snapshot.data.length; i++) {
                        print(snapshot.data);
                        list.add( Card(
                          color: Color(0xffdedfe5),
                          elevation: 5,
                          child: Center(
                            child: Column(
                              children: [
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10, right: 10),
                                      child: Row(
                                        children: [
                                        Text('You have an order worth ', style: style.copyWith(color: Color(0xff282727))),
                                        Text('\$${orders[i].total}', style: style.copyWith(fontSize: 22),),
                                      ],),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Wrap(
                                    runSpacing: 15,
                                    children: [
                                      Text("'${orders[i].qty} - ${orders[i].pName}' ", style: style.copyWith(fontSize: 16),),
                                      Text('${orders[i].Status}'),
                                      Text(' with '),
                                      Text('\$${orders[i].earnings} ', style: style.copyWith(fontWeight: FontWeight.w600, fontSize: 18),),
                                      Text('earnings'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ));
                      }
                      print(list.length);
                      return SingleChildScrollView(
                        child: Container(
                            width: MediaQuery.of(context).size.width*.9,
                            child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: list),
                        ),
                      );
                      }
          }))

        ],
      ),
    );
  }
}
