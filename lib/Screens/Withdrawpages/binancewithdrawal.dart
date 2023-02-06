import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:primebasket/Models/withdrawalModel.dart';
import 'package:primebasket/Screens/Withdrawpages/Withdrawpage.dart';
import '../../Services/Database.dart';
import '../../Widget/bottom_tab.dart';
import '../../Widget/bottomnavtab.dart';
import '../../Widget/decorations.dart';

class binancewithdraw extends StatefulWidget {
  const binancewithdraw({Key? key}) : super(key: key);

  @override
  State<binancewithdraw> createState() => _binancewithdrawState();
}

class _binancewithdrawState extends State<binancewithdraw> {
  late String balance = '0';
  int amount = 0;

  @override
  void initState() {
    getbalance();
    super.initState();
  }
  Future getbalance() async{
    final user = FirebaseAuth.instance.currentUser!;
    List userinfo = await DatabaseService(uid: user!.uid).getuserInfo();
    setState(() {
      balance = userinfo[1];
    });
  }
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    Size size = MediaQuery.of(context).size;
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBar: bottomtabwidget(),
      body: Form(
        key: _formkey,
        child: ListView(
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.all(30.0),
                child: Text('Withdraw',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black),),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(30.0),
                child: Row(
                  children: [
                    Text('Actual balance: ',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black,),),
                    Text(double.parse(balance).toStringAsFixed(2),
                      style: TextStyle(fontWeight: FontWeight.w400,
                          fontSize: 20,
                          color: Colors.black54),),
                  ],
                ),
              ),),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                onChanged: (val){
                  setState(() {
                    amount = int.parse(val);
                  });
                },
                validator: (val) => val!.isEmpty ? 'Enter an Amount to withdraw' : null,
                style: TextStyle(fontSize: 20),
                decoration: textinputdecoration.copyWith(
                    hintText: 'Amount'),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * .2),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  gradient: const LinearGradient(
                      colors: [
                        Color(0xFF29C51F),
                        Color(0x9D60AD43)]),
                ),
                child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent, elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0),),),
                onPressed: () async{
                  if (_formkey.currentState!.validate()) {
                    if (amount > 19.9) {
                    if (double.parse(balance) >= amount +.0) {
                      String time = DateFormat.yMd().format(DateTime.now()).toString();
                      await DatabaseService(uid: user!.uid).withdraw(
                          withdrawModel(account: '',
                              amount: amount,
                              bank: '',
                              country: '',
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
                              }, style: ElevatedButton.styleFrom( backgroundColor: Colors.lightGreen),
                                  child: Text('OK'))
                            ],
                          ),
                        )
                      ));
                    //   Future.delayed(const Duration(seconds: 2), () {
                    //     ScaffoldMessenger.of(context).showSnackBar(snackBarsuccess);
                    //     Navigator.of(context).pushReplacement(MaterialPageRoute(
                    //         builder: (context) => Withdrawalpage()));
                    // });
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);}
                    }
                  else{
                      ScaffoldMessenger.of(context).showSnackBar(snackBar20);}
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
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



