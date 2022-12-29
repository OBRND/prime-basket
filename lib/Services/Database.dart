import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:primebasket/Models/notificationModel.dart';
import 'package:primebasket/Models/orderModel.dart';

import '../Models/productModel.dart';

class DatabaseService{

  final String uid;
  DatabaseService({required this.uid});

  //collection reference
  final CollectionReference users = FirebaseFirestore.instance.collection('users');
  final CollectionReference products = FirebaseFirestore.instance.collection('products');
  final CollectionReference orderscollection = FirebaseFirestore.instance.collection('orders');
  final CollectionReference notification = FirebaseFirestore.instance.collection('notifications');

  Future makeorder(int qty,double earnings, String email, String pid, String pname, String status, double total, String uid ) async{
     String orderID = generateorderId();
     print('------------$orderID-------------------');
     await updateuserdata(earnings, total, orderID);
     var earn = earnings.toString();
     print('ohohohohohohohohohohohohoh');
      return await orderscollection.doc(orderID).set({
        'deliveredQty': qty,
        'earnings': earn,
        'email': email,
        'productName': pname,
        'productID': pid,
        'qty': qty,
        'status':status,
        'totalAmount': total,
        'userUID': uid
      });
    }
  String generateorderId() {
    var r = Random();
    const _chars = '1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
    return List.generate(20, (index) => _chars[r.nextInt(_chars.length)]).join();
  }
    Future getorderhistory() async{
      List<orderModel> Orderlist = [];
    List orderId = await getOrderID();
    print(orderId);
    for(int i=0; i < orderId.length; i++) {
      String x = orderId[i];
      DocumentSnapshot getuserorder = await orderscollection.doc('$x').get();
      print('*****qty: ${getuserorder['deliveredQty']}, earnings: ${getuserorder['earnings']},pName: ${getuserorder['productName']}, total: ${getuserorder['totalAmount']}, Status: ${getuserorder['status']}');
      orderModel singleorder = orderModel(qty: getuserorder['deliveredQty'], earnings: getuserorder['earnings'], pName: getuserorder['productName'], total: getuserorder['totalAmount'], Status: getuserorder['status']);
      // print(singleorder);
      Orderlist.add(singleorder);
    print('-----------------------------------------------------qty: ${getuserorder['deliveredQty']}, earnings: ${getuserorder['earnings']},pName: ${getuserorder['productName']}, total: ${getuserorder['totalAmount']}, Status: ${getuserorder['status']}');
    }
    print('=======${Orderlist}');

    return Orderlist;
  }

  Future updateuserdata(double newearned, double amount, orderid) async{
    DocumentSnapshot getuserorder = await users.doc('$uid').get();
    String earnings = getuserorder['estimatedEarnings'];
    String balance = getuserorder['virtualBalance'];
    List orders = getuserorder['orders'];
    orders.add(orderid);
    double earning = double.parse(earnings) + newearned;
    double newbal = double.parse(balance) - amount;
    String totalearn = earning.toString();
    String newbalance = newbal.toString();
    print("yayayayayayyayayaa");
    return await users.doc(uid).update({
      'orders': orders,
      'estimatedEarnings': totalearn,
      'virtualBalance': newbalance
    });
  }
  Future getOrderID() async{
    DocumentSnapshot getuserorder = await users.doc('$uid').get();
    List orderId = getuserorder['orders'];
    return orderId;
  }
  Future getproductid() async{
    List docss = [];
    await products.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((DocumentSnapshot doc) {
        docss.add(doc.id);
      });
    });
    print(docss);
    return docss;
    // print('-----------------------');
    // print(getuserorder);
  }

  Future getnotifications() async{
    List notifications = [];
    QuerySnapshot querySnapshot = await notification.get();
    final allnotifications = querySnapshot.docs;
    print(allnotifications);
    for(int i=0; i < allnotifications.length; i++) {
      notifications.add(notificationModel(date: allnotifications[i]['date'],
          text: allnotifications[i]['text'],
          time: allnotifications[i]['time']));
    }
    return notifications;
  }

  Future getuserInfo() async{
    // FirebaseFirestore _instance= FirebaseFirestore.instance;

    DocumentSnapshot User = await users
        .doc('$uid').get();
    var virtual = User['virtualBalance'];
    var actualBalance = User['actualBalance'];
    var estEarnings = User['estimatedEarnings'];
    var tier = User['tier'];


    print(virtual);
    print(actualBalance);
    print(estEarnings);
    return [virtual,actualBalance,estEarnings, tier];
  }

  Future orders() async{

    QuerySnapshot querySnapshot = await products.get();
    List name = [];
    List price = [];
    List earnings = [];
    List duration = [];
    List tier = [];
    List qty = [];
    List Details = [];
    List Details1 = [];
    List Details2 = [];
    List Details3 = [];
    List Details4 = [];
    List Details5 = [];
    List Details6 = [];
    List Details7 = [];
    List Details8 = [];
    List Details9 = [];
    List Details10 = [];
    // List pearnings = [];
    late productModel details;
    late productModel detailstier1;
    late productModel detailstier2;
    late productModel detailstier3;
    late productModel detailstier4;
    late productModel detailstier5;
    late productModel detailstier6;
    late productModel detailstier7;
    late productModel detailstier8;
    late productModel detailstier9;
    late productModel detailstier10;
    // Get data from docs and convert map to List
    final allData = querySnapshot.docs;
    final allIDs = await getproductid();

    // .map((doc) => doc.data()).toList();
    // final querySnapshotc = await querySnapshot['St']

    for(int i=0; i < allData.length; i++){
      // print(allData[i]['earnings']);
      price.add(allData[i]['price']);
      name.add(allData[i]['productName']);
      earnings.add(allData[i]['earnings']);
      duration.add(allData[i]['deliveryDuration']);
      tier.add(allData[i]['tier']);
      qty.add(allData[i]['qty']);

      if(allData[i]['tier'] == 1){
        detailstier1 = productModel(earnings: allData[i]['earnings'], name: allData[i]['productName'], duration: allData[i]['deliveryDuration'],
            price: allData[i]['price'], qty: allData[i]['qty'], tier: allData[i]['qty'], image: allData[i]['image'], PID: allIDs[i]);
        Details1.add(detailstier1);
        // for(int i=0; i < Details1.length; i++){
        // print(Details1[i].name);}
      }
      else if(allData[i]['tier'] == 2){
        detailstier2 = productModel(earnings: allData[i]['earnings'], name: allData[i]['productName'], duration: allData[i]['deliveryDuration'],
            price: allData[i]['price'], qty: allData[i]['qty'], tier: allData[i]['qty'],image: allData[i]['image'], PID: allIDs[i]);
        Details2.add(detailstier2);
      }
      else if(allData[i]['tier'] == 3){
        detailstier3 = productModel(earnings: allData[i]['earnings'], name: allData[i]['productName'], duration: allData[i]['deliveryDuration'],
            price: allData[i]['price'], qty: allData[i]['qty'], tier: allData[i]['qty'], image: allData[i]['image'], PID: allIDs[i]);
        Details3.add(detailstier3);
      }
      else if(allData[i]['tier'] == 4){
        detailstier4 = productModel(earnings: allData[i]['earnings'], name: allData[i]['productName'], duration: allData[i]['deliveryDuration'],
            price: allData[i]['price'], qty: allData[i]['qty'], tier: allData[i]['qty'], image: allData[i]['image'], PID: allIDs[i]);
        Details4.add(detailstier4);
      }
      else if(allData[i]['tier'] == 5){
        detailstier5 = productModel(earnings: allData[i]['earnings'], name: allData[i]['productName'], duration: allData[i]['deliveryDuration'],
            price: allData[i]['price'], qty: allData[i]['qty'], tier: allData[i]['qty'], image: allData[i]['image'], PID: allIDs[i]);
        Details5.add(detailstier5);
      }
      else if(allData[i]['tier'] == 6){
        detailstier6 = productModel(earnings: allData[i]['earnings'], name: allData[i]['productName'], duration: allData[i]['deliveryDuration'],
            price: allData[i]['price'], qty: allData[i]['qty'], tier: allData[i]['qty'], image: allData[i]['image'], PID: allIDs[i]);
        Details6.add(detailstier6);
      }
      else if(allData[i]['tier'] == 7){
        detailstier7 = productModel(earnings: allData[i]['earnings'], name: allData[i]['productName'], duration: allData[i]['deliveryDuration'],
            price: allData[i]['price'], qty: allData[i]['qty'], tier: allData[i]['qty'], image: allData[i]['image'], PID: allIDs[i]);
        Details7.add(detailstier7);
      }
      else if(allData[i]['tier'] == 8){
        detailstier8 = productModel(earnings: allData[i]['earnings'], name: allData[i]['productName'], duration: allData[i]['deliveryDuration'],
            price: allData[i]['price'], qty: allData[i]['qty'], tier: allData[i]['qty'], image: allData[i]['image'], PID: allIDs[i]);
        Details8.add(detailstier8);
      }
      else if(allData[i]['tier'] == 9){
        detailstier9 = productModel(earnings: allData[i]['earnings'], name: allData[i]['productName'], duration: allData[i]['deliveryDuration'],
            price: allData[i]['price'], qty: allData[i]['qty'], tier: allData[i]['qty'], image: allData[i]['image'], PID: allIDs[i]);
        Details9.add(detailstier9);

      }
      else if(allData[i]['tier'] == 10){
        detailstier10 = productModel(earnings: allData[i]['earnings'], name: allData[i]['productName'], duration: allData[i]['deliveryDuration'],
            price: allData[i]['price'], qty: allData[i]['qty'], tier: allData[i]['qty'], image: allData[i]['image'], PID: allIDs[i]);
        Details10.add(detailstier10);
      }

      details = productModel(earnings: allData[i]['earnings'], name: allData[i]['productName'], duration: allData[i]['deliveryDuration'],
          price: allData[i]['price'], qty: allData[i]['qty'], tier: allData[i]['qty'], image: allData[i]['image'], PID: allIDs[i]);

      // Details.add(details);
      Details = [Details1, Details2, Details3, Details4, Details5, Details6, Details7, Details8, Details9, Details10];
    }

    return Details;
  }


  // Future orders(var Start,var Destination, choice, date) async{
  //   // await DatabaseService(uid: uid).updateUserData(First_name,Last_name, Phone_number);
  //   var x = await getuserInfo();
  //   return await Orders.doc(uid).set({
  //     'Starting_address': Start,
  //     'Destination_address': Destination,
  //     'User_Info': x,
  //     'preferences': choice,
  //     'date': date,
  //   });
  //
  // }
  // Future balance() async{
  //   DocumentSnapshot User_balance = await Balance
  //       .doc('$uid').get();
  //   int amount = User_balance['Amount'];
  //   print(amount);
  //   return amount;
  //
  //
  // }
  Stream<QuerySnapshot> get info{
    return users.snapshots();
  }

}