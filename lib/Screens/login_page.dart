import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:primebasket/Screens/Sign_up.dart';
import 'package:primebasket/Screens/home_page.dart';
import 'package:provider/provider.dart';

import '../Services/Auth.dart';
import '../Widget/bottom_tab.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // const LoginPage({Key? key}) : super(key: key);
  final Auth_service _auth= Auth_service();
  final _formkey = GlobalKey<FormState>();
  String password = '';
  String email = '';
  String error= '';

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Prime Basket',
                style: GoogleFonts.courgette(
                  textStyle: TextStyle(fontSize: size.height*0.06, fontWeight: FontWeight.w500 ),)),
              ),
              SizedBox(height: 20,),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width*0.1, vertical: size.height*0.02),
                      child: TextFormField(
                          onChanged: (val){
                            setState(() => email = val);
                          },
                        style: TextStyle(fontSize: size.width*0.06),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: size.width*0.005),
                           labelText: "Email",
                          labelStyle: TextStyle(fontWeight: FontWeight.w300)
                        ),
                        validator: (val) => val!.isEmpty ? ' Enter an email' : null,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width*0.1, vertical: size.height*0.02),
                      child: TextFormField(
                          onChanged: (val){
                            setState(() => password = val);
                          },
                        validator: (val) => val!.length <6 ? ' Enter password more that 6 characters' : null,
                        style: TextStyle(fontSize: size.width*0.06),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: size.width*0.005),
                          labelText: "Password",
                            labelStyle: TextStyle(fontWeight: FontWeight.w300)
                          // hintText: 'Enter your password here'
                        ),
                      ),
                    ),
                    Card(
                      elevation: 0,
                      color: Colors.transparent,
                      child: Text(error,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width*0.15, vertical: size.height*0.05),
                      child: Container(
                        height: 40,
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
                          onPressed: () async{
                            if(_formkey.currentState!.validate()){
                              // setState(() => loading = true);
                              dynamic result = await _auth.Signin_WEP(email, password);
                              // Navigator.push(context, new MaterialPageRoute(builder: (context) => new Profile(result: new result("Priyank","28"))));
                              if(result == null){
                                setState(() {
                                  error = 'Could not sign in with those credentials';
                                  // loading = false;
                                });
                              }
                              if(result != null){
                                Navigator.of(context).pushReplacement(MaterialPageRoute(
                                    builder: (context) => BottomTab(index: 0)));
                              }
                            }
                            // Navigator.pushNamed(context, '/Bottomnavigation');
                          },
                          child: Center(
                              child: Text("Login",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                fontSize: 22),)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),



              Text("OR", style: TextStyle(fontSize: size.width*0.07, fontWeight: FontWeight.w400),),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width*0.15, vertical: size.height*0.05),
                child:ElevatedButton(
                  onPressed: () async{
                    dynamic result = await _auth.googleLogin();
                    if(result == null){
                      setState(() {
                        error = 'Could not sign in with those credentials';
                        // loading = false;
                      });
                    }
                    if(result != null){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => BottomTab(index: 0)));
                    }
                },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.black54),)
                      ),
                      backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset('images/google.svg',width: MediaQuery.of(context).size.width*0.06),
                    Text("Sign in with Google",
                      style: TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.w400),)
                  ],
                ),),
              ),
            Wrap(
              alignment: WrapAlignment.spaceEvenly,
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  // SizedBox(height: size.width*0.06),
                  Text("Are you new to Prime Basket?",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => Sign_up()));
                    },
                    child: Center(child: Text("Sign Up",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 22),)),
                )])
            ],
          ),
        ),
      ),
    );
  }
}
