import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:primebasket/Screens/Orders/Orders_page.dart';
import 'package:primebasket/Screens/home_page.dart';
class BottomTab extends StatefulWidget {
  const BottomTab({Key? key}) : super(key: key);

  @override
  State<BottomTab> createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Orders()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar:  Container(
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      // Color(0xffb3b4b6),
                      Color(0xff748fc2),
                      Color(0xff766aad),]),
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
                    tabs: const [
                      GButton(
                        icon: Icons.home,
                        text: 'Account',
                        iconSize: 25,
                      ),
                      GButton(
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
        )
      );
    }
}

