import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:primebasket/Widget/bottom_tab.dart';

import '../Screens/Orders/Orders_page.dart';
import '../Screens/Withdrawpages/Withdrawpage.dart';
import '../Screens/home_page.dart';

class bottomtabwidget extends StatefulWidget {
  const bottomtabwidget({Key? key}) : super(key: key);

  @override
  State<bottomtabwidget> createState() => _bottomtabwidgetState();
}

class _bottomtabwidgetState extends State<bottomtabwidget> {

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                // Color(0xffb3b4b6),
                Color(0xff5d71ce),
                Color(0xff473e73),]),
          // borderRadius: BorderRadius.circular(15.0),
          // color: Color(0xffc0c0c4),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: Container(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                mainAxisAlignment: MainAxisAlignment.center,
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 12,
                activeColor: Colors.black,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey[100]!,
                color: Color(0xffdae0e0),
                textStyle: TextStyle(fontSize: 22),
                tabs: [
                  GButton(
                    onPressed: () => Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst),
                    icon: Icons.home,
                    text: 'Account',
                    iconSize: 25,
                  ),
                  GButton(
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 1;
                      });
                      Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
                      },
                    icon: Icons.list,
                    text: 'Orders',
                    iconSize: 25,
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            )
        )
    );
  }
}
