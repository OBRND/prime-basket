import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:primebasket/Screens/home_page.dart';
import 'package:primebasket/Services/transactions.dart';
import 'package:primebasket/Widget/animated_text.dart';
import 'package:primebasket/Widget/app_bar.dart';
import 'package:http/http.dart' as http;
import 'package:primebasket/Widget/bottom_tab.dart';

import '../../Widget/bottomnavtab.dart';


class BinancePage extends StatefulWidget {
  @override
  State<BinancePage> createState() => _BinancePageState();
}

class _BinancePageState extends State<BinancePage> {
  // const BinancePage({Key? key}) : super(key: key);
  late String transactionHash = '';
  late String Error = '';

  @override
  Widget build(BuildContext context) {
    SnackBar snackBarsuccess = SnackBar(
      backgroundColor: Colors.transparent,
      content: Card(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(
              children: [
                Icon(Icons.check, color: Colors.lightGreenAccent,),
                Text('successful!', style: TextStyle(
                    fontSize: 23, fontWeight: FontWeight.w600
                ),),
              ],
            ),
          )),
    );
    final Size size = MediaQuery.of(context).size;
    return SafeArea(child:
    Scaffold(
      bottomNavigationBar: bottomtabwidget(),
      body: ListView(
        children: [
          // const AppBarWidget(),
          // const BuildAnimatedText(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: size.height*0.03),
            child: Center(
              child: Image.asset('images/bsc.png', height: size.width*0.3),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/tether.png', height: size.width*0.1),
              Text(" Tether (USDT)", style: TextStyle(fontWeight: FontWeight.w700,fontSize: size.width*0.06, color: Colors.blueGrey),)
            ],
          ),
          SizedBox(height: 20,),
          Padding(
            padding:EdgeInsets.symmetric(horizontal: size.width*0.03,vertical: size.height*0.01),
            child: Text("1. Only use USDT.", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),),
          ),

          Padding(
            padding:EdgeInsets.symmetric(horizontal: size.width*0.03,vertical: size.height*0.01),
            child: Text("2. Only use BEP20 (Binance Smart Chain).", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),),
          ),

          Padding(
            padding:EdgeInsets.symmetric(horizontal: size.width*0.03,vertical: size.height*0.01),
            child: Text("3. You can send directly via Binance or Metamask.", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),),
          ),

          //Implement QR CODE SCANNER HERE.
          Container(
              width: size.width*.7,
              height: size.width * .7,
              child: Image.asset('images/qr code.png')),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Wrap(
              children: [
                Text('0x43492891eaa2e84147ee7f3ec4d0bf010bbbc5f1', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),),
                Center(
                  child: IconButton(onPressed: _copyText,
                      iconSize: 25,
                      icon: Icon(Icons.copy, color: Colors.lightBlue,)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Wrap(children:[
              Center(child: Icon(Icons.warning_sharp,
              size: 30,
              color: Colors.redAccent,)),
              Text("After completing your transaction, please input your transaction hash in the box.",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),)]),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width*0.02, vertical: size.height*0.03),
            child: TextField(
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: size.width*0.06),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width:1
                    ),
                    borderRadius: BorderRadius.circular(25)
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                hintText:'Transaction Hash', hintStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w400,)
              ),
              onChanged: (val) async{
                var error = await checkTransactionReceiptStatus(val, 3);
                setState((){
                  Error = error;
                  transactionHash = val;
                });
              },
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: Error == '' ? [
            Text('Status: ', style: TextStyle(fontSize: 25),),
            Text('Waiting...', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w300, fontSize: 25),),
          ]: [
            Text('Status: ', style: TextStyle(fontSize: 25),),
            Text(Error == 'Succesfull'? 'OK': Error, style: TextStyle(color: Error == 'Succesfull' ? Colors.green : Colors.redAccent, fontWeight: FontWeight.w300, fontSize: 23),), ]
        ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                gradient: const LinearGradient(
                    colors: [
                      Color(0xfff6ad16),
                      Colors.amberAccent,
                      ]),
              ),
              child: ElevatedButton(
              onPressed: () async{
              String error = await checkTransactionReceiptStatus(transactionHash, 1);
              print(error);
              setState(() {
                Error = error;
              });
              if(Error == 'Succesfull')Future.delayed(const Duration(seconds: 1), () {
                ScaffoldMessenger.of(context).showSnackBar(snackBarsuccess);
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => BottomTab(index: 0)));
              });
            },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                elevation: 0,
              ),
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.circular(25),
              // ),
              // elevation: 30,
              // color: Colors.amber,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("Submit",style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w400),),
              ),),)
          ),
          // Center(child: Text('$Error', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300, color: Colors.red),))
        ],
      ),
    ));
  }

  void _copyText() {
    FlutterClipboard.copy('0x43492891eaa2e84147ee7f3ec4d0bf010bbbc5f1').then((value) {
      _showSnackBar();
    });
  }
  void _showSnackBar() {
    const snack =
    SnackBar(content: Text("Text copied"), duration: Duration(seconds: 2));
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }
}
