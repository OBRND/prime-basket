import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:primebasket/Services/Database.dart';

// Make a request to the BscScan API to retrieve the receipt status of a transaction


Future checkTransactionReceiptStatus(String transactionHash, int screen) async {
  final user = FirebaseAuth.instance.currentUser!;

  // late String _transactionHash = '';
  // late var _transactionAmount = '';

  String apiKey = "5ISK5SWNXSBBVEBSZABGZ4W66RMNFK7UKS";


  final response = await http.get(
    Uri.parse("https://api.bscscan.com/api?module=account&action=tokentx&contractaddress&address=0x43492891eaa2e84147ee7f3ec4d0bf010bbbc5f1&page&offset=5&startblock=0&endblock=999999999&sort=asc&apikey=$apiKey"),
  );

  var data = json.decode(response.body);
  if (response.statusCode == 200) {

    final data = json.decode(response.body); // Check the "success" field in the response to determine the receipt status of the transaction
    print(data);

    // Extract the transaction amount from the JSON object
    print('${data["result"][0]['hash']}');
    // print('${data["result"][1]["hash"]}');
    // print(data["result"][2]["hash"]);
    // print(data["result"][3]["hash"]);
    // print(data["result"][4]["hash"]);
    // print(data["result"][5]["hash"]);
    List Txlist = await DatabaseService(uid: user.uid).gettransactionHash();
    for(int i = 0; i < (data["result"]).length; i++){
      print('----------------${data["result"][i]['hash']}-------------------');
      if(data["result"][i]['hash'] == transactionHash){
        print('----------------$transactionHash-------------------');
        if(Txlist.contains(transactionHash)) {
          return 'Failed';
        }
        else if(data["result"][i]['to'] == '0x43492891eaa2e84147ee7f3ec4d0bf010bbbc5f1' && data["result"][i]['tokenName'] == "Binance-Peg BSC-USD"){
          var transactionAmount = (double.parse(data["result"][i]["value"]) /
              1000000000000000000); // for converting the WEI to BNB
          print('----------$transactionAmount--------');

          // var _transactionHash = transactionHash;
          // String Usdconverted = await _convertTransactionAmountToUSD(transactionAmount);
          print('++++++++++++$transactionAmount+++++++++++++++++');
          print(Txlist);
          List txn = [transactionAmount.toString(),
          'OK', transactionHash];
          if(screen == 1){
            await DatabaseService(uid: user.uid).topuptxn(txn);
            return 'Succesfull';
          }
          if(screen == 2){
            return ['Succesfull',transactionAmount.toString()];
          }
          if(screen == 3){
            return 'Succesfull';
          }
        }
        else {
          return 'failed';
        }
      }
      else {
        if((data["result"]).length-1 == i){
        return 'failed';}
      }
    }

  } else { // Throw an exception if the request failed
    throw Exception('Failed to retrieve transaction receipt status');
  }
}

Future<String> _convertTransactionAmountToUSD(var _transactionAmount) async {

  final response = await http.get(
    Uri.parse("https://api.coingecko.com/api/v3/simple/price?ids=usd&vs_currencies=bnb"),
  );
  final data = json.decode(response.body); // Check the "success" field in the response to determine the receipt status of the transaction
  print(data);
  var txnrate = await data["usd"]["bnb"];
  print(txnrate);

  return (_transactionAmount / txnrate).toString();
  }

// class _MyHomePageState extends State<MyHomePage> {
//
//
//   void _verifyTransaction() async {
//     // Replace YOUR_API_KEY with your actual API key from BSC Scan
//     String apiKey = "YOUR_API_KEY";
//
//     // Replace TRANSACTION_HASH with the actual transaction hash you want to verify
//     String transactionHash = "TRANSACTION_HASH";
//
//     // Make a GET request to the BSC Scan API to retrieve the transaction details
//     var response = await http.get(
//       "https://bscscan.com/api?module=transaction&action=gettxinfo&txhash=$transactionHash&apikey=$apiKey",
//     );
//
//     // Parse the response as a JSON object
//     var data = json.decode(response.body);
//
//     // Extract the transaction amount from the JSON object
//     String transactionAmount = data["result"]["value"];
//
//     // Update the state variables with the transaction hash and amount
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'Transaction Hash:',
//             ),
//             Text(
//               '$_transactionHash',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//             Text(
//               'Transaction Amount:',
//             ),
//             Text(
//               '$_transactionAmount',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _verifyTransaction,
//         tooltip: 'Verify Transaction',
//         child: Icon(Icons.check),
//       ),
//     );
//   }
// }

