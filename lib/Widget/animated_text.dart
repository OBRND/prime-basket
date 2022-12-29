
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class BuildAnimatedText extends StatelessWidget {
  const BuildAnimatedText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String text = "f****o@gmail.com has deposited \$233";
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.04 ,
      child: Material(
        color: Colors.white,
        child: Marquee(
          text: text,
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700,fontSize: MediaQuery.of(context).size.width*0.04),
          blankSpace: 30,
        ),
      ),
    );
  }
}

