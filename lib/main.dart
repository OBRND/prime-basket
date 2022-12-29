import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:primebasket/Screens/Orders/Withdraw.dart';
import 'package:primebasket/Screens/Sign_up.dart';
import 'package:primebasket/Screens/binance_page.dart';
import 'package:primebasket/Screens/binancewithdrawal.dart';
import 'package:primebasket/Screens/home_page.dart';
import 'package:primebasket/Screens/login_page.dart';
import 'package:primebasket/Screens/mobibank_wallet_page.dart';
import 'package:primebasket/Screens/mobiwalletwithdraw.dart';
import 'package:primebasket/Screens/notification_page.dart';
import 'package:primebasket/Screens/order_fulfullment_page.dart';
import 'package:primebasket/Screens/p2p_page.dart';
import 'package:primebasket/Screens/share_page.dart';
import 'package:primebasket/Screens/top_up_page.dart';
import 'package:primebasket/Screens/withrawal_deposit.dart';
import 'package:primebasket/Widget/bottom_tab.dart';
import 'package:provider/provider.dart';

import 'Services/Auth.dart';
import 'Services/User.dart';
import 'Wrapper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp(
    // home: const LoginPage(),

    routes:{
      'login':(context)=>  LoginPage(),
      '/Signup':(context)=>const Sign_up(),
      '/Bottomnavigation':(context)=> const BottomTab(),
      '/home':(context)=> HomePage(),
      '/topup':(context)=>const TopUpPage(),
      '/Withdraw':(context)=>const Withdrawal(),
      '/notif':(context)=> NotifPage(),
      '/orderfulfill':(context)=> OrderFulfilled(),
      '/withdrawal':(context)=>const WithdrawalPage(),
      '/p2p':(context)=> const P2pTadingPage(),
      '/share':(context)=>const SharePage(),
      '/binance':(context)=> const BinancePage(),
      '/binancewithdraw':(context)=> const binancewithdraw(),
      '/mobiwallet':(context) => const MobileWallet(),
      '/mobiwalletwithdraw':(context) => const mobiwalletwithdraw(),

    },
  ));
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key, required Map<String, Widget Function(dynamic)> routes}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Firebase.initializeApp();
    return StreamProvider<UserFB?>.value(
        value: Auth_service().Userx,
        initialData: null,
        child: MaterialApp(
          home: wrapper(),
        )
    );
  }
}


