import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';

import '../Services/Database.dart';
import '../Services/User.dart';

class BuildAnimatedText extends StatefulWidget {
  @override
  State<BuildAnimatedText> createState() => _BuildAnimatedTextState();
}

class _BuildAnimatedTextState extends State<BuildAnimatedText> {
  // const BuildAnimatedText({Key? key}) : super(key: key);
  String text = 'f****o@gmail.com has deposited \$233';
  late String textupdated = '';
  Future getproducts() async{
    final user = Provider.of<UserFB?>(context);
    final uid = user!.uid;
   final text =  await DatabaseService(uid: uid).getwithdrawalstext();
   setState(() {
     textupdated = text;
   });
  }
  @override
  void initState() {
    getproducts();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    getproducts();
    // String text = "f****o@gmail.com has deposited \$233";
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.04 ,
      child: Material(
        color: Color(0xf0cccbcb),
        child: Marquee(
          text: textupdated.isEmpty ? text: textupdated,
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w400,fontSize: MediaQuery.of(context).size.width*0.04),
          blankSpace: 30,
        ),
      ),
    );
  }
}

