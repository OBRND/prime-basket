import 'package:currency_picker/currency_picker.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:primebasket/Screens/P2Ppages/P2Pagentform.dart';
import 'package:primebasket/Widget/bottom_tab.dart';
import 'package:primebasket/Widget/animated_text.dart';
import 'package:primebasket/Widget/app_bar.dart';
import 'package:provider/provider.dart';

import '../../Services/Database.dart';
import '../../Services/User.dart';
import '../../Widget/bottomnavtab.dart';
import '../../Widget/decorations.dart';
import 'tradespage.dart';

class P2pTadingPage extends StatefulWidget {
  // const P2pTadingPage({Key? key}) : super(key: key);

  @override
  State<P2pTadingPage> createState() => _P2pTadingPageState();
}

class _P2pTadingPageState extends State<P2pTadingPage> {

  late String selectedcurrency = '';
  late DropDownValueModel selectedbank = DropDownValueModel(name: '', value: 'value0');
  var list  = const [
    DropDownValueModel(name: ' ', value: "value0"),
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

  final bool allowDecimal = false;
  late bool isinitiated = false;

  Future checkp2p() async{
    final user = FirebaseAuth.instance.currentUser!;
    bool isinit = await DatabaseService(uid: user.uid).checkp2p();
    setState(() {
      isinitiated = isinit;
    });
  }
  final List<TextEditingController> myController = List.generate(2, (i) => TextEditingController());
  Map alldata = {};
  List datalist = [];
  final _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    checkp2p();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: bottomtabwidget(),
      body: Form(
        key: _formkey,
        child: ListView(
            children: [
              // const AppBarWidget(),
              // const BuildAnimatedText(),
              SizedBox(height: size.height*0.03,),

              Center(
                child: Material(
                  borderRadius: BorderRadius.circular(25),
                  color: const Color(0xff5050d3),
                  child: Padding(
                    padding:EdgeInsets.all(10),
                    child: Text(" P2P REGISTRATION ", style: TextStyle(fontSize: 21,color: Colors.white, fontWeight: FontWeight.w800),),
                  ),
                ),
              ),
              SizedBox(height: size.width*0.1,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (val) => myController[0].text == '' && myController[0].text.length < 8 ? ' Please enter a valid wallet address' : null,
                  style: TextStyle(fontSize: size.width*0.06),
                  decoration: textinputdecoration.copyWith(label: const Text('Wallet Address',
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),),
                  ),
                  controller: myController[0],
                ),
              ),


              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (val) => selectedcurrency == '' ? ' Please select a valid currency' : null,
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
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
                  decoration: textinputdecoration.copyWith(
                    contentPadding: EdgeInsets.symmetric(horizontal: size.width*0.03, vertical: size.height*0.02),
                    labelText: selectedcurrency == '' ? "Select Currency:" : '${selectedcurrency}',
                    suffixIcon: Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.grey,
                      ), // icon is 48px widget.
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropDownTextField(
                  textFieldDecoration: textinputdecoration.copyWith(
                      hintText: 'Select Bank/Wallet', hintStyle: TextStyle(fontWeight: FontWeight.w300, fontSize: 20)),
                  // initialValue: "name4",
                  listSpace: 20,
                  listPadding: ListPadding(top: 20),
                  enableSearch: true,
                  validator: (value) {
                    if (selectedbank.name == '') {
                      return "Please select a valid bank from the list";
                    } else {
                      return null;
                    }
                  },
                  dropDownList: list,
                  listTextStyle: const TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
                  dropDownItemCount: 8,
                  onChanged: (val) {
                    setState((){
                      datalist = [1];
                      selectedbank = val;
                    });
                    print(selectedbank.name);
                  },
                ),
              ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              validator: (val) => myController[1].text == '' || myController[1].text.length < 8 ? ' Please enter a valid account number' : null,
              style: TextStyle(fontSize: size.width*0.06),
              keyboardType: TextInputType.numberWithOptions(decimal: allowDecimal),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(_getRegexString())),
                TextInputFormatter.withFunction(
                      (oldValue, newValue) => newValue.copyWith(
                    text: newValue.text.replaceAll('.', ','),
                  ),
                ),
              ],
              decoration: textinputdecoration.copyWith(label: const Text('Account number', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),),
                contentPadding: EdgeInsets.symmetric(horizontal: size.width*0.03, vertical: size.height*0.02),
                hintText: "Account Number:",
                hintStyle: TextStyle(fontWeight: FontWeight.w300, fontSize: 20)
              ),
              controller: myController[1],
            ),
          ),
              Row(
                children: [
                  SizedBox(width: 15,),
                Container (
                    decoration: BoxDecoration(
                      border: Border.all(width: 3, color:Color(0xff191970)),
                    ),
                    child: TextButton(
                onPressed: (){
                    Map l = {
                      'accountNumber': myController[1].text,
                      'bankOrWallet': selectedbank.name,
                      'country': selectedcurrency,
                      'walletAddress': myController[0].text,
                    };
                    alldata.putIfAbsent('${alldata.length}', () => l);
                    print('jjjjjjjjjjj$alldata');
                    setState(() {
                      selectedbank = DropDownValueModel(name: ' '
                          '', value: 'value0');
                      selectedcurrency = '';
                      myController[0].text = '';
                      myController[1].text = '';
                    });
                },
                child: Container (
                  width: 80,
                  height: 25,
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(25.0),
                    color: Colors.transparent,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(width: size.width*0.05,),
                    Icon(Icons.add,color: const Color(0xff191970),size: 28,),
                    Text("Add", style: TextStyle(fontWeight: FontWeight.w500,
                        fontSize: 23, color: const Color(0xff191970)),)
                  ],
                ),)
              )),
              SizedBox(width: MediaQuery.of(context).size.width*.7,)
              ],),
              SizedBox(height:size.height*0.01),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(child: Text("Do You have a Binance or Metamask wallet?",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),)),
              ),

              isinitiated ? Column(
                children: [
                  Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          gradient: const LinearGradient(
                              colors: [
                                Colors.blueAccent,
                                Colors.lightBlue]),
                        ),
                        child: ElevatedButton(
                          onPressed: (){
                      final user = Provider.of<UserFB?>(context, listen: false);
                      if(_formkey.currentState!.validate()) {
                        // for (int i = 0; i < datalist.length; i++) {
                          Map l = {
                            'accountNumber': myController[0].text,
                            'bankOrWallet': selectedbank.name,
                            'country': selectedcurrency,
                            'walletAddress': myController[1].text,
                          };
                          alldata.putIfAbsent('${alldata.length + 1}', () => l);
                        // }
                        DatabaseService(uid: user!.uid).addnewagent(alldata);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => P2PAgentPage()));
                      }
                    },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(11),
                        child: Text("Submit",style: TextStyle(fontSize: 20, color: Colors.white),),))),
                  SizedBox(height: 10,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      gradient: const LinearGradient(
                          colors: [
                            Color(0xfff6ad16),
                            Colors.amberAccent,
                          ]),
                    ),
                    child: ElevatedButton(onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => P2PAgentPage()));
                  },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(11),
                        child: Text("Start/Resume trade",style: TextStyle(fontSize: 20, color: Colors.white),)),),
                  ),],
              ):

              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width*0.2,),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    gradient: const LinearGradient(
                        colors: [
                          Colors.blueAccent,
                          Colors.lightBlue]),
                  ),
                  child: ElevatedButton(
                  onPressed: (){
                  if(_formkey.currentState!.validate()) {
                    final user = Provider.of<UserFB?>(context, listen: false);
                    for(int i = 0; i < datalist.length; i++){
                      Map l = {
                        'accountNumber': myController[0].text,
                        'bankOrWallet': selectedbank.name,
                        'country': selectedcurrency,
                        'walletAddress': myController[1].text,
                      };
                      alldata.putIfAbsent('$i', () => l);
                    }
                    DatabaseService(uid: user!.uid).addnewagent(alldata);

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => P2PAgentPage()));
                  }
                },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                  ),
                child: Padding(
                    padding: EdgeInsets.all(11),
                    child: Text("Submit",
                  style: TextStyle(fontSize: 20, color: Colors.white),)),),)
              )

            ]),
      ),
    );
  }
  String _getRegexString() =>
      allowDecimal ? r'[0-9]+[,.]{0,1}[0-9]*' : r'[0-9]';
}
