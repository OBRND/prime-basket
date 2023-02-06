import 'package:country_picker/country_picker.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:primebasket/Widget/bottom_tab.dart';

import '../../Models/withdrawalModel.dart';
import '../../Services/Database.dart';
import '../../Widget/bottomnavtab.dart';
import '../../Widget/decorations.dart';
import 'Withdrawpage.dart';

class mobiwalletwithdraw extends StatefulWidget {
  const mobiwalletwithdraw({Key? key}) : super(key: key);

  @override
  State<mobiwalletwithdraw> createState() => _mobiwalletwithdrawState();
}

class _mobiwalletwithdrawState extends State<mobiwalletwithdraw> {
  final _formkey = GlobalKey<FormState>();
  DropDownValueModel selectedbank = DropDownValueModel(name: '', value: 0);
  int amount = 0;
  int accountnumber = 0;

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
    DropDownValueModel(name: 'ForteBank', value: "value8"),
    DropDownValueModel(name: 'FPS', value: "value8"),
    DropDownValueModel(name: 'Garanti', value: "value8"),
    DropDownValueModel(name: 'Golomt Bank', value: "value8"),
    DropDownValueModel(name: 'Google Pay (GPay)', value: "value8"),
    DropDownValueModel(name: 'Humo', value: "value8"),
    DropDownValueModel(name: 'Idram', value: "value8"),
    DropDownValueModel(name: 'IMPS', value: "value8"),
    DropDownValueModel(name: 'Inecobank', value: "value8"),
    DropDownValueModel(name: 'ING', value: "value8"),
    DropDownValueModel(name: 'International Wire (SWIFT)', value: "value8"),
    DropDownValueModel(name: 'Jazzcash', value: "value8"),
    DropDownValueModel(name: 'Kaspi Bank', value: "value8"),
    DropDownValueModel(name: 'Khalti', value: "value8"),
    DropDownValueModel(name: 'Khan Bank', value: "value8"),
    DropDownValueModel(name: 'Kuveyt Turk', value: "value8"),
    DropDownValueModel(name: 'LA Banque postale', value: "value8"),
    DropDownValueModel(name: 'Landbank of philippines', value: "value8"),
    DropDownValueModel(name: 'LendMN', value: "value8"),
    DropDownValueModel(name: 'LINE pay', value: "value8"),
    DropDownValueModel(name: 'Maybank', value: "value8"),
    DropDownValueModel(name: 'mBank', value: "value8"),
    DropDownValueModel(name: 'Marcadopago', value: "value8"),
    DropDownValueModel(name: 'Metropolitan Bank of Philipines', value: "value8"),
    DropDownValueModel(name: 'Mobile top-up', value: "value8"),
    DropDownValueModel(name: 'MoMo', value: "value8"),
    DropDownValueModel(name: 'Mongol Chat', value: "value8"),
    DropDownValueModel(name: 'M-pesa(Vodafone)', value: "value8"),
    DropDownValueModel(name: 'M-PESA Kenya', value: "value8"),
    DropDownValueModel(name: 'MTN Mobile Money', value: "value8"),
    DropDownValueModel(name: 'N26', value: "value8"),
    DropDownValueModel(name: 'Nagad', value: "value8"),
    DropDownValueModel(name: 'National Bank of Egypt(NBE)', value: "value8"),
    DropDownValueModel(name: 'Nequi', value: "value8"),
    DropDownValueModel(name: 'Optima Bank', value: "value8"),
    DropDownValueModel(name: 'Orange Money - OM', value: "value8"),
    DropDownValueModel(name: 'OSKO', value: "value8"),
    DropDownValueModel(name: 'Pago Movil', value: "value8"),
    DropDownValueModel(name: 'Payeer', value: "value8"),
    DropDownValueModel(name: 'Paymaya', value: "value8"),
    DropDownValueModel(name: 'PayMe', value: "value8"),
    DropDownValueModel(name: 'PayPal', value: "value8"),
    DropDownValueModel(name: 'Paysera', value: "value8"),
    DropDownValueModel(name: 'Philippines National Bank (PNB)', value: "value8"),
    DropDownValueModel(name: 'Pix', value: "value8"),
    DropDownValueModel(name: 'Plin', value: "value8"),
    DropDownValueModel(name: 'Post Bank', value: "value8"),
    DropDownValueModel(name: 'Postepay', value: "value8"),
    DropDownValueModel(name: 'Prex', value: "value8"),
    DropDownValueModel(name: 'Provincial', value: "value8"),
    DropDownValueModel(name: 'Qatar National Bank', value: "value8"),
    DropDownValueModel(name: 'QNB', value: "value8"),
    DropDownValueModel(name: 'Reba', value: "value8"),
    DropDownValueModel(name: 'Revolut', value: "value8"),
    DropDownValueModel(name: 'Rizal Commercial Banking Corporation', value: "value8"),
    DropDownValueModel(name: 'RUB fiat balance', value: "value8"),
    DropDownValueModel(name: 'Saudi National Bank', value: "value8"),
    DropDownValueModel(name: 'Sepa Instant', value: "value8"),
    DropDownValueModel(name: 'ShopeePay-SEA', value: "value8"),
    DropDownValueModel(name: 'Skrill (Moneybookers)', value: "value8"),
    DropDownValueModel(name: 'Social Pay', value: "value8"),
    DropDownValueModel(name: 'TBC', value: "value8"),
    DropDownValueModel(name: 'TBC Bank', value: "value8"),
    DropDownValueModel(name: 'TD Bank', value: "value8"),
    DropDownValueModel(name: 'Tele Birr', value: "value8"),
    DropDownValueModel(name: 'Tigo Fesa', value: "value8"),
    DropDownValueModel(name: 'Tinkoff', value: "value8"),
    DropDownValueModel(name: 'Uala', value: "value8"),
    DropDownValueModel(name: 'Unibank', value: "value8"),
    DropDownValueModel(name: 'UnionBank of the Philippines', value: "value8"),
    DropDownValueModel(name: 'UPI', value: "value8"),
    DropDownValueModel(name: 'Vision Banco', value: "value8"),
    DropDownValueModel(name: 'Vodafone cash', value: "value8"),
    DropDownValueModel(name: 'WeChat', value: "value8"),
    DropDownValueModel(name: 'Western Union', value: "value8"),
    DropDownValueModel(name: 'Wise', value: "value8"),
    DropDownValueModel(name: 'Yape', value: "value8"),
    DropDownValueModel(name: 'Zaincash', value: "value8"),
    DropDownValueModel(name: 'Zelle', value: "value8"),
    DropDownValueModel(name: 'ZEN', value: "value8"),
    DropDownValueModel(name: 'Ziraat', value: "value8"),
  ];
 late String balance = '0';
  String Countrytext = 'Select country';

  @override
  void initState() {
    getbalance();
    super.initState();
  }
  Future getbalance() async{
    final user = FirebaseAuth.instance.currentUser!;
    List userinfo = await DatabaseService(uid: user!.uid).getuserInfo();
    setState(() {
      balance = userinfo[1].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    Size size = MediaQuery.of(context).size;
    SnackBar snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      content: Card(
          color: Colors.redAccent,
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(
              children: [
                Icon(Icons.dangerous_rounded),
                Text(' You have insufficient funds!', style: TextStyle(
                    fontSize: size.width*.055, fontWeight: FontWeight.w600
                ),),
              ],
            ),
          )),
    );
    SnackBar snackBarsuccess = SnackBar(
      backgroundColor: Colors.transparent,
      content: Card(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(
              children: [
                Icon(Icons.check, color: Colors.lightGreenAccent,),
                Text('Withdrawal successful!', style: TextStyle(
                    fontSize: size.width*.055, fontWeight: FontWeight.w600
                ),),
              ],
            ),
          )),
    );
    SnackBar snackBar20 = SnackBar(
      backgroundColor: Colors.transparent,
      content: Card(
          color: Colors.redAccent,
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(
              children: [
                Icon(Icons.dangerous_rounded),
                Text('The minimum withdrawal limit is \$20!', style: TextStyle(
                    fontSize: size.width*.045, fontWeight: FontWeight.w600
                ),),
              ],
            ),
          )),
    );

    return Scaffold(
      bottomNavigationBar: bottomtabwidget(),

      body: Form(
        key: _formkey,
        child: ListView(
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.all(28.0),
                child: Text('Enter your bank details',
                  style: TextStyle(fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.black),),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 20, left: 30),
                child: Row(
                  children: [
                    Text('Actual balance: ',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),),
                    Text('\$${double.parse(balance).toStringAsFixed(2)}',
                      style: TextStyle(fontWeight: FontWeight.w400,
                          fontSize: 20,
                          color: Colors.black54),),
                  ],
                ),
              ),),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                onTap: (){
                    showCountryPicker(
                      context: context,
                      showPhoneCode: true,
                      // optional. Shows phone code before the country name.
                      onSelect: (Country country) {
                        setState(() {
                          Countrytext = country.name;
                        });
                        // print('Select country: ${country.name}');
                      },
                    );
                },
                validator: (val) => Countrytext == 'Select country' ? 'Please select a country' : null,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                decoration: textinputdecoration.copyWith(
                    hintText: '$Countrytext',),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropDownTextField(
                textFieldDecoration: textinputdecoration.copyWith(
                    hintText: 'Select a bank', hintStyle: TextStyle(fontWeight: FontWeight.w300, fontSize: 20)),
                // initialValue: "name4",
                listSpace: 20,
                listPadding: ListPadding(top: 20),
                enableSearch: true,
                validator: (value) {
                  if (selectedbank.name == '') {
                    return "Required field";
                  } else {
                    return null;
                  }
                },
                dropDownList: list,
                listTextStyle: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w400, fontSize: 15),
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
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                onChanged: (val){
                  setState(() {
                    accountnumber = int.parse(val);
                  });
                },
                validator: (val) => val!.length < 8 ? ' Enter a valid Account number' : null,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                decoration: textinputdecoration.copyWith(
                    hintText: 'Account number'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                onChanged: (val){
                  setState(() {
                    amount = int.parse(val);
                  });
                  },
                validator: (val) => val!.isEmpty ? 'Enter an Amount to withdraw' : null,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                decoration: textinputdecoration.copyWith(
                    hintText: 'Amount'),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.2),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  gradient: const LinearGradient(
                      colors: [
                        Color(0xFF29C51F),
                        Color(0x9D60AD43)]),
                ),
                child: ElevatedButton(onPressed: () async{
                String time = DateFormat.yMd().format(DateTime.now()).toString();
                if(_formkey.currentState!.validate()) {
                    if (amount > 19.9) {
                      if (double.parse(balance) >= amount) {
                        await DatabaseService(uid: user!.uid).withdraw(
                            withdrawModel(
                                account: '$accountnumber',
                                amount: amount,
                                bank: '${selectedbank.name}',
                                country: '$Countrytext',
                                email: user.email!,
                                status: 'processing',
                                time: time));
                        showDialog(context: context,
                            builder: (_) => AlertDialog(
                                contentPadding: EdgeInsets.all(10),
                                scrollable: true,
                                content: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Text('Withdrawal successfull! Check your balance in the accounts page.'),
                                      ElevatedButton(onPressed: (){
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                                            builder: (context) => BottomTab(index: 0)));
                                      },
                                          style: ElevatedButton.styleFrom( backgroundColor: Colors.lightGreen),
                                          child: Text('OK'))
                                    ],
                                  ),
                                )
                            ));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(snackBar20);
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: Text("Submit", style: TextStyle(
                      fontSize: 20, color: Colors.white, fontWeight: FontWeight.w400),),
                ),),)
            )
          ],
        ),
      ),
    );
  }
}
