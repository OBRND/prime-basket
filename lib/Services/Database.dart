import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:primebasket/Models/notificationModel.dart';
import 'package:primebasket/Models/orderModel.dart';
import 'package:primebasket/Models/withdrawalhistory.dart';

import '../Models/productModel.dart';
import '../Models/withdrawalModel.dart';

class DatabaseService{

  final String uid;
  DatabaseService({required this.uid});

  //collection reference
  final CollectionReference users = FirebaseFirestore.instance.collection('users');
  final CollectionReference products = FirebaseFirestore.instance.collection('products');
  final CollectionReference orderscollection = FirebaseFirestore.instance.collection('orders');
  final CollectionReference notification = FirebaseFirestore.instance.collection('notifications');
  final CollectionReference Txn = FirebaseFirestore.instance.collection('TXN');
  final CollectionReference Withdrawals = FirebaseFirestore.instance.collection('withdrawals');


  Future withdraw(withdrawModel withdrawal) async{
    String withdrawalID = generateorderId();
    return await Withdrawals.doc(withdrawalID).set({
      'account' : withdrawal.account,
      'amount': withdrawal.amount,
      'bank': withdrawal.bank,
      'country': withdrawal.country,
      'email': withdrawal.email,
      'status': withdrawal.status,
      'time': withdrawal.time,
      'uid': uid,

    });
  }

  Future getsharecount() async{
    DocumentSnapshot User = await users
        .doc('$uid').get();
   String count = await User['shareCount'];
   return count;
  }

  Future getwithdrawalhistory() async{
    List history = [];
    List banks = [];
    List status = [];
    List dates = [];
    List sorted = [];
    QuerySnapshot querySnapshot = await Withdrawals.get();
    print(querySnapshot);
    var allwithdrawals = await querySnapshot.docs;
    for(int i=0; i < allwithdrawals.length; i++){
      print('${allwithdrawals[i]['amount']}');
      print('|||||||||||||||||||');
      if(allwithdrawals[i]['uid'] == uid){
        print('----------------');
        dates.add('${allwithdrawals[i]['time']} $i');
        // index.add(i:'gf');
    dates.sort((a,b) => a.compareTo(b));
      }
      }
    for(int i = 0; i < dates.length; i++){
      print(dates);
      sorted.add(allwithdrawals[int.parse(dates[i].substring(dates[i].length-2, dates[i].length))]['amount']);
      status.add(allwithdrawals[int.parse(dates[i].substring(dates[i].length-2, dates[i].length))]['status']);
      // banks.add(allwithdrawals[int.parse(dates[i].substring(dates[i].length-2, dates[i].length))]['bank']);
      print('|||||||||$sorted');
      print(status);
      print(banks);
    }
    for(int i = 0; i < dates.length; i++) {
      history.add(withdrawalhistory(amount: sorted[i], time: dates[i].substring(0 ,dates[i].length-2),
        status: status[i] ));
    }

      // k.addEntries['${dates[0]}'];


    return history;
  }

  Future gettransactionHash() async{
    List Txns = [];
    await Txn.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((DocumentSnapshot doc) {
        Txns.add(doc.id);
      });
    });
    print(Txns);
    return Txns;
  }

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
    List Notifications = [];
    List formatteddates = [];
    List time = [];
    QuerySnapshot querySnapshot = await notification.get();
    final allnotifications = querySnapshot.docs;
    print(allnotifications);
    for(int i=0; i < allnotifications.length; i++) {
      Notifications.add('${allnotifications[i]['date']}');
      time.add(allnotifications[i]['time']);
      // notifications.add(notificationModel(date: allnotifications[i]['date'],
      //     text: allnotifications[i]['text'],
      //     time: allnotifications[i]['time']));
    }
    formatteddates = Sortdatesnatif(Notifications, time);
    for(int i=0; i < allnotifications.length; i++) {
      notifications.add(notificationModel(dateliteral: formatteddates[i],
          text: allnotifications[i]['text'],
          time: allnotifications[i]['time'],
          date: allnotifications[i]['date']));
    }
    // Notifications.sort((a, b){ //sorting in ascending order
    //   return a.compareTo(b);
    // });
    notifications.sort((a, b){ //sorting in ascending order
      return b.dateliteral.compareTo(a.dateliteral);
    });
    print('------------$notifications-------------');
    print(Notifications);
    print(DateTime.parse('2022-01-03 08:15'));
    return notifications;
  }

  Sortdatesnatif(List Notifications, List time) {
    List converteddate = [];
    String spacer = '';
    for (int i = 0; i < Notifications.length; i++) {
      String checker = Notifications[i].toString().substring(0, 3);
      print('Coconutssssssssss');
      print(time);
      print(checker);
      if(checker == 'Jan'){
        if(Notifications[i].substring(Notifications[i].length-8, Notifications[i].length-7) == ' ') {
          spacer = '0${Notifications[i].substring(
              Notifications[i].length - 7, Notifications[i].length - 6)} ${time[i]}';
          converteddate.add('${Notifications[i].toString().substring(
              Notifications[i].length - 4,
              Notifications[i].length)}-01-$spacer');
        }else {
          converteddate.add('${Notifications[i].toString().substring(
              Notifications[i].length - 4,
              Notifications[i].length)}-01-${Notifications[i].substring(
              Notifications[i].length - 8, Notifications[i].length - 6)} ${time[i]}');
        }}else if(checker == 'Feb'){
        if(Notifications[i].substring(Notifications[i].length-8, Notifications[i].length-7) == ' '){
          spacer = '0${Notifications[i].substring(Notifications[i].length-7, Notifications[i].length-6)} ${time[i]}';
          converteddate.add('${Notifications[i].toString().substring(Notifications[i].length-4, Notifications[i].length)}-02-$spacer');
        }else {
          converteddate.add('${Notifications[i].toString().substring(
              Notifications[i].length - 4,
              Notifications[i].length)}-02-${Notifications[i].substring(
              Notifications[i].length - 8, Notifications[i].length - 6)} ${time[i]}');
        }}else if(checker == 'Mar'){
        if(Notifications[i].substring(Notifications[i].length-8, Notifications[i].length-7) == ' '){
          spacer = '0${Notifications[i].substring(Notifications[i].length-7, Notifications[i].length-6)} ${time[i]}';
          converteddate.add('${Notifications[i].toString().substring(Notifications[i].length-4, Notifications[i].length)}-03-$spacer');

        }else {
          converteddate.add('${Notifications[i].toString().substring(
              Notifications[i].length - 4,
              Notifications[i].length)}-03-${Notifications[i].substring(
              Notifications[i].length - 8, Notifications[i].length - 6)} ${time[i]}');
        }}else if(checker == 'Apr'){
        if(Notifications[i].substring(Notifications[i].length-8, Notifications[i].length-7) == ' '){
          spacer = '0${Notifications[i].substring(Notifications[i].length-7, Notifications[i].length-6)} ${time[i]}';
          converteddate.add('${Notifications[i].toString().substring(Notifications[i].length-4, Notifications[i].length)}-04-$spacer');
        }else {
          converteddate.add('${Notifications[i].toString().substring(
              Notifications[i].length - 4,
              Notifications[i].length)}-04-${Notifications[i].substring(
              Notifications[i].length - 8, Notifications[i].length - 6)} ${time[i]}');
        }}else if(checker == 'May'){
        if(Notifications[i].substring(Notifications[i].length-8, Notifications[i].length-7) == ' '){
          spacer = '0${Notifications[i].substring(Notifications[i].length-7, Notifications[i].length-6)} ${time[i]}';
          converteddate.add('${Notifications[i].toString().substring(Notifications[i].length-4, Notifications[i].length)}-05-$spacer');
        }else {
          converteddate.add('${Notifications[i].toString().substring(
              Notifications[i].length - 4,
              Notifications[i].length)}-05-${Notifications[i].substring(
              Notifications[i].length - 8, Notifications[i].length - 6)} ${time[i]}');
        }}else if(checker == 'Jun'){
        if(Notifications[i].substring(Notifications[i].length-8, Notifications[i].length-7) == ' '){
          spacer = '0${Notifications[i].substring(Notifications[i].length-7, Notifications[i].length-6)} ${time[i]}';
          converteddate.add('${Notifications[i].toString().substring(Notifications[i].length-4, Notifications[i].length)}-07-$spacer');
        } else {
          converteddate.add('${Notifications[i].toString().substring(
              Notifications[i].length - 4,
              Notifications[i].length)}-06-${Notifications[i].substring(
              Notifications[i].length - 8, Notifications[i].length - 6)} ${time[i]}');
        }}else if(checker == 'Jul'){
        if(Notifications[i].substring(Notifications[i].length-8, Notifications[i].length-7) == ' '){
          spacer = '0${Notifications[i].substring(Notifications[i].length-7, Notifications[i].length-6)} ${time[i]}';
          converteddate.add('${Notifications[i].toString().substring(Notifications[i].length-4, Notifications[i].length)}-07-$spacer');
        }else {
          converteddate.add('${Notifications[i].toString().substring(
              Notifications[i].length - 4,
              Notifications[i].length)}-07-${Notifications[i].substring(
              Notifications[i].length - 8, Notifications[i].length - 6)} ${time[i]}');
        }}else if(checker == 'Aug'){
        if(Notifications[i].substring(Notifications[i].length-8, Notifications[i].length-7) == ' '){
          spacer = '0${Notifications[i].substring(Notifications[i].length-7, Notifications[i].length-6)} ${time[i]}';
          converteddate.add('${Notifications[i].toString().substring(Notifications[i].length-4, Notifications[i].length)}-08-$spacer');
        }else {
          converteddate.add('${Notifications[i].toString().substring(
              Notifications[i].length - 4,
              Notifications[i].length)}-08-${Notifications[i].substring(
              Notifications[i].length - 8, Notifications[i].length - 6)} ${time[i]}');
        }}else if(checker == 'Sep'){
        if(Notifications[i].substring(Notifications[i].length-8, Notifications[i].length-7) == ' '){
          spacer = '0${Notifications[i].substring(Notifications[i].length-7, Notifications[i].length-6)} ${time[i]}';
          converteddate.add('${Notifications[i].toString().substring(Notifications[i].length-4, Notifications[i].length)}-09-$spacer');
        }
        converteddate.add('${Notifications[i].toString().substring(Notifications[i].length-4, Notifications[i].length)}-09-${Notifications[i].substring(Notifications[i].length-8, Notifications[i].length-6)}');
      }else if(checker == 'Oct') {
        if (Notifications[i].substring(
            Notifications[i].length - 8, Notifications[i].length - 7) == ' ') {
          spacer = '0${Notifications[i].substring(Notifications[i].length - 7,
              Notifications[i].length - 6)} ${time[i]}';
          converteddate.add('${Notifications[i].toString().substring(
              Notifications[i].length - 4,
              Notifications[i].length)}-10-$spacer');
        }
        converteddate.add('${Notifications[i].toString().substring(
            Notifications[i].length - 4,
            Notifications[i].length)}-10-${Notifications[i].substring(
            Notifications[i].length - 8, Notifications[i].length - 6)} ${time[i]}');
      }else if(checker == 'Nov'){
        if(Notifications[i].substring(Notifications[i].length-8, Notifications[i].length-7) == ' '){
          spacer = '0${Notifications[i].substring(Notifications[i].length-7, Notifications[i].length-6)} ${time[i]}';
          converteddate.add('${Notifications[i].toString().substring(Notifications[i].length-4, Notifications[i].length)}-11-$spacer');
        }else {
          converteddate.add('${Notifications[i].toString().substring(
              Notifications[i].length - 4,
              Notifications[i].length)}-11-${Notifications[i].substring(
              Notifications[i].length - 8, Notifications[i].length - 6)} ${time[i]}');
        }}else if(checker == 'Dec'){
        if(Notifications[i].substring(Notifications[i].length-8, Notifications[i].length-7) == ' '){
          spacer = '0${Notifications[i].substring(Notifications[i].length-7, Notifications[i].length-6)} ${time[i]}';
          converteddate.add('${Notifications[i].toString().substring(Notifications[i].length-4, Notifications[i].length)}-12-$spacer');
        }else {
          converteddate.add('${Notifications[i].toString().substring(
              Notifications[i].length - 4,
              Notifications[i].length)}-12-${Notifications[i].substring(
              Notifications[i].length - 8, Notifications[i].length - 6)} ${time[i]}');
        }
      } else{
        return [];
      }
      print(converteddate);
    }
    return converteddate;
  }

  Future getuserInfo() async{
    // FirebaseFirestore _instance= FirebaseFirestore.instance;

    DocumentSnapshot User = await users
        .doc('$uid').get();
    var virtual = User['virtualBalance'];
    var actualBalance = User['actualBalance'].toString();
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