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
    notifications = await DatabaseService(uid: uid).getnotifications();
    for(int i=0; i <= notifications.length; i++ ) {
      // DateTime dt = DateFormat().add_yMd().parse('July 11, 2022');
      // var newDateTimeObj = new DateFormat().add_yMd().add_Hms().parse( 'July 11, 2022');
    //   print(DateFormat('yMd').format(DateTime.now()));
    //
    //   var x = DateFormat.yMMMd().format(DateTime.now());
    //   print('---------------$dt--------------------');

      individualnotif.add( Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              Row(
                children: [
                  Text('${notifications[i].date}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),),
                ],
              ),
              Text('${notifications[i].text}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300, ))
            ]),
      ));
      print(individualnotif.length);
      // individualnotifdate.add(Text('${notifications[i].time}'));
      // individualnotifdate.add(Text('${notifications[i].text}'));
    }

  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    int order = 220;
    final date = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black87, //change your color here
        ),
        backgroundColor: Colors.white70,
        title: Text('Notifications', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 25, color: Colors.black87),),
        elevation: 0,

      ),
      // bottomNavigationBar: const BottomTab(),
      body: SafeArea(
        child: FutureBuilder(
          future: getnotif(context),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            switch(snapshot.connectionState){
              case ConnectionState.waiting: return Center(child: CircularProgressIndicator());
              default: return ListView(
                children: [
                  BuildAnimatedText(),
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

