import 'package:flutter/material.dart';

import '../Widget/bottomnavtab.dart';

class Tierpage extends StatelessWidget {
  const Tierpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: .5,
        backgroundColor: Colors.transparent,
        title: Center(child: Text('Tier system', style: TextStyle(fontSize: 25, color: Colors.black54, fontWeight: FontWeight.w400),)),
      ),
      bottomNavigationBar: bottomtabwidget(),
      body: Padding(

        padding: const EdgeInsets.only(top: 20),
        child: Image.asset('images/tier.png'),
      ),
    );
  }
}
