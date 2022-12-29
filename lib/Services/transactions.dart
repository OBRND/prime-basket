import 'dart:convert';
import 'package:http/http.dart' as http;
// Make a request to the BscScan API to retrieve the receipt status of a transaction
Future checkTransactionReceiptStatus(StringtransactionHash) async {
  final response = await http.get(Uri.parse('https://api.bscscan.com/api?module=transaction&action=gettxreceiptstatus&txhash=0x26ce036dc42cd8fc3f7ff76bec3b1e1c55aac3172683384895e94241fa3f18a4&apikey=5ISK5SWNXSBBVEBSZABGZ4W66RMNFK7UKS'));
  print(response.body);

  if (response.statusCode == 200) {
    // Parse the response as a JSON object
    final data = json.decode(response.body); // Check the "success" field in the response to determine the receipt status of the transaction
    return data['message']; } else { // Throw an exception if the request failed
    throw Exception('Failed to retrieve transaction receipt status');
  }
}