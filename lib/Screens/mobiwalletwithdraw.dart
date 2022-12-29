import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

import '../Widget/decorations.dart';

class mobiwalletwithdraw extends StatefulWidget {
  const mobiwalletwithdraw({Key? key}) : super(key: key);

  @override
  State<mobiwalletwithdraw> createState() => _mobiwalletwithdrawState();
}

class _mobiwalletwithdrawState extends State<mobiwalletwithdraw> {
  double balance = 0;
  String Countrytext = 'Select country';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      body: ListView(
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.all(30.0),
              child: Text('Enter your bank details',
                style: TextStyle(fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Colors.black54),),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.all(30.0),
              child: Row(
                children: [
                  Text('Actual balance:',
                    style: TextStyle(fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.black54),),
                  Text('\$$balance',
                    style: TextStyle(fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.black54),),
                ],
              ),
            ),),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              style: TextStyle(fontSize: size.width * 0.06),
              decoration: textinputdecoration.copyWith(
                  hintText: 'Account number'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onTap: (){
                showCountryPicker(
                  context: context,
                  showPhoneCode: true, // optional. Shows phone code before the country name.
                  onSelect: (Country country) {
                    Countrytext = country.name;
                    print('Select country: ${country.name}');
                  },
                );
              },
              style: TextStyle(fontSize: size.width * 0.06),
              decoration: textinputdecoration.copyWith(
                  hintText: '$Countrytext'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              style: TextStyle(fontSize: size.width * 0.06),
              decoration: textinputdecoration.copyWith(
                  hintText: 'Account number'),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
            child: MaterialButton(onPressed: () {},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),),
              elevation: 30,
              color: Colors.lightGreen,
              child: Text("Submit", style: TextStyle(
                  fontSize: size.width * 0.065, color: Colors.white),),),
          )
        ],
      ),
    );
  }
}
