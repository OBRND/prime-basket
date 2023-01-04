import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:primebasket/Widget/animated_text.dart';

import '../Services/Database.dart';

class SharePage extends StatefulWidget {
  @override
  State<SharePage> createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {
  // const SharePage({Key? key}) : super(key: key);
  bool selected = true;

  @override
  void initState() {
    getcount();
    super.initState();
  }
  String Count = '';
  List Checks = [];

  Future getcount() async{
    final user = FirebaseAuth.instance.currentUser!;
    String count = await DatabaseService(uid: user!.uid).getsharecount();
    setState(() {
      Count = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    Count == "1" ? Checks = [true, false, false, false, false, false, false, false, false, false, false] :
    Count == "2" ? Checks = [true, true, false, false, false, false, false, false, false, false, false] :
    Count == "3" ? Checks = [true, true, true, false, false, false, false, false, false, false, false] :
    Count == "4" ? Checks = [true, true, true, true, false, false, false, false, false, false, false] :
    Count == "5" ? Checks = [true, true, true, true, true, false, false, false, false, false, false] :
    Count == "6" ? Checks = [true, true, true, true, true, true, false, false, false, false, false] :
    Count == "7" ? Checks = [true, true, true, true, true, true, true, false, false, false, false] :
    Count == "8" ? Checks = [true, true, true, true, true, true, true, true, false, false, false] :
    Count == "9" ? Checks = [true, true, true, true, true, true, true, true, true, false, false] :
    Count == "10" ? Checks = [true, true, true, true, true, true, true, true, true, true, false] :
    Count == "11" ? Checks = [true, true, true, true, true, true, true, true, true, true, true] :
    Checks = [false, false, false, false, false, false, false, false, false, false, false];
    return Scaffold(
      extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Color(0xff709db7),
          elevation: 0,),
        body: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff709db7),
                      Color(0xff88acc9),
                      Color(0xffc7e0ef),
                      Colors.white70]),
              ),
              // color: Color(0xff709db7),
              height: 110,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(45, 0, 5, 0),
                child: Text('Share prime basket to friends and family', style:
                TextStyle(color: Colors.black87, fontSize: 30, fontWeight: FontWeight.w300),),
              ),
            ),
            // TextButton(
            //   child: Text('Share text and link'),
            //   onPressed: share,
            // ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: size.width*0.02),
            //   child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Image.asset('images/logo.png', width: size.width*0.15,),
            //       Image.asset('images/Logotext.png', width: size.width*0.6,)
            //       ,IconButton(onPressed: (){}, icon: Icon(Icons.doorbell, color:Colors.red,size: size.width*0.1,))
            //     ],
            //   ),
            // ),
            // const BuildAnimatedText(),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Center(child: Text('Share Count: $Count', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 25),)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: size.height*0.02),
              child: SizedBox(
                height: 25,
                child: Wrap(
                  // scrollDirection: Axis.horizontal,
                  children: [
                    buildicon(Checks[0]),
                    buildicon(Checks[1]),
                    buildicon(Checks[2]),
                    buildicon(Checks[3]),
                    buildicon(Checks[4]),
                    buildicon(Checks[5]),
                    buildicon(Checks[6]),
                    buildicon(Checks[7]),
                    buildicon(Checks[8]),
                    buildicon(Checks[9]),
                    buildicon(Checks[10]),
                  ],
                ),
              ),
            ),
            SizedBox(height: 80,),
            Padding(
              padding:EdgeInsets.symmetric(horizontal:size.width*0.02,vertical: size.height*0.01),
              child: ElevatedButton(onPressed: share,
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          // side: BorderSide(color: Colors.black54),
                        )
                    ),
                    backgroundColor: MaterialStateColor.resolveWith((states) => Colors.lightBlueAccent)),

                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: size.height*0.02),
                  child: Text("Share", style: TextStyle(fontSize: size.width*0.055,color: Colors.white),),
                ),
              ),
            ),
            // Center(child: Text("OR", style: TextStyle(fontSize: size.width*0.07,color: Colors.black,fontWeight: FontWeight.bold),)),
            //
            // Padding(
            //   padding:EdgeInsets.symmetric(horizontal:size.width*0.02,vertical: size.height*0.01),
            //   child: MaterialButton(onPressed: share,
            //     shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(10)
            //     ),
            //     color: Colors.purpleAccent.withOpacity(0.7), child: Padding(
            //       padding: EdgeInsets.symmetric(vertical: size.height*0.02),
            //       child: Text("Share as message", style: TextStyle(fontSize: size.width*0.055,color: Colors.white),),
            //     ),
            //   ),
            // )

          ],
        ),
    );
  }
}
Future<void> share() async {
  await FlutterShare.share(
      title: 'Prime basket app',
      text: "Hi, let\'s start earning BIG together. Register to Prime Basket using my code to get a bonus  ' 4y9r3uWdmZgahwguu5cjjl3fodk2 '",
      linkUrl: 'https://play.google.com/store/apps/details?id=com.primebasket.app&pli=1',
      chooserTitle: 'Share prime basket'
  );
}
  Widget buildicon(selected) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: 25,
        width: 25,
        child: Center(child: Icon(selected == false ? Icons.circle_outlined : Icons.check_circle, size: 26,))
      ),
    );

}
