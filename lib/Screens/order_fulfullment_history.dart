import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:primebasket/Widget/bottom_tab.dart';
import 'package:primebasket/Widget/animated_text.dart';
import 'package:primebasket/Widget/app_bar.dart';
import 'package:provider/provider.dart';

import '../Services/Database.dart';
import '../Services/User.dart';
import '../Widget/bottomnavtab.dart';

class OrderFulfilled extends StatefulWidget {
  @override
  State<OrderFulfilled> createState() => _OrderFulfilledState();
}

class _OrderFulfilledState extends State<OrderFulfilled> {
  // const OrderFulfilled({Key? key}) : super(key: key);
  List orders = [];

  Future getorders(BuildContext context) async{
  final user = FirebaseAuth.instance.currentUser!;
    List orderlist = [];
  // final user = Provider.of<UserFB?>(context);
  final uid = user!.uid;
  orderlist = await DatabaseService(uid: user.uid).getorderhistory();
  orders = orderlist;
  return orderlist;
  }

  Future refreshedtrades() async{
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    TextStyle style = TextStyle(fontSize: 20, fontWeight: FontWeight.w500,);
    return Scaffold(
      // appBar: AppBar(
      //   iconTheme: const IconThemeData(
      //     color: Colors.black
      //   ),
      //   elevation: 0,
      //   backgroundColor: Color(0xffadacac),
      //   title:
      // ),
      bottomNavigationBar: bottomtabwidget(),
      body: RefreshIndicator(
        onRefresh: refreshedtrades,
        child: ListView(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('Order Fulfillment History',
                  style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w400, fontSize: 22),),
              ),
            ),
    // const AppBarWidget(),
            // Center(
            //   child: Text("Order Fulfillment History", style: TextStyle(fontWeight: FontWeight.bold,fontSize: size.width*0.07, color: Colors.black),),
            // ),
          Container(
            height: size.height*.9,
            child: FutureBuilder(
            future: getorders(context),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                  default:
                        List<Widget> list = <Widget>[];
                        for(var i = 0; i < snapshot.data.length; i++) {
                          list.add( Card(
                            color: Colors.white,
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
                                            Text('An order worth ',
                                                style: style.copyWith(
                                                color: orders[snapshot.data.length -1 - i].Status == 'processing' ? Colors.amber :
                                                orders[snapshot.data.length -1 - i].Status == 'Delivered' ? Colors.green : Colors.red,
                                                    fontWeight: FontWeight.w500, fontSize: 16)),
                                            Text('\$${(orders[snapshot.data.length -1- i].total).toStringAsFixed(2)}',
                                              style: style.copyWith(color: orders[snapshot.data.length -1 - i].Status == 'processing' ? Colors.amber :
                                              orders[snapshot.data.length -1 - i].Status == 'Delivered' ? Colors.green : Colors.red,
                                                  fontWeight: FontWeight.w500, fontSize: 20),),
                                            // Text('is being '),
                                            Text(orders[snapshot.data.length -1 - i].Status == 'processing' ?
                                            ' is being processed.': orders[snapshot.data.length -1 - i].Status == 'Delivered'?
                                            ' has been delivered.' : ' has been returned.',
                                              style: TextStyle(color: orders[snapshot.data.length -1 - i].Status == 'processing' ? Colors.amber :
                                              orders[snapshot.data.length -1 - i].Status == 'Delivered' ? Colors.green : Colors.red,
                                                fontWeight: FontWeight.w500, fontSize: 16),
                                            ),
                                        ],),
                                      ),
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.all(5.0),
                                  //   child: Wrap(
                                  //     runSpacing: 15,
                                  //     children: [
                                  //       Text("'${orders[snapshot.data.length -1- i].qty} - ${orders[snapshot.data.length -1- i].pName}' ", style: style.copyWith(fontSize: 16),),
                                  //       Text('${orders[snapshot.data.length -1- i].Status}'),
                                  //       Text(' with '),
                                  //       Text('\$${double.parse(orders[snapshot.data.length -1- i].earnings).toStringAsFixed(2)} ', style: style.copyWith(fontWeight: FontWeight.w600, fontSize: 18),),
                                  //       Text('earnings'),
                                  //     ],
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ));
                        }
                        return SingleChildScrollView(
                          child: Container(
                              width: MediaQuery.of(context).size.width*.9,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: list),
                          ),
                        );
                        }
            }))

          ],
        ),
      ),
    );
  }
}
