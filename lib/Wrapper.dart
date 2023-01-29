import 'package:flutter/material.dart';
import 'package:primebasket/Screens/home_page.dart';
import 'package:primebasket/Screens/login_page.dart';
import 'package:primebasket/Widget/bottom_tab.dart';
import 'package:provider/provider.dart';
import 'Services/User.dart';

class wrapper extends StatelessWidget {
  // const ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserFB?>(context);
    print(user);
    if (user == null){
      return LoginPage();
    } else {
      return BottomTab(index: 0);
    }
  }
}
