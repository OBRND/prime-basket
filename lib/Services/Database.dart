import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:primebasket/Models/initiatedModel.dart';
import 'package:primebasket/Models/notificationModel.dart';
import 'package:primebasket/Models/orderModel.dart';
import 'package:primebasket/Models/tradesModel.dart';
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
  final CollectionReference p2ptrades = FirebaseFirestore.instance.collection('p2pTrades');
  final CollectionReference p2pagents = FirebaseFirestore.instance.collection('p2pAgents');
  final CollectionReference chats = FirebaseFirestore.instance.collection('chats');
  final CollectionReference transactions = FirebaseFirestore.instance.collection('Transactions');
  final alluserdetails = FirebaseAuth.instance.currentUser!;

  Future createuserdata(String email) async{
    await users.doc(uid).set({
      'actualBalance': '0',
      'chats': [],
      'completedChats': '0',
      'email' : '$email',
      'estimatedEarnings': '0',
      'firstLogin': true,
      'myOpenTrades': [],
      'numberOfTrades': 1,
      'orders': [],
      'p2p': false,
      'referralCode': '',
      'referredCount': '0',
      'requestedTrades': {},
      'successRate': '0',
      'tier': '1',
      'totalChats': '0',
      'totalTopUp': 3,
      'uid': '$uid',
      'updatedDate': '${DateTime.now()}',
      'virtualBalance': '3'
    });
  }

  Future isfirstlogin() async{
    DocumentSnapshot first = await users.doc(uid).get();
    bool isfirst = first['firstLogin'];
    return isfirst;
  }
  String Error = '';
  Future doesreferalexist(referal) async{
    final result = users.doc(referal);
    await result.get().then((doc) => {
    if (doc.exists) {
    Error = 'exists'
  } else {
    // doc.data() will be undefined in this case
    Error = 'Does not exist'
    }

    }).catchError((error) =>{
        Error = error});

    return Error;
  }
  Future setreferal(referal) async{
    await users.doc(uid).update({
      'referralCode': '$referal',
      'firstLogin': false,
    });
    final result = await users.doc(referal).get();
    if(result.exists){
      int count = int.parse(result['referredCount']);
      await users.doc(referal).update({
        'referredCount': '${count + 1}'
      });
    }
    }
    Future updatecount() async{
    await users.doc(uid).update({
    'referredCount': '0'
    });
    final result = await users.doc(uid).get();
    if(result.exists){
      int tier = int.parse(result['tier']);
      await users.doc(uid).update({
        'tier': '${tier + 1}'
      });
    }
    }

    Future getwithdrawalstext() async{
      QuerySnapshot querySnapshot = await Withdrawals.get();
      var withdrawalss = await querySnapshot.docs;
      String text = '';
      for(int i = 0; i < withdrawalss.length; i++ ){
        if(withdrawalss[i]['status'] == 'success') {
        text +=
            '${withdrawalss[i]['email'].substring(0, 1)}***** ${withdrawalss[i]['email'].substring(withdrawalss[i]['email'].length - 11)}'
                    ' has withdrawn \$' +
                withdrawalss[i]['amount'].toStringAsFixed(2) +
                '      ';
      }
    }
      return text;
      }
  Future checkchat(uid) async{
    QuerySnapshot querySnapshot = await chats.get();
    var ids = await querySnapshot.docs;
    for(int x = 0; x <= ids.length -1 ; x++ ){

    }
    }

    Future deletetrades() async{
      QuerySnapshot querySnapshot = await p2ptrades.get();
      // DocumentSnapshot trades = await p2ptrades
      //     .doc('$uid').get();
      var tradesp2p = await querySnapshot.docs;
      for(int i = 0 ; i < tradesp2p.length ;i++) {
      if(tradesp2p[i]['traderUID'] == uid){
        String tradeId = tradesp2p[i]['tradeID'];
        await p2ptrades.doc(tradeId).delete();
        print('${tradesp2p[i]['tradeID']} deleted');
      }
    }
  }

  Future createnewtrade(String chatid, String tradeid, String traderid) async{
    await chats.doc(chatid).set({
      'TXN': '',
      'amount': '',
      'chatValues' : {},
      'released': false,
      'senderFcm': '',
      'status': 'WAITING',
      'timesTamp': DateTime.now(),
      'tradeID': tradeid,
      'traderUID': traderid,
      'userUID': uid,
    });
  }

    Future addtrader(int price, String bank, String currency) async{
    String tradeid = generateorderId();
    await p2ptrades.doc(tradeid).set({
      'bankOrWallet': bank,
      'country': currency,
      'email': alluserdetails.email,
      'numberOfTrades': 1,
      'price': price,
      'successRate': '0',
      'tradeID': tradeid,
      'traderUID': uid
    });

    }
    Future addnewagent(Map data) async{
    // Map data;
      print('rrrrrrrrrrrr$data');

    await p2pagents.doc(uid).
    set({
      'email': alluserdetails.email,
      'numberOfTrades': 1,
      'p2pAgentData': data,
      'successRate': 1,
    });

    }

    Future checkp2p() async{
      DocumentSnapshot hadp2p = await users.doc(uid).get();
      bool hasinitiatd = hadp2p['p2p'];
      return hasinitiatd;
    }
    Future getearnings() async{
    List allestearnings = [];
    final query = await  orderscollection.where('email', isEqualTo: uid).where("status", isEqualTo: "cancelled");
   var qury =  await query.get();
   var m = qury.docs;
    print('this failed: ${m}');
    List orderIDs = await getOrderID();
    if( orderIDs.isEmpty){
      return allestearnings;
    }
    else {
      for (int i = 0; i < orderIDs.length; i++) {
        DocumentSnapshot orderEsts =
            await orderscollection.doc(orderIDs[i]).get();
        String earn = orderEsts['earnings'];
        String status = orderEsts['status'];
        print('$i '
            '$status');
        allestearnings.add(withdrawalhistory(
            amount: earn,
            status: status,
            time: '-',
            tobeesorted: DateTime(2023)));
      }
      return allestearnings;
    }
  }

    Future settxnhash(chatID, String txnhash, String amount) async{
      await chats.doc('$chatID').update({
        'TXN' : txnhash,
        'amount': amount,
        'status': 'OK'
      });
    }

    Future release(chatID) async{
      await chats.doc('$chatID').update({
        'released' : true
      });
    }

  Future getmessages(String chatid) async{
    Map chatlist;
    DocumentSnapshot chat = await chats.doc('$chatid').get();
    print('|||||||||${chat['chatValues']}');
    chatlist =  chat['chatValues'];
        return chatlist;


    // chats.doc().get().then((DocumentSnapshot documentSnapshot) {
    // for(int x = 0; x <= chat.length -1 ; x++ ){
    //   if (chat[x]['traderUID'] == uid || chat[x]['userUID'] == uid) {
    //     chatlist =  chat[x]['chatValues'];
    //     // chatlist.putIfAbsent('$uid $i', () => 'bhbh');
    //       // ({'yre': 'sdsd'});
    //     print(chatlist);
    //     return chatlist;
    //   }
    //   else {
    //     print('Document does not exist on the database');
    //   }
    // }
    // });

  }

  Future updatevitualamount(double newamount) async{
    DocumentSnapshot getuserorder = await users.doc('$uid').get();
    String balance = getuserorder['virtualBalance'];
    double newbal = double.parse(balance) + newamount;
    String newbalance = newbal.toString();
    print("yayayayayayyayayaa");
    await users.doc(uid).update({
      'virtualBalance': newbalance
    });
  }
  Future deletechat(String ID) async {
    await chats.doc(ID).delete();
  }
  late String lastuid;
  int lasti = 1;
  Future updatechat(String text, String chatID) async{
    int i = 1;
    Map chatprevious = await getmessages(chatID);
    // Map chatslist ;
    // DocumentSnapshot list = await chats.doc('1V4r2qcAYcK9YfjeFyYC').get();
    QuerySnapshot querySnapshot = await chats.get();
    var Chat = await querySnapshot.docs;
    // while(chatprevious.containsKey('$uid $i')){
    //   this.lastuid = '$uid $i';
    //   this.lasti = i;
    //   i++;
    // }
    chatprevious.putIfAbsent('$uid ${chatprevious.length + 1}', () => '$text');
    // chatslist = list['chatValues'];
    // chatslist.addAll(chat);
    await chats.doc('$chatID').update({
      'chatValues' : chatprevious
    });
  }
  Future withdraw(withdrawModel withdrawal) async{
    String withdrawalID = generateorderId();
    await Withdrawals.doc(withdrawalID).set({
      'account' : withdrawal.account,
      'amount': withdrawal.amount,
      'bank': withdrawal.bank,
      'country': withdrawal.country,
      'email': withdrawal.email,
      'status': withdrawal.status,
      'time': withdrawal.time,
      'uid': uid,
    });
    List user = await getuserInfo();
    double x = double.parse(user[1]) - withdrawal.amount.toDouble();
    await users.doc(uid).update({
      'actualBalance': '$x',
    });

  }

  Future gettrades() async{
    List Trades = [];
    QuerySnapshot querySnapshot = await p2ptrades.get();
    // DocumentSnapshot trades = await p2ptrades
    //     .doc('$uid').get();
    var trades = await querySnapshot.docs;
    print('=====${trades[0]['traderUID']}======');
    for(int i=0; i < trades.length; i++){
      print(trades[i]['tradeID']);
      print(trades[i]['price']);
      print(trades[i]['tradeID']);
      print(trades[i]['price'].runtimeType);
      print(trades[i]['country']);
      print(trades[i]['email']);
      print(trades[i]['bankOrWallet'].runtimeType);
      print(trades[i]['numberOfTrades'].runtimeType);
      print(trades[i]['successRate']);
      print(trades[i]['tradeID']);

      Trades.add(tradesModel(amount: trades[i]['price'], currency: trades[i]['country'],
          email: trades[i]['email'], bank: trades[i]['bankOrWallet'],
          numberoftrades: trades[i]['numberOfTrades'], successrate: trades[i]['successRate'], traderUID: trades[i]['traderUID'], tradeID: trades[i]['tradeID']));
    }
    print('+++++++++++$Trades ++++++++');
    return Trades;
  }
  Future gettradeschatinitiated() async{
    List Trades = [];
    List chatdocs = [];
    QuerySnapshot querySnapshot = await chats.get();
    // DocumentSnapshot trades = await p2ptrades
    //     .doc('$uid').get();
    var initiated = await querySnapshot.docs;
    await chats.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((DocumentSnapshot doc) {
        chatdocs.add(doc.id);
      });
    });
    print(chatdocs);
    if(initiated.isNotEmpty){
      for (int i = 0; i < initiated.length; i++) {
        String tradeID = initiated[i]['tradeID'];
        String traderuid = initiated[i]['traderUID'];
        String useruid = initiated[i]['userUID'];
        DocumentSnapshot tradesinitiated =
            await p2ptrades.doc("$tradeID").get();
        if(tradesinitiated.exists){
        print(tradesinitiated['tradeID']);
        print(tradesinitiated['price']);
        Trades.add(initiatedModel(
                amount: (tradesinitiated['price']).toDouble(),
                currency: tradesinitiated['country'],
                bank: tradesinitiated['bankOrWallet'],
                traderUID: tradesinitiated['tradeID'],
                TraderUID: traderuid,
                userUID: useruid,
                chatID: chatdocs[i])

            // tradesModel(amount: tradesinitiated['price'], currency: tradesinitiated['country'],
            // email: tradesinitiated['email'], bank: tradesinitiated['bankOrWallet'],
            // numberoftrades: tradesinitiated['numberOfTrades'], successrate: tradesinitiated['successRate'],
            // traderUID: tradesinitiated['tradeID'])
            );}

        print('Completed pass $i');
      }
    }
    print('+++++++++++$Trades ++++++++');
    return Trades;
  }

  Future topuptxn(List txn) async{
    await transactions.doc(txn[2]).set({
      'amount' : txn[0],
      'status': txn[1],
      'traderUID': '',
      'userUID': uid,
      'Date': DateFormat.yMd().format(DateTime.now()).toString()
    });
   List userinfo = await getuserInfo();
   double newbalance = double.parse(txn[0]) + double.parse(userinfo[0]);
    await users.doc(uid).update({
      'virtualBalance': newbalance.toString()
    });
  }

  Future getsharecount() async{
    DocumentSnapshot User = await users
        .doc('$uid').get();
   String count = await User['referredCount'];
   return count;
  }
  Future gettopuphistory() async{
    List topup = [];
    QuerySnapshot querySnapshot = await transactions.get();
    var topups = await querySnapshot.docs;
    for(int i=0; i < topups.length; i++){
      if(topups[i]['userUID'] == uid){
        topup.add(withdrawalhistory(amount: topups[i]['amount'], status: '-', time: topups[i]['Date'],
            tobeesorted: DateFormat.yMd('en_US').parse(topups[i]['Date'])));
      }
    }
    return topup;
  }

  Future getwithdrawalhistory() async{
    List history = [];
    List banks = [];
    List status = [];
    List dates = [];
    List sorted = [];
    QuerySnapshot querySnapshot = await Withdrawals.get();
    // print(querySnapshot);
    var allwithdrawals = await querySnapshot.docs;
    for(int i=0; i < allwithdrawals.length; i++){
      // print('${allwithdrawals[i]['amount']}');
      // print('|||||||||||||||||||');
      if(allwithdrawals[i]['uid'] == uid){
        // print('----------------');
        dates.add('${allwithdrawals[i]['time']} $i');
        // index.add(i:'gf');
    dates.sort((a,b) => a.compareTo(b));
      }
      }
    for(int i = 0; i < dates.length; i++){
      // print(dates);
      sorted.add(allwithdrawals[int.parse(dates[i].substring(dates[i].length-2, dates[i].length))]['amount']);
      status.add(allwithdrawals[int.parse(dates[i].substring(dates[i].length-2, dates[i].length))]['status']);
      // banks.add(allwithdrawals[int.parse(dates[i].substring(dates[i].length-2, dates[i].length))]['bank']);
    }
    for(int i = 0; i < dates.length; i++) {
      history.add(withdrawalhistory(amount: sorted[i], time: dates[i].substring(0 ,dates[i].length-2),
        status: status[i], tobeesorted: DateFormat.yMd('en_US').parse(dates[i].substring(0 ,dates[i].length-2))));
    }

    return history;
  }

  Future gettransactionHash() async{
    List Txns = [];
    // await Txn.get().then((QuerySnapshot snapshot) {
    //   snapshot.docs.forEach((DocumentSnapshot doc) {
    //     Txns.add(doc.id);
    //   });
    // });
    await transactions.get().then((QuerySnapshot snapshot) {
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
      var o = getuserorder['deliveredQty'];
      print('$i $o');
      // print('*****qty: ${getuserorder['deliveredQty']}, earnings: ${getuserorder['earnings']},pName: ${getuserorder['productName']}, total: ${getuserorder['totalAmount']}, Status: ${getuserorder['status']}');
      orderModel singleorder = orderModel(qty: getuserorder['deliveredQty'], earnings: getuserorder['earnings'], pName: getuserorder['productName'], total: getuserorder['totalAmount'], Status: getuserorder['status']);
      // print(singleorder);
      Orderlist.add(singleorder);
    // print('-----------------------------------------------------qty: ${getuserorder['deliveredQty']}, earnings: ${getuserorder['earnings']},pName: ${getuserorder['productName']}, total: ${getuserorder['totalAmount']}, Status: ${getuserorder['status']}');
    }
    // print('=======${Orderlist}');

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

  Stream<QuerySnapshot> get info{
    return users.snapshots();
  }

}