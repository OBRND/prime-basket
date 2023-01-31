import 'package:flutter/material.dart';
import 'package:primebasket/Models/tradesModel.dart';
import 'package:primebasket/Screens/Topuppages/chatscreen.dart';
import 'package:primebasket/Services/Database.dart';
import 'package:provider/provider.dart';

import '../../Services/User.dart';
import '../../Widget/bottomnavtab.dart';

class mytrades extends StatefulWidget {
  const mytrades({Key? key}) : super(key: key);

  @override
  State<mytrades> createState() => _mytradesState();
}

class _mytradesState extends State<mytrades> {

  Future gettrades(BuildContext context) async{
    final user = Provider.of<UserFB?>(context);
    final uid = user!.uid;
    DatabaseService db = DatabaseService(uid: uid);
    List obj = await db.gettradeschatinitiated();
    return obj;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserFB?>(context);
    final uid = user!.uid;
    TextStyle style = TextStyle(fontSize: 20, fontWeight: FontWeight.w500,);
    return Scaffold(
      appBar: AppBar(
      title: Text('All trades'),
        backgroundColor: Colors.blueAccent,
        elevation: 3,
      ),
      bottomNavigationBar: bottomtabwidget(),
      body:FutureBuilder(
          future: gettrades(context),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                List<Widget> list = <Widget>[];
                for(var i = 0; i < snapshot.data.length; i++) {
                  print('||||||||||||||||||||||||||||||||||||${snapshot.data[i].chatID}');
                  print(snapshot.data);
                  list.add( Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: InkWell(
                      onTap: () {
                        snapshot.data[i].TraderUID == uid ||
                            snapshot.data[i].userUID == uid ?
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) =>
                                chatscreen(tradesID: snapshot.data[i].traderUID,
                                    amount: '0', chatID: snapshot.data[i].chatID,))) : null;
                        },
                      child: Card(
                        color: Colors.white70,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Currency: ${snapshot.data[i].currency}', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),),
                                  Text('Bank/Wallet: ${snapshot.data[i].bank}'),
                                ],
                              ),
                              // SizedBox(width: MediaQuery.of(context).size.width*.13,),
                              Text('\$${snapshot.data[i].amount}',  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ));
                }
                print(list.length);
                return
                  snapshot.data == null ? Center(child: Text('There are no ongoing trade at this moment')) :
                SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: list),
                  ),
                );
            }
          }
      ),
    );
  }
}
