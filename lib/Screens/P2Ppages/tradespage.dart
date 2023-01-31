import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:primebasket/Models/tradesModel.dart';
import 'package:primebasket/Screens/P2Ppages/mytrades.dart';
import 'package:primebasket/Screens/Topuppages/chatscreen.dart';
import 'package:provider/provider.dart';

import '../../Services/Database.dart';
import '../../Services/User.dart';
import '../../Widget/bottomnavtab.dart';
import '../../Widget/decorations.dart';

class trades extends StatefulWidget {
  String currency;
  // const trades(required this.currency, {Key? key}) : super(key: key);
trades({required this.currency});
  @override
  State<trades> createState() => _tradesState(currency: currency);
}

class _tradesState extends State<trades> {
  String currency;
 _tradesState({required this.currency});

  Future trades(context) async{
    final user = Provider.of<UserFB?>(context);
    List details = await DatabaseService(uid: user!.uid).gettrades();
    print('||||||||||||||||||$details|||||||||||||||||||');
    // accountdata = details;
    return details;
  }
  Future refreshedtrades() async{
  setState(() {
    rate= 1;
  });
  }
  Future gettradesnumber(BuildContext context) async{
    final user = Provider.of<UserFB?>(context);
    final uid = user!.uid;
    DatabaseService db = DatabaseService(uid: uid);
    List obj = await db.gettradeschatinitiated();
    return obj.length;
  }
  List Tradeslist = [];
  double amount = 0;
  int rate = 1;
  final _formkey = GlobalKey<FormState>();
  final bool allowDecimal = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mobile wallet', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20,),),
        elevation: 0,
        backgroundColor: Colors.blueAccent,
      ),
      bottomNavigationBar: bottomtabwidget(),
      body: ListView(
        children: [
          SizedBox(height: 20,),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FutureBuilder( future: gettradesnumber(context),
                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Center(child: ElevatedButton(onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => mytrades()));
                          },
                              style: ButtonStyle(shape: MaterialStateProperty
                                  .all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),)
                              ),
                                  backgroundColor: MaterialStateColor
                                      .resolveWith((states) =>
                                  Colors.blueAccent)),
                              child: Row(
                                children: [
                                  Text('Trades'),
                                ],
                              )),);
                        default:
                          return ElevatedButton(onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => mytrades()));
                          },
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            10.0),)
                                  ),
                                  backgroundColor: MaterialStateColor
                                      .resolveWith((states) =>
                                  Colors.blueAccent)),
                              child: snapshot.data == 0 ?
                              Text('Trades') : Row(
                                children: [
                                  Text('Trades  '),
                                  Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(15),
                                          border: Border.all(
                                              width: 1,
                                              color: Colors.black54
                                          )
                                      ),
                                      child: Text(' ${snapshot.data} ', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black54),))
                                ],
                              ));
                      }
                    }),
                ElevatedButton(onPressed: () async{
                  final user = Provider.of<UserFB?>(context, listen: false);
                  await DatabaseService(uid: user!.uid).deletetrades();
                  setState(() {
                    int rate = 1;
                  });
                  },
                    style: ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder( borderRadius: BorderRadius.circular(10.0),)
                    ),
                        backgroundColor: MaterialStateColor.resolveWith((states) => Colors.redAccent)),
                    child: Text('Exit trades'))
              ],
            ),
          ),
          Center(child: Text('Drag down to refresh page', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300, backgroundColor: Colors.white54))),
          Container(
            height: MediaQuery.of(context).size.height * .6,
            width:  MediaQuery.of(context).size.width * .9,
            child: RefreshIndicator(
              onRefresh: refreshedtrades,
              child: FutureBuilder(
                future: trades(context),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  switch(snapshot.connectionState){
                    case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator());
                    default:
                     return snapshot.data == null ? Center(
                         child: ListView(
                           padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .3),
                             children: const [Center(child: Text('There are no trade at this moment'))])) :
                      ListView.separated(
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.all(10),
                        itemCount: 1,
                        separatorBuilder: (context, index){
                          return const SizedBox(width: 100);},
                        itemBuilder: (context, index) {
                          List<Widget> selectedlist = <Widget>[];
                          for(var i = 0; i < snapshot.data.length; i++) {
                            if(snapshot.data[i].currency == currency){
                                    selectedlist.add(buildtrade(snapshot.data[i]));
                                  }
                                }
                          List<Widget> list = <Widget>[];
                          for(var i = 0; i < snapshot.data.length; i++) {
                            list.add(buildtrade(snapshot.data[i]));
                          }
                          return Column(
                              children: currency == 'Any' ? list : selectedlist);
                        }
                    );
                  }
                },
              ),
            ),
          )

        ],
      ),

    );
  }

  Widget buildtrade(tradesModel object){
    final user = Provider.of<UserFB?>(context);
    return InkWell(
      onTap: (){
        showDialog(context: context,
            builder: (_) =>
                StatefulBuilder(
                    builder: (context, setState) =>
                        AlertDialog(
                            contentPadding: EdgeInsets.all(10),
                            scrollable: true,
                            title: Text(
                              'Enter the required amount',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                            content: Form(
                              key: _formkey,
                              child: Column(
                                children: [
                                 Padding(
                                   padding: const EdgeInsets.all(15.0),
                                   child: Text('You are about to initiate a chat session with the trader.'
                                       'Please indicate the amount you want to top up.'),
                                 ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: TextFormField(
                                    onChanged: (val){
                                      setState(() {
                                        amount = double.parse(val);
                                      });
                                    },
                                    keyboardType: TextInputType.numberWithOptions(decimal: allowDecimal),
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(RegExp(_getRegexString())),
                                      TextInputFormatter.withFunction(
                                            (oldValue, newValue) => newValue.copyWith(
                                          text: newValue.text.replaceAll('.', ','),
                                        ),
                                      ),
                                    ],
                                    validator: (val) => val == '' || int.parse(val!) < 5 ? 'A minimum of \$5 is required' : null,
                                    style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.06),
                                    decoration: textinputdecoration.copyWith(
                                        hintText: ' Amount'),
                                  ),
                                ),
                                  Text('x $rate'),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('You will pay'),
                                      Text(' ${object.currency} ${amount * rate}',
                                        style: TextStyle(fontSize: MediaQuery.of(context).size.width * .05, fontWeight: FontWeight.w500),),
                                    ],
                                  ),
                                  ElevatedButton(
                                    style: ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder( borderRadius: BorderRadius.circular(10.0),)
                                    ),
                                        backgroundColor: MaterialStateColor.resolveWith((states) => Colors.lightGreen)),
                                    onPressed: () async{
                                      print(object.traderUID);
                                      if(_formkey.currentState!.validate() && object.traderUID != user!.uid) {
                                        String chatid = generateorderId();
                                        await DatabaseService(uid: user!.uid).createnewtrade(chatid, object.tradeID, object.traderUID);
                                        Navigator.of(context).push(MaterialPageRoute(
                                                builder: (context) => chatscreen(tradesID: object.traderUID,
                                                      amount: '\$$amount for \$${object.currency} ${amount * rate}.', chatID: chatid,)));
                                      }// Navigator.pop(context);
                                      },
                                    child: const Text("Proceed",
                                      style: TextStyle(fontSize: 16),),
                                  ),
                                ]
                              ),
                            ))));
      },
      child: Card(
        color: Colors.white70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: Colors.black45,
              height: 50,
              width: 2,
              child: Text(''),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('${(object.email).toString().substring(0,1)}*****${(object.email).toString().substring(object.email.length - 11)}',
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),),
                      SizedBox(width: MediaQuery.of(context).size.width*.13,),
                    ],
                  ),
                  Text('${object.currency}: ${object.amount}'),
                  Text(object.numberoftrades == 1 ? '${object.numberoftrades} Order ${object.successrate} completion rate' :
                '${object.numberoftrades} Orders ${object.successrate} completion rate'),
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }
  String generateorderId() {
    var r = Random();
    const _chars = '1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
    return List.generate(20, (index) => _chars[r.nextInt(_chars.length)]).join();
  }
  String _getRegexString() =>
      allowDecimal ? r'[0-9]+[,.]{0,1}[0-9]*' : r'[0-9]';
}
