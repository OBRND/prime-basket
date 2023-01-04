import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:primebasket/Services/Database.dart';

// Make a request to the BscScan API to retrieve the receipt status of a transaction


Future checkTransactionReceiptStatus(String transactionHash) async {
  final user = FirebaseAuth.instance.currentUser!;

  // late String _transactionHash = '';
  // late var _transactionAmount = '';

  String apiKey = "5ISK5SWNXSBBVEBSZABGZ4W66RMNFK7UKS";

  // Replace TRANSACTION_HASH with the actual transaction hash you want to verify

  // Make a GET request to the BSC Scan API to retrieve the transaction details
  // final response = await http.get(Uri.parse('https://api.bscscan.com/api?module=transaction&action=gettxreceiptstatus&txhash=0x26ce036dc42cd8fc3f7ff76bec3b1e1c55aac3172683384895e94241fa3f18a4&apikey=5ISK5SWNXSBBVEBSZABGZ4W66RMNFK7UKS'));
  // print(response.body);
  final response = await http.get(
    Uri.parse("https://api.bscscan.com/api?module=account&action=txlist&address=0x43492891eaa2e84147ee7f3ec4d0bf010bbbc5f1&apikey=$apiKey"),
  );

  // Parse the response as a JSON object
  var data = json.decode(response.body);
  if (response.statusCode == 200) {
    // Parse the response as a JSON object
    final data = json.decode(response.body); // Check the "success" field in the response to determine the receipt status of the transaction
    print(data);

    // Extract the transaction amount from the JSON object
    print('${data["result"][0]['hash']}');
    print('${data["result"][1]["hash"]}');
    print(data["result"][2]["hash"]);
    print(data["result"][3]["hash"]);
    print(data["result"][4]["hash"]);
    print(data["result"][5]["hash"]);
    List Txlist = await DatabaseService(uid: user.uid).gettransactionHash();

    for(int i = 0; i < (data["result"]).length; i++){

      if(data["result"][i]['hash'] == transactionHash){
        if(Txlist.contains(transactionHash)) {
          return 'Failed';
        }
        else {
          var transactionAmount = (double.parse(data["result"][0]["value"]) /
              1000000000000000000); // for converting the WEI to BNB
          print('----------$transactionAmount--------');

          // var _transactionHash = transactionHash;
          String Usdconverted = await _convertTransactionAmountToUSD(transactionAmount);
          print('++++++++++++$Usdconverted+++++++++++++++++');
          print(Txlist);
          return 'Succesfull';
        }
      }
      else {
        return 'failed';
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

