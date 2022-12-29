import 'package:currency_picker/currency_picker.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:primebasket/Widget/bottom_tab.dart';
import 'package:primebasket/Widget/animated_text.dart';
import 'package:primebasket/Widget/app_bar.dart';

import '../Widget/decorations.dart';

class P2pTadingPage extends StatefulWidget {
  const P2pTadingPage({Key? key}) : super(key: key);

  @override
  State<P2pTadingPage> createState() => _P2pTadingPageState();
}

class _P2pTadingPageState extends State<P2pTadingPage> {

  late String selectedcurrency = '';
  late DropDownValueModel selectedbank;
  var list  = const [
  DropDownValueModel(name: 'ABA', value: "value1"),
  DropDownValueModel(name: 'A-Bank', value: "value2"),
  DropDownValueModel(name: 'Abyssinia', value: "value3"),
  DropDownValueModel(name: 'ACLEDIA', value: "value4"),
  DropDownValueModel(name: 'Advcash', value: "value5"),
  DropDownValueModel(name: 'Airtel Money', value: "value6"),
  DropDownValueModel(name: 'AirTM', value: "value7"),
  DropDownValueModel(name: 'Alinma Bank', value: "value8"),
  DropDownValueModel(name: 'Alipay', value: "value8"),
  DropDownValueModel(name: 'Ameriabank', value: "value8"),
  DropDownValueModel(name: 'ArCA', value: "value8"),
  DropDownValueModel(name: 'ArmEconombank', value: "value8"),
  DropDownValueModel(name: 'Asia United Bank', value: "value8"),
  DropDownValueModel(name: 'BAC Costa Rica', value: "value8"),
  DropDownValueModel(name: 'BAC Credomatic', value: "value8"),
  DropDownValueModel(name: 'Banco Atlas', value: "value8"),
  DropDownValueModel(name: 'Banco Continentia Paraguay', value: "value8"),
  DropDownValueModel(name: 'Banco de Chile', value: "value8"),
  DropDownValueModel(name: 'Banco de Costa Rica', value: "value8"),
  DropDownValueModel(name: 'Banco de Credito', value: "value8"),
  DropDownValueModel(name: 'Banco de Oro (BDO)', value: "value8"),
  DropDownValueModel(name: 'Banco Economico', value: "value8"),
  DropDownValueModel(name: 'Banco Estadio', value: "value8"),
  DropDownValueModel(name: 'Banco Fallabella', value: "value8"),
  DropDownValueModel(name: 'Banco Fasil', value: "value8"),
  DropDownValueModel(name: 'Banco Ganadero', value: "value8"),
  DropDownValueModel(name: 'Banco General Panama', value: "value8"),
  DropDownValueModel(name: 'Banco Itau Paraguay', value: "value8"),
  DropDownValueModel(name: 'Banco Mercantil Santa Cruz', value: "value8"),
  DropDownValueModel(name: 'Banco Nacional de Bolivia', value: "value8"),
  DropDownValueModel(name: 'Banco Union', value: "value8"),
  DropDownValueModel(name: 'Bancolombia S.A', value: "value8"),
  DropDownValueModel(name: 'Banesco Panama', value: "value8"),
  DropDownValueModel(name: 'Banistmo Panama', value: "value8"),
  DropDownValueModel(name: 'Bank of Georgia', value: "value8"),
  DropDownValueModel(name: 'Bank of Georgia', value: "value8"),
  DropDownValueModel(name: 'Bank of the Philippines Islands', value: "value8"),
  DropDownValueModel(name: 'Bank Transfer', value: "value8"),
  DropDownValueModel(name: 'BBVA', value: "value8"),
  DropDownValueModel(name: 'BCA mobile', value: "value8"),
  DropDownValueModel(name: 'BCL', value: "value8"),
  DropDownValueModel(name: 'BCP', value: "value8"),
  DropDownValueModel(name: 'BCU', value: "value8"),
  DropDownValueModel(name: 'BenefitPay', value: "value8"),
  DropDownValueModel(name: 'bKash', value: "value8"),
  DropDownValueModel(name: 'CBE', value: "value8"),
  DropDownValueModel(name: 'CenterCredit Bank', value: "value8"),
  DropDownValueModel(name: 'CIMB Niaga', value: "value8"),
  DropDownValueModel(name: 'Citibanamex', value: "value8"),
  DropDownValueModel(name: 'Coins.ph', value: "value8"),
  DropDownValueModel(name: 'cpay', value: "value8"),
  DropDownValueModel(name: 'Daviplata', value: "value8"),
  DropDownValueModel(name: 'easypaisa-PK Only', value: "value8"),
  DropDownValueModel(name: 'Elcart', value: "value8"),
  DropDownValueModel(name: 'Emirates NBD', value: "value8"),
  DropDownValueModel(name: 'Esewa', value: "value8"),
  DropDownValueModel(name: 'Faster Payment System(FPS)', value: "value8"),
  DropDownValueModel(name: 'FNB-ewallet', value: "value8"),
  ];
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(child: Scaffold(
      // bottomNavigationBar: const BottomTab(),
      body: ListView(
          children: [
            // const AppBarWidget(),
            const BuildAnimatedText(),
            SizedBox(height: size.height*0.03,),

            Center(
              child: Material(
                borderRadius: BorderRadius.circular(5),
                color: const Color(0xff5050d3),
                child: Padding(
                  padding:EdgeInsets.symmetric(horizontal: size.width*0.02, vertical: size.height*0.01),
                  child: Text("P2P REGISTRATION", style: TextStyle(fontSize: size.width*0.055,color: Colors.white),),
                ),
              ),
            ),
            SizedBox(height: size.width*0.02,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width*0.02, vertical: size.height*0.03),
              child: TextField(
                onTap: (){},
                style: TextStyle(fontSize: size.width*0.06),
                decoration: textinputdecoration.copyWith(label: const Text('Wallet Address'),
                  enabledBorder:  const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 3),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
              ),
            ),


            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width*0.02, vertical: size.height*0.03),
              child: TextField(
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
                      print(currency.name);
                    },
                    favorite: ['SEK'],
                  );
                },
                style: TextStyle(fontSize: size.width*0.06),
                decoration: textinputdecoration.copyWith(
                  enabledBorder:  const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 3),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: size.width*0.03, vertical: size.height*0.03),
                  labelText: selectedcurrency == null ? "Select Currency:" : '${selectedcurrency}',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropDownTextField(
                // initialValue: "name4",
                listSpace: 20,
                listPadding: ListPadding(top: 20),
                enableSearch: true,
                validator: (value) {
                  if (value == null) {
                    return "Required field";
                  } else {
                    return null;
                  }
                },
                dropDownList: list,
                listTextStyle: const TextStyle(color: Colors.red),
                dropDownItemCount: 8,

                onChanged: (val) {
                  setState((){
                    selectedbank = val;
                  });
                  print(selectedbank.name);
                },
              ),
            ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width*0.02, vertical: size.height*0.03),
            child: Material(
              elevation: 3,
              child: TextField(
                style: TextStyle(fontSize: size.width*0.06),
                decoration: textinputdecoration.copyWith(label: const Text('Wallet Address'),
                  enabledBorder:  const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 3),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: size.width*0.03, vertical: size.height*0.03),
                  hintText: "Account Number:",
                ),
              ),
            ),
),
            Row(
              children: [
                SizedBox(width: size.width*0.05,),
                Icon(Icons.add_alert_outlined,color: const Color(0xff191970),size: size.width*0.07,),
                Text("Add", style: TextStyle(fontWeight: FontWeight.bold,fontSize: size.width*0.06,color: const Color(0xff191970)),)
              ],
            ),
            SizedBox(height:size.height*0.03),
            Text("Do You have binacne or metamask wallet?", style: TextStyle(fontSize: size.width*0.05, fontWeight: FontWeight.w700),),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width*0.35),
              child: MaterialButton(onPressed: (){},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              elevation: 30,
                  color: Colors.amber,
              child: Text("Submit",style: TextStyle(fontSize: size.width*0.06, color: Colors.white),),),
            )

          ]),
    ));
  }
}
