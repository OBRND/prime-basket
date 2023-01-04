import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:primebasket/Screens/notification_page.dart';

class AppBarWidget extends StatelessWidget {
  // const AppBarWidget({Key? key}) : super(key: key);
  final user;

 AppBarWidget({required this.user});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width*0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Padding(
          //   padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          //   child: Image.asset('images/logo.png', width: size.width*0.16),
          // ),
          InkWell(
            onTap: (){

            },
            child: Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 6, right: 3),
              child: CircleAvatar(
                radius: 21,
                backgroundImage: user.photoURL == null ? null : NetworkImage(user.photoURL!),
              ),
            ),
          ),
          // SizedBox(width: size.width*.1,),
          Text('Prime Basket',
              style: GoogleFonts.courgette(
                textStyle: TextStyle(color: Color(0xff353536), fontSize: 28, fontWeight: FontWeight.w700 ),)),

         IconButton(onPressed: (){
           Navigator.of(context).push(MaterialPageRoute(
                   builder: (context) => NotifPage()));
         },
          icon: Icon(Icons.notifications_active, color: Color(0xff3f3f41),),
          iconSize: 28,)

          // Image.asset('images/Logotext.png', width: size.width*0.6,),
          // GestureDetector(onTap: (){Navigator.pushNamed(context, '/notif');}, child: Image.asset('images/bell.png',
          //   color: Colors.red,height: size.height*0.08,))
        ],
      ),
    );
  }
}
