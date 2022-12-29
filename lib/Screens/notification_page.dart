import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:primebasket/Widget/bottom_tab.dart';
import 'package:primebasket/Widget/animated_text.dart';
import 'package:primebasket/Widget/app_bar.dart';
import 'package:provider/provider.dart';

import '../Services/Database.dart';
import '../Services/User.dart';

class NotifPage extends StatelessWidget {
  // const NotifPage({Key? key}) : super(key: key);

  List notifications = [ ];
  List<Widget> individualnotif  = <Widget> [];
  // List<Widget> individualnotiftext = <Widget> [];
  // List<Widget> individualnotiftime = <Widget> [];
  Future getnotif(context) async{
    final user = Provider.of<UserFB?>(context);
    final uid = user!.uid;
    // notifications = await DatabaseService(uid: uid).getnotifications();
    for(int i=0; i<=notifications.length; i++ ) {
    //   // DateTime dt = DateTime.parse(notifications[i].date);
    //   var newDateTimeObj = new DateFormat().add_yMd().add_Hms().parse( notifications[i].date)
    //   print(DateFormat('yMd').format(DateTime.now()));
    //
    //   var x = DateFormat.yMMMd().format(DateTime.now());
      // print(DateFormat.yMd().format(dt));

      individualnotif.add( Column(
          children:[
            Row(
              children: [
                Text('${notifications[i].date}'),
                Text('${notifications[i].time}'),
              ],
            ),
            Text('${notifications[i].text}')
          ]));
      // individualnotifdate.add(Text('${notifications[i].time}'));
      // individualnotifdate.add(Text('${notifications[i].text}'));
    }

  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    int order =220;
    final date = DateTime.now();
    return Scaffold(
      // bottomNavigationBar: const BottomTab(),
      body: SafeArea(
        child: FutureBuilder(
          future: getnotif(context),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            switch(snapshot.connectionState){
              case ConnectionState.waiting: return CircularProgressIndicator();
              default: return ListView(
                children: [
                  const BuildAnimatedText(),
                  Column(
                    children: individualnotif,
                  )
                    ],
          );
          }
          }
        ),
      ),
    );
  }
}
  // Widget buildnotif(BuildContext context) {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(horizontal: size.width*0.03, vertical: size.height*0.02),
  //     child: Material(
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(" ", style: TextStyle(fontSize: size.width*0.05, fontWeight: FontWeight.bold),),
  //           // Text("$date", style: TextStyle(fontSize: size.width*0.04,fontWeight: FontWeight.bold, color: Colors.blueGrey),)
  //         ],
  //       ),
  //     ),
  //   );
  // }

