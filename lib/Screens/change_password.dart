import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:primebasket/Screens/login_page.dart';

import '../Services/Auth.dart';
import '../Widget/bottomnavtab.dart';

class changePassword extends StatefulWidget {
  @override
  State<changePassword> createState() => _changePasswordState();
}

class _changePasswordState extends State<changePassword> {
  // const changePassword({Key? key}) : super(key: key);
  final user = FirebaseAuth.instance.currentUser!;
  final Auth_service _auth= Auth_service();
  final _formkey = GlobalKey<FormState>();

  String email = '';
  String error = '';
  String password = '';
  String newPassword = '';

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Change your password'),
      ),
      bottomNavigationBar: bottomtabwidget(),
      body: Form(
        key: _formkey,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width*0.1, vertical: size.height*0.02),
              child: TextFormField(
                onChanged: (val){
                  setState(() => email = val);
                },
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: size.width*0.005),
                  labelText: "Email",
                  labelStyle: TextStyle(fontWeight: FontWeight.w400)
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
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: size.width*0.005),
                  labelText: "Password",
                    labelStyle: TextStyle(fontWeight: FontWeight.w400)),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width*0.1, vertical: size.height*0.02),
              child: TextFormField(
                onChanged: (val){
                  setState(() => newPassword = val);
                },
                validator: (val) => val!.length <6 ? ' Enter password more that 6 characters' : null,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: size.width*0.005),
                  labelText: "Your new password",
                    labelStyle: TextStyle(fontWeight: FontWeight.w400)
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
              child: ElevatedButton(
                onPressed: () async{
                  if(_formkey.currentState!.validate()){
                    // setState(() => loading = true);
                    dynamic result = await _auth.Signin_WEP(email, password);
                    // Navigator.push(context, new MaterialPageRoute(builder: (context) => new Profile(result: new result("Priyank","28"))));
                    if(result == null){
                      setState(() {
                        error = 'Wrong Email or password';
                        // loading = false;
                      });
                    }
                    if(result != null){
                      changepassword(context);
                    }
                  }
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        )
                    ),
                    backgroundColor: MaterialStateColor.resolveWith((states) => Colors.green)),
                child: Center(
                    child: Text("Confirm",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 22),)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future changepassword(BuildContext context) async {
    try {
      await user.updatePassword(newPassword);
      FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => LoginPage()));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Your password has been updated... Please login with your new password'),));
    }
    catch(e){

    }
  }
}