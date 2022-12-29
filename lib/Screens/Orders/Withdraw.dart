import 'package:flutter/material.dart';

class Withdrawal extends StatelessWidget {
  const Withdrawal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size ;
    return Scaffold(
      body: ListView(
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.all(30.0),
              child: Text('Withdraw Your funds',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: Colors.black54),),
            ),
          ),
          Padding(
            padding:EdgeInsets.symmetric(horizontal: size.width*0.1, vertical: size.height*0.04),
            child: GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, '/binancewithdraw');
              },
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(15),
                child: Image.asset('images/bsc.png', height: size.width*0.3,),
              ),
            ),
          ),

          Padding(
            padding:EdgeInsets.symmetric(horizontal: size.width*0.1, vertical: size.height*0.03),
            child: GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, '/mobiwalletwithdraw');
              },
              child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset('images/mobiwallet.png')
              ),
            ),
          )

        ],

      ),


    );
  }
}
