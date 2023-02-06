import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:primebasket/Screens/chechreferal.dart';

import '../Services/Auth.dart';
import '../Widget/bottom_tab.dart';
import '../Widget/decorations.dart';

class Sign_up extends StatefulWidget {
  const Sign_up({Key? key}) : super(key: key);

  // late final Function switchview;
  // Sign_up({required this.switchview});

  @override
  State<Sign_up> createState() => _Sign_upState();
}

class _Sign_upState extends State<Sign_up> {

  final Auth_service _auth = Auth_service();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String First_name ='';
  String Last_name ='';
  String Phone_number = '';
  String error ="";
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      // backgroundColor: Colors.deepPurple,
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal:20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text('Register', style: TextStyle(fontSize: 24),),
                  ),
                  SizedBox( height: 10),
                  TextFormField(
                      decoration: textinputdecoration.copyWith(hintText: 'Email'),
                      validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                      onChanged: (val){
                        setState(() => email = val);
                      }
                  ),
                  SizedBox( height: 10),
                  TextFormField(
                      decoration: textinputdecoration.copyWith(hintText: 'Password'),
                      validator: (val) => val!.length < 6 ? 'Enter password more that 6 characters' : null,
                      obscureText: true,
                      onChanged: (val){
                        setState(() => password = val);
                      }
                  ),
                  SizedBox( height: 30),
                  Container(
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      gradient: const LinearGradient(
                          colors: [
                            Color(0xfff6ad16),
                            Colors.amberAccent,
                          ]),
                    ),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          minimumSize: Size.fromHeight(50),),
                        child: Text("Register",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async{
                          if(_formKey.currentState!.validate()){
                            //   setState(() => loading = true);
                            dynamic result = await _auth.registerWEP(email, password);
                            if(result == null){
                              setState((){ error ='please supply a valid email';
                                //     loading = false;
                              });
                            } else {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          referalcheck()));
                            }
                          }
                        }
                    ),
                  ),
                  SizedBox( height: 20),
                  Text(error,
                      style: TextStyle(color: Colors.red)
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      //   );
      // }
    );
  }
}
