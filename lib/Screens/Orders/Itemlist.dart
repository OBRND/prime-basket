import 'package:flutter/material.dart';

class Items extends StatelessWidget {
  // const Items({Key? key}) : super(key: key);
String Item = 'Ear Buds';
double Amount = 1000;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Stack(
        children: [
          Container(
            height: 200,
            width: 200,
            decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/goldcard.png'),
                  fit: BoxFit.fitHeight,
                )
            ),
          ),
          Positioned(
            bottom: 10,
            left: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$Item',
                      style: TextStyle(color: Colors.white, fontSize: 30),),
                    Text('$Amount \$'),
                  ],
                ),
                SizedBox(width: 20,),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: Column(
              children: [
                Text('Est. earnings',
                    style: TextStyle(color: Colors.white, fontSize: 15)),
                Text('0.20 \$'),
              ],
            ),
          )
        ],
      ),
    );
  }
}

