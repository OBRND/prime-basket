import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:primebasket/Screens/P2Ppages/tradespage.dart';
import 'package:primebasket/Widget/animated_text.dart';
import 'package:primebasket/Widget/app_bar.dart';

import '../../Widget/bottomnavtab.dart';

class MobileWallet extends StatefulWidget {
  @override
  State<MobileWallet> createState() => _MobileWalletState();
}

class _MobileWalletState extends State<MobileWallet> {
  // const MobileWallet({Key? key}) : super(key: key);
  var selectedcurrency = '';

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(child: Scaffold(
        bottomNavigationBar: bottomtabwidget(),
        body:
        ListView(
          children: [
            // const AppBarWidget(),
            // const BuildAnimatedText(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: size.height*0.03),
              child: Center(
                child: Image.asset('images/mobiwallet.png', height: size.width*0.3),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width*0.05),
              child: GestureDetector(
                onTap: (){
                  showCurrencyPicker(
                    context: context,
                    showFlag: true,
                    showSearchField: true,
                    showCurrencyName: true,
                    showCurrencyCode: true,
                    onSelect: (Currency currency) {
                      setState((){
                        selectedcurrency = currency.name;
                      });
                    },
                    favorite: ['SEK'],
                  );
                },
                child: Container(
                  width: size.width*0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      width: 1,
                      color: Colors.lightBlue
                    )
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: size.width*0.01, top: size.height*0.02,bottom: size.height*0.02),
                    child: Center(
                      child: Text(selectedcurrency == '' ? "Select a currency": '$selectedcurrency',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),
                    ),
                  ),
                ),

              ),
            ),
            SizedBox(height: size.height*0.03,),
            Center(child: Container(
              height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  gradient: const LinearGradient(
                      colors: [
                        Colors.blueAccent,
                        Colors.lightBlue]),
                ),
                child: ElevatedButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => trades(currency: selectedcurrency)));
            },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text("Apply",style: TextStyle(fontSize: 20, color: Colors.white,fontWeight: FontWeight.w400),),
                )))
            ),
            SizedBox(height: size.height*0.02,),

            Center(child: Text("OR", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
            SizedBox(height: size.height*0.02,),

            Center(child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  gradient: const LinearGradient(
                      colors: [
                        Colors.blueAccent,
                        Colors.lightBlue]),
                ),
                child: ElevatedButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => trades(currency: 'Any',)));
            },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                    backgroundColor: Colors.transparent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text("Show All Currencies",style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w400),),
                )))
            )


          ],
        )
    ));
  }
}
