import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:primebasket/Widget/animated_text.dart';
import 'package:primebasket/Widget/app_bar.dart';

class MobileWallet extends StatelessWidget {
  const MobileWallet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(child: Scaffold(
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
                    },
                    favorite: ['SEK'],
                  );
                },
                child: Container(
                  width: size.width*0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width:2,
                    )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: size.width*0.01, top: size.height*0.02,bottom: size.height*0.02),
                        child: Text("Currency", style: TextStyle(fontSize: size.width*0.06, fontWeight: FontWeight.w700),),
                      ),
                      Padding(

                        padding: EdgeInsets.only(left: size.width*0.03), child: Icon(Icons.arrow_downward,size: size.width*0.08,),
                      )
                    ],
                  ),
                ),

              ),
            ),
            SizedBox(height: size.height*0.03,),
            Center(child: ElevatedButton(onPressed: (){},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                ),
                child: Text("Apply",style: TextStyle(fontSize: size.width*0.06, color: Colors.white,),))),
            SizedBox(height: size.height*0.02,),

            Center(child: Text("OR", style: TextStyle(fontSize: size.width*0.06, fontWeight: FontWeight.bold),)),
            SizedBox(height: size.height*0.02,),

            Center(child: ElevatedButton(onPressed: (){},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                ),
                child: Text("Show All Currencies",style: TextStyle(fontSize: size.width*0.06, color: Colors.white,),)))


          ],
        )
    ));
  }
}
