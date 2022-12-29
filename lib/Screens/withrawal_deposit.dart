import 'package:flutter/material.dart';
import 'package:primebasket/Widget/bottom_tab.dart';
import 'package:primebasket/Widget/animated_text.dart';
import 'package:primebasket/Widget/app_bar.dart';


class WithdrawalPage extends StatelessWidget {
  const WithdrawalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      // bottomNavigationBar: const BottomTab(),
      body: ListView(
        children: [
          // const AppBarWidget(),
          const BuildAnimatedText(),
          Center(
            child: Text("Withdrawal/Deposit History", style: TextStyle(fontWeight: FontWeight.bold,fontSize: size.width*0.07, color: Colors.black),),
          )


        ],
      ),
    );
  }
}
