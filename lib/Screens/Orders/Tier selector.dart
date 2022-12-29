import 'package:flutter/material.dart';

class Tier extends StatefulWidget {
  const Tier({Key? key}) : super(key: key);

  @override
  State<Tier> createState() => _TierState();
}

class _TierState extends State<Tier> {
  List<String> categories = ["Tier One", "Tier Two", "Tier Three", "Tier Four", "Tier Five", "Tier Six",
    "Tier Seven", "Tier Eight", "Tier Nine"];
  // By default our first item will be selected
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: 25,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) => buildCategory(index),
        ),
      ),
    );
  }
  Widget buildCategory(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Padding(
        padding:  const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              categories[index],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selectedIndex == index ? Colors.black54 : Colors.grey,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10 ), //top padding 5
              height: 2,
              width: 30,
              color: selectedIndex == index ? Colors.black : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}

