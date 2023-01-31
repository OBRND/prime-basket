import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:primebasket/Models/chatentries.dart';
import 'package:primebasket/Services/Database.dart';
import 'package:primebasket/Services/Storage.dart';
import 'package:primebasket/Widget/bottom_tab.dart';
import 'package:provider/provider.dart';

import '../../Models/chatModel.dart';
import '../../Services/User.dart';
import '../../Services/transactions.dart';
import '../../Widget/decorations.dart';

class chatscreen extends StatefulWidget {
String tradesID;
String amount;
String chatID;
chatscreen({required this.tradesID, required this.amount, required this.chatID});

@override
  State<chatscreen> createState() => _chatscreenState(tradesID: tradesID, amount: amount, chatID: chatID);
}



class _chatscreenState extends State<chatscreen> {
  String tradesID;
  String amount;
  String chatID;
  _chatscreenState({required this.tradesID, required this.amount, required this.chatID});

  List<ChatMessage> messages = [ ];
  CollectionReference snapshot = FirebaseFirestore.instance.collection('chats');

  Stream messagesStream() {
    return snapshot.doc('$chatID').snapshots();
    // return chats;
  }

  Future getimageurl() async{
    final Storage storage = Storage();
    var result = await storage.getdata(tradesID);
    // messages.add(ChatMessage(messageContent: result, messageType: 'sender', type: 'image'));
    return result;
  }
  late List ku =[];
  Future getallmessages(user) async{
    final DatabaseService db = DatabaseService(uid: user!.uid);
    Map result = await db.getmessages(chatID);
    List x = [];
    print('*******************************$result');
    // for (var key in result.keys) {
    //   if (kDebugMode) {
    //         ku.add('${key.toString().substring(key.toString().length-2,key.toString().length)} : ${result[key]}');
    //         ku.sort((a,b) => a.compareTo(b));
    //         print('Key : $key : ${result[key]}');
    //     print('Value: ${result[key]}');
    //     print('\n');
    //         print(ku);
    //   }
    // }
    print('rebuild');

    result.entries.forEach((e) {
      x.add(Chatentries(key: e.key.toString().substring(e.key.toString().length-2,e.key.toString().length), content: e.value, id: e.key.toString().substring(0, 5)));
      x.sort((a,b) => a.key.compareTo(b.key));

      print('|||||||| ${x[0].key} - ${x[0].id} - ${x[0].content}');
    });

    for(int i = 0; i < x.length; i++){
        // print('key: ${x[i].key.toString().substring(x[i].key.toString().length-2,x[i].key.toString().length)} mes: ${messages.length} value: ${x[i].content}');
      print('|||||||| ${x[0].key} - ${x[0].id} - ${x[0].content}|||||||||');
      if(x[i].id == user.uid.toString().substring(0,5) && double.parse(x[i].key) > messages.length){
        // print('please work');
        if(x[i].content.toString().startsWith('https://')) {
          // print('please work here');

          messages.add(ChatMessage(
                   messageContent: '${x[i].content}',
                   messageType: 'sender',
                   type: 'image',
                   precedence: int.parse(x[i].key)));
             }
             else{
                messages.add(ChatMessage(
                    messageContent: '${x[i].content}',
                    messageType: 'sender',
                    type: 'text',
                    precedence: int.parse(x[i].key)));
              }
            }else if( x[i].id != user.uid.toString().substring(0,5) && double.parse(x[i].key) > messages.length) {
        // print('please work');
        if(x[i].content.toString().startsWith('https://')) {
                messages.add(ChatMessage(
                    messageContent: '${x[i].content}',
                    messageType: 'receiver',
                    type: 'image',
                    precedence: int.parse(x[i].key)));
              }
              else{
                 messages.add(ChatMessage(
                    messageContent: '${x[i].content}',
                    messageType: 'receiver',
                    type: 'text',
                    precedence: int.parse(x[i].key)));
              }
            }
            messages.sort((a,b) => a.precedence.compareTo(b.precedence));
print(messages);
      }

    // result.entries.forEach((e) {
    //
    //
    //   print('key: ${e.key.toString().substring(e.key.toString().length-2,e.key.toString().length)} mes: ${messages.length} value: ${e.value}');
    //   if(e.key.toString().substring(0,5) == user.uid.toString().substring(0,5) && x[i].key > messages.length ){
    //    if(e.value.toString().startsWith('https://')) {
    //      messages.add(ChatMessage(
    //          messageContent: '${x[i].value}',
    //          messageType: 'sender',
    //          type: 'image',
    //          precedence: int.parse(e.key.toString().substring(
    //              e.key.toString().length - 2, e.key.toString().length))));
    //    }
    //    else{
    //       messages.add(ChatMessage(
    //           messageContent: '${x[i].value}',
    //           messageType: 'sender',
    //           type: 'text',
    //           precedence: int.parse(e.key.toString().substring(
    //               e.key.toString().length - 2, e.key.toString().length))));
    //     }
    //   }else if( double.parse(e.key.toString().substring(e.key.toString().length-2,e.key.toString().length)) > messages.length) {
    //     if(e.value.toString().startsWith('https://')) {
    //       messages.add(ChatMessage(
    //           messageContent: '${x[i].value}',
    //           messageType: 'receiver',
    //           type: 'image',
    //           precedence: int.parse(e.key.toString().substring(
    //               e.key.toString().length - 2, e.key.toString().length))));
    //     }
    //     else{
    //        messages.add(ChatMessage(
    //           messageContent: '${x[i].value}',
    //           messageType: 'receiver',
    //           type: 'text',
    //           precedence: int.parse(e.key.toString().substring(
    //               e.key.toString().length - 2, e.key.toString().length))));
    //     }
    //   }
    //   i= i + 1;
      messages.sort((a,b) => a.precedence.compareTo(b.precedence));
    // });

    // messages.add(ChatMessage(messageContent: result, messageType: 'sender', type: 'image'));
    return result;
  }
  // final myController = TextEditingController();
  final List<TextEditingController> myController =
  List.generate(2, (i) => TextEditingController());
  @override
  void initState() {
    final user = FirebaseAuth.instance.currentUser!;
    if(amount != '0'){
      DatabaseService(uid: user.uid).updatechat("Hello, I would like to top up $amount", chatID );
      messages.add(ChatMessage(messageContent: "Hello, I would like to top up $amount", messageType: "receiver", type: 'text', precedence: 1),);
    }
    super.initState();
  }
  Future wait() async{
    final user = FirebaseAuth.instance.currentUser!;
    final DatabaseService db = DatabaseService(uid: user!.uid);
    await db.updatechat(myController[0].text, chatID);
  }
  @override
  void dispose() {
    myController[0].dispose();
    myController[1].dispose();
    super.dispose();
  }
  final ScrollController _sc = ScrollController();

  @override
  Widget build(BuildContext context) {
    print('///////////////////////////$tradesID');
    final Storage storage = Storage();
    final user = FirebaseAuth.instance.currentUser!;
    final DatabaseService db = DatabaseService(uid: user!.uid);
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            // fit: StackFit.passthrough,
              children: <Widget>[
                SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height *.85,
                    width: MediaQuery.of(context).size.width*.85,
                    child: FutureBuilder(
                      future: getallmessages(user),
                        builder: (BuildContext context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.black38,
                                  ));
                            default: return StreamBuilder(
                                  stream: messagesStream(),
                                  builder: (BuildContext context, AsyncSnapshot snap) {
                                    print(messages);
                                    if (snap.hasError) {
                                    return Text('Something went wrong');
                                  }
                                  if (snap.connectionState == ConnectionState.waiting) {
                                    return Text("Loading");
                                  }
                                  // messages.add(ChatMessage(messageContent: '${snap.data['chatValues']['4y9r3uWdmZgahwguu5cjjl3fodk2 ${messages.length}']}',
                                  //     messageType: 'sender', type: 'text'));
                                  // print(snap.data['chatValues'][0]);
                                  return ListView.builder(
                                    // controller: _sc,
                                    reverse: true,
                                    dragStartBehavior: DragStartBehavior.down,
                                    itemCount: messages.length,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.only(top: 10, bottom: 10),
                                    // physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      final reversedIndex = messages.length - 1 - index;
                                      // WidgetsBinding.instance.addPostFrameCallback((_) => {_sc.jumpTo(_sc.position.maxScrollExtent)});
                                      messages[reversedIndex].type == 'image' ? print('an image'): print(' a text');
                                      return Container(
                                        padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                                        child: Align(
                                          alignment: (messages[reversedIndex].messageType == "receiver" ? Alignment.topLeft : Alignment.topRight),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: (messages[reversedIndex].messageType == "receiver" ? Colors.grey.shade200 : Colors.blue[200]),
                                            ),
                                            padding: EdgeInsets.all(16),
                                            child: messages[reversedIndex].type == 'image' ?
                                            Container(
                                              child: Image.network(
                                                  errorBuilder:  (context, error, stackTrace) {
                                                    return Container(
                                                      color: Colors.black12,
                                                      alignment: Alignment.center,
                                                      child: const Text(
                                                        'Whoops!, check your connection and try again',
                                                        style: TextStyle(fontSize: 25),
                                                      ),
                                                    );
                                                  },
                                                  '${messages[reversedIndex].messageContent}'),
                                            ) : Text(messages[reversedIndex].messageContent,
                                              style: TextStyle(fontSize: 15),),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                  });
                          }
                      }
                    ),
                  ),
                ),
    StreamBuilder(
    stream: messagesStream(),
    builder: (BuildContext context, AsyncSnapshot snap) {
      return snap.data['released'] == false ? Container(
                  height: MediaQuery.of(context).size.height*.25,
                  color: Colors.black54,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton(onPressed: () async{
                            SnackBar snackBar = SnackBar(
                              backgroundColor: Colors.transparent,
                              content: Card(
                                  color: Colors.redAccent,
                                  child: Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.dangerous_rounded),
                                        Text(' please pick a file!', style: TextStyle(
                                            fontSize: MediaQuery.of(context).size.width*.055, fontWeight: FontWeight.w600
                                        ),),
                                      ],
                                    ),
                                  )),
                            );
                            final results = await  FilePicker.platform.pickFiles(
                              allowMultiple: false,
                              type: FileType.image, );
                            if(results == null){
                               ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }
                              final path = results?.files.single.path;
                              final filename = results?.files.single.name;
                              print('$path');
                              print('$filename');
                              await storage.uploadfile(filename!, path!, tradesID).then((value) => print('----------------done!============='));
                              var result = await getimageurl();
                              print('result: $result');
                              await db.updatechat("$result", chatID);

                          }, child: Icon(Icons.photo_outlined),
                            style: ButtonStyle(
                                foregroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
                                backgroundColor: MaterialStateColor.resolveWith((states) => Colors.transparent,
                                )),),
                          Container(
                            height: MediaQuery.of(context).size.height *.1,
                            width: MediaQuery.of(context).size.width *.6,
                            child: TextFormField(
                              validator: (val) => val!.isEmpty ? 'Enter a message' : null,
                              style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05),
                              decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                              ),
                              controller: myController[0],
                            ),
                          ),
                          TextButton(onPressed: () async{
                            // var result = await storage.getdata(tradesID);
                            // print(result);
                            print('${myController[0].text}');

                            await db.updatechat(myController[0].text, chatID);
                            // await db.getmessages();
                            setState(() => myController[0].text = ''
                            );
                            }, child: Icon(Icons.send_rounded),
                            style: ButtonStyle(
                                // shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                // RoundedRectangleBorder( borderRadius: BorderRadius.circular(10.0),)),
                                foregroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
                                backgroundColor: MaterialStateColor.resolveWith((states) => Colors.transparent,
                                )),
                          ),
                        ],
                      ),
                      StreamBuilder(
                          stream: messagesStream(),
                          builder: (BuildContext context, AsyncSnapshot snap) {
                            final user = FirebaseAuth.instance.currentUser!;
                          double size = MediaQuery.of(context).size.width;
                            print(messages);
                            return
                              snap.data['traderUID'] == user!.uid?
                             Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children:snap.data['status'] == 'OK' ? [ Center(
                                 child: Container(
                                   width: MediaQuery.of(context).size.width*.3,
                                   height: MediaQuery.of(context).size.height*.08,
                                   child: ElevatedButton(onPressed: snap.data['status'] == 'OK' ?() async{
                                     await db.release(chatID);
                                   } : () async{
                                     List error = await checkTransactionReceiptStatus(myController[1].text, 2);
                                     if(error[0] == 'Succesfull'){
                                       db.settxnhash(chatID, myController[1].text, error[1]);
                                     }
                                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$error')));
                                   },
                                       style: ElevatedButton.styleFrom(
                                         backgroundColor: snap.data['status'] == 'OK' ? Colors.lightGreen : Colors.redAccent,
                                         foregroundColor: Colors.white,
                                         elevation: 0,
                                       ),
                                       child: snap.data['status'] == 'OK' ? Text('Release') : Text('Submit')),
                                 ),
                               )]: [
                                 Container(
                                   width: MediaQuery.of(context).size.width*.7,
                                   child: TextFormField(
                                   validator: (val) => val!.isEmpty ? 'Enter a transaction hash' : null,
                                   style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05),
                                   decoration: const InputDecoration(
                                     hintText: 'Transaction hash',
                                     fillColor: Colors.white,
                                     filled: true,
                                   ),
                                   controller: myController[1],
                               ),
                                 ),
                                 Container(
                                   width: MediaQuery.of(context).size.width*.3,
                                   height: MediaQuery.of(context).size.height*.08,
                                   child: ElevatedButton(onPressed: snap.data['status'] == 'OK' ?() async{
                                     await db.release(chatID);
                                   } : () async{
                                     List error = await checkTransactionReceiptStatus(myController[1].text, 2);
                                     if(error[0] == 'Succesfull'){
                                       db.settxnhash(chatID, myController[1].text, error[1]);
                                     }
                                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${error[0]}')));
                                   },
                                       style: ElevatedButton.styleFrom(
                                         backgroundColor: snap.data['status'] == 'OK' ? Colors.lightGreen : Colors.redAccent,
                                         foregroundColor: Colors.white,
                                         elevation: 0,
                                       ),
                                       child: snap.data['status'] == 'OK' ? Text('Release') : Text('Submit')),
                                 )

                               ],
                             ) :
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(snap.data['amount'] == ''? 'Amount: 0' : 'Amount: ${snap.data['amount']}', style: TextStyle(fontWeight: FontWeight.w400,fontSize: size*.055, color: Colors.white),),
                                      Text('Status: ${snap.data['status']}', style: TextStyle(fontWeight: FontWeight.w400,fontSize: size*.055, color: Colors.white),),
                                      Text('Waiting for release', style: TextStyle(fontWeight: FontWeight.w400,fontSize: size*.055, color: Colors.white),),
                                    ])
                              ],
                            );
                          }
                      )
                    ],
                  ),
      ) : snap.data['traderUID'] != user!.uid ?  SingleChildScrollView(
        child: FutureBuilder(
            future: checkTransactionReceiptStatus(snap.data['TXN'], 1),
            builder: (BuildContext context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.black38,));
                default: return AlertDialog(
                  contentPadding: EdgeInsets.all(10),
                  scrollable: true,
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(" Congrats! you have succesfully topped up \$${snap.data['amount']} confirm to conclude transaction. and please check your new balance in the Account tab",
                        style: TextStyle(color: Colors.black54, fontSize: 18, fontWeight: FontWeight.w400),),
                      ElevatedButton(onPressed: () async{
                        await db.updatevitualamount(double.parse(snap.data['amount']));
                        db.deletechat(chatID);
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => BottomTab( index: 0,) ));
                      },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightGreen,
                          foregroundColor: Colors.white,
                          // elevation: 0,
                        ),
                        child: Text('Ok'),)
                    ],
                  ),
                );
              }
            }
        ),
      ): Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child: Text('Transaction finished', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),)),
      );
      Future.delayed(Duration(seconds: 2), () { Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => BottomTab( index: 0,) ));
      });
                      })
              ]
          ),
        )
    );
  }
}
