import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Widget/decorations.dart';

class binancewithdraw extends StatefulWidget {
  const binancewithdraw({Key? key}) : super(key: key);

  @override
  State<binancewithdraw> createState() => _binancewithdrawState();
}

class _binancewithdrawState extends State<binancewithdraw> {
double balance = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.all(30.0),
              child: Text('Withdraw',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: Colors.black54),),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.all(30.0),
              child: Row(
                children: [
                  Text('Actual balance:',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: Colors.black54),),
                Text('\$$balance',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: Colors.black54),),
                ],
              ),
            ),),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              style: TextStyle(fontSize: size.width*0.06),
              decoration: textinputdecoration.copyWith(hintText: 'Amount to withdraw'),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
            child: MaterialButton(onPressed: (){},
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),),
              elevation: 30, color: Colors.lightGreen,
              child: Text("Submit",style: TextStyle(fontSize: size.width*0.065, color: Colors.white),),),
          )
        ],
      ),
    );
  }

Future sendEmail() async{

  // final url = Uri.parse("https://api-testnet.bscscan.com/api ?module=transaction&action=gettxreceiptstatus &txhash=0x6921f3a1af6a44ee48eb662a6e7e152b2dc704ff4ee4b3c36bf2a7ee9ab476cc &apikey=YourApiKeyToken");
  final url = Uri.parse("https://api.bscscan.com/api ?module=account &action=balance &address=0x70F657164e5b75689b64B7fd1fA275F334f28e18 &apikey=5ISK5SWNXSBBVEBSZABGZ4W66RMNFK7UKS");

  final response = await http.get(url,
    // headers: {
    //   'module' : 'transaction',
    //   'action' : 'txlist&address',
    //   'txhash': '0x6921f3a1af6a44ee48eb662a6e7e152b2dc704ff4ee4b3c36bf2a7ee9ab476cc',
    //   'api-key' : '5ISK5SWNXSBBVEBSZABGZ4W66RMNFK7UKS'
    // },
  );

  print(response.body);

}

}
