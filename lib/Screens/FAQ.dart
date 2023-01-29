import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Widget/bottomnavtab.dart';

class FAQ extends StatelessWidget {
  const FAQ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List tra = ['1/5/2022', '1/3/2023', '2/5/2022', '1/12/2020','2/5/2021'];
    tra.sort((a, b) => b.compareTo(a));
    print(tra);
    print('${DateFormat.yMd('en_US').parse('1/5/2022')}');
    print(DateFormat.yMd().format(DateTime.now()));

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
            color: Colors.black
        ),
        elevation: 0,
        backgroundColor: Color(0xffadacac),
        title: Text('FAQs', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400, color: Colors.black87),),
      ),
      bottomNavigationBar: bottomtabwidget(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: RichText(
              text:  TextSpan(
                children: [
                TextSpan(
                text: 'What is Prime Basket?\n', style: TextStyle(color: Colors.black, fontSize: 18)),
                  TextSpan(text: '\n',),
                  TextSpan(
                text: 'Prime Basket is an order fulfillment app that allows its members'
                    ' to earn unlimited income through its partner merchants and sellers. ',
                      style: TextStyle(color: Colors.black54, fontSize: 15)),

                ]),),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: RichText(
              text:  TextSpan(
                children: [
                TextSpan(
                text: 'How do earnings work in Prime Basket? \n', style: TextStyle(color: Colors.black, fontSize: 18)),
                  TextSpan(text: '\n',),
                  TextSpan(
                text: 'Prime Basket has partnered with several sellers and merchants who are selling in different e-commerce platforms across the globe.'
                     'Whenever they receive COD orders, they forward that to Prime Basket, in which the members will fulfill those orders in wholesale price.'
                    ' Once the orders are delivered and paid at retail price by their respective customers,'
                    ' the difference will be the earnings of the members.  ',
                      style: TextStyle(color: Colors.black54, fontSize: 15)),

                ]),),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: RichText(
              text:  TextSpan(
                children: [
                TextSpan(
                text: 'How much and how often can I earn? \n', style: TextStyle(color: Colors.black, fontSize: 18)),
                  TextSpan(text: '\n',),
                  TextSpan(
                text: 'Depending on your Tier, you can earn upto 3.33% daily.'
                    ' For more info, please go to the “Tier System” button.  ',
                      style: TextStyle(color: Colors.black54, fontSize: 15)),

                ]),),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: RichText(
              text:  TextSpan(
                children: [
                TextSpan(
                text: 'Why would sellers and merchants partner up with Prime Basket '
                    'when they are already selling their products in different e-commerce platforms? \n',
                    style: TextStyle(color: Colors.black, fontSize: 18)),
                  TextSpan(text: '\n',),
                  TextSpan(
                text: 'It is beneficial for the sellers and merchants to partner with Prime Basket because whenever they receive COD orders,'
                    ' they don’t have to wait for the products to be delivered to the customers just to get paid. They can get the payment right away from Prime Basket.'
                    ' It’s a win-win for everyone. ',
                      style: TextStyle(color: Colors.black54, fontSize: 15)),

                ]),),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: RichText(
              text:  TextSpan(
                children: [
                TextSpan(
                text: 'Do I have to wait for the order to be delivered to the customers before I can '
                    'start fulfilling again? \n', style: TextStyle(color: Colors.black, fontSize: 18)),
                  TextSpan(text: '\n',),
                  TextSpan(
                text: 'You don’t have to wait for the orders to be delivered. '
                    'Your virtual balance gets refreshed everyday. ',
                      style: TextStyle(color: Colors.black54, fontSize: 15)),
                ]
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: RichText(
              text:  TextSpan(
                children: [
                TextSpan(
                text: 'Will I be getting the orders that I fulfilled?\n',
                    style: TextStyle(color: Colors.black, fontSize: 18)),
                  TextSpan(text: '\n',),
                  TextSpan(
                text: 'Only the customers of our different partner merchants will be getting their respective orders.  ',
                      style: TextStyle(color: Colors.black54, fontSize: 15)),

                ]),),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: RichText(
              text:  TextSpan(
                children: [
                TextSpan(
                text: 'What will happen to my earnings if the customers have paid or canceled their orders?\n',
                    style: TextStyle(color: Colors.black, fontSize: 18)),
                  TextSpan(text: '\n',),
                  TextSpan(
                text: 'Once you start fulfilling orders, the corresponding earnings will automatically get added to your Est. Earnings balance. '
                    'If an order gets delivered to their respective customers, '
                    'the corresponding amount will be transferred from your Est. Earnings to your Actual balance.'
                     'However, if an order gets canceled or it was not delivered to the customer,'
                    ' the corresponding amount will be removed from your Est. Earning balance.'
                    ' It does not have any effect on your virtual balance as it remains intact.  ',
                      style: TextStyle(color: Colors.black54, fontSize: 15)),

                ]),),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: RichText(
              text:  TextSpan(
                children: [
                TextSpan(
                text: 'What’s the difference between Virtual Balance, Est. Earnings, and Actual Balance? \n',
                    style: TextStyle(color: Colors.black, fontSize: 18)),
                  TextSpan(text: '\n',),
                  TextSpan(
                text: 'Whenever you top up, it automatically goes to your Virtual Balance.'
                    ' Virtual balance is the total amount you can use when fulfilling orders.'
                    ' Whenever an order gets delivered, it automatically goes to your Actual Balance. '
                    'Your Actual Balance can then be withdrawn into real money. ',
                      style: TextStyle(color: Colors.black54, fontSize: 15)),

                ]),),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: RichText(
              text:  TextSpan(
                children: [
                TextSpan(
                text: 'How can I top up?\n', style: TextStyle(color: Colors.black, fontSize: 18)),
                  TextSpan(text: '\n',),
                  TextSpan(
                text: 'There are two methods to top up. First method is through Binance or Metamask.'
                    ' If you have Binance account or a Metamask wallet,'
                    ' you can immediately send USDT to the wallet address of Prime Basket.'
                    ' Second method is for those who don’t have a Binance or Metamask wallet but has a bank account or mobile wallet.'
                    ' You just need to transact with our P2P agents depending on the online payment method of your choice. '
                    'Once you have completed your transaction from any of the two methods, '
                    'the respective amount will automatically appear on your account and you can start fulfilling orders.  ',
                      style: TextStyle(color: Colors.black54, fontSize: 15)),

                ]),),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: RichText(
              text:  TextSpan(
                children: [
                TextSpan(
                text: 'How can I withdraw my earnings?\n',
                    style: TextStyle(color: Colors.black, fontSize: 18)),
                  TextSpan(text: '\n',),
                  TextSpan(
                text: 'Just press the Withdraw button and follow the instructions. ',
                      style: TextStyle(color: Colors.black54, fontSize: 15)),

                ]),),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: RichText(
              text:  TextSpan(
                children: [
                TextSpan(
                text: 'How sustainable is Prime Basket? \n', style: TextStyle(color: Colors.black, fontSize: 18)),
                  TextSpan(text: '\n',),
                  TextSpan(
                text: 'Prime Basket is backed by private angel investors and venture capitalists.',
                      style: TextStyle(color: Colors.black54, fontSize: 15)),

                ]),),
          ),
        ],
      ),
    );
  }
}
