import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:primebasket/Screens/Orders/Tier%20selector.dart';
import 'package:primebasket/Services/Database.dart';
import 'package:provider/provider.dart';

import '../../Services/User.dart';
import '../../Widget/bottomnavtab.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
 // String Item = 'Headset';
 double Amount = 10.00;
 List<String> categories = [ "All","1", "2", "3", "4", "5", "6", "7", "8", "9","10"];
 // By default our first item will be selected
 int selectedIndex = 10;
 String selecteddrop = "All";
 double Balance = 1000;
 List products = [];
 List userinfo = [];
 late double bal;

 Future getproducts() async{
   final user = Provider.of<UserFB?>(context);
   final uid = user!.uid;
   products = await DatabaseService(uid: uid).orders();
   userinfo = await DatabaseService(uid: uid).getuserInfo();
   // userinfo = await DatabaseService(uid: uid).getproductid();
 }

 @override
  Widget build(BuildContext context) {
   final user = Provider.of<UserFB?>(context);
   final uid = user!.uid;
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xfff6f7f8),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 13, top: 30),
              child: Text('Order fullfillment center',
                style: GoogleFonts.courgette(
                  textStyle: TextStyle(color: Color(0xff353536), fontSize: 25, fontWeight: FontWeight.w700 ),)),
            ),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SizedBox(
                height: 50,
                child: buildCategory(),
                ),
              ),
            SizedBox(height: 10,),
            chooselist(size)
          ],
        ),
      ),
    );
  }

  Widget chooselist(size){
   return selectedIndex == 10 ? Column(
     mainAxisAlignment: MainAxisAlignment.start,
     crossAxisAlignment: CrossAxisAlignment.start,
     children: [
       Padding(
         padding: const EdgeInsets.only(left: 10),
         child: Card(
           elevation: 5,
           shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(15.0),
           ),
             color: Color(0xff7a8186),
             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text('Tier 1', style: TextStyle(color: Colors.white),),
             )),
       ),
       Container(
           height: 230,
           child: builditemlist(size, 0)),
       Padding(
         padding: const EdgeInsets.only(left: 10),
         child: Card(
             elevation: 5,
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(15.0),
             ),
             color: Color(0xff7a8186),
             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text('Tier 2', style: TextStyle(color: Colors.white),),
             )),
       ),
       Container(
           height: 230,
           child: builditemlist(size, 1)),
       Padding(
         padding: const EdgeInsets.only(left: 10),
         child: Card(
             elevation: 5,
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(15.0),
             ),
             color: Color(0xff7a8186),
             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text('Tier 3', style: TextStyle(color: Colors.white),),
             )),
       ),
       Container(
           height: 230,
           child: builditemlist(size, 2)),
       Padding(
         padding: const EdgeInsets.only(left: 10),
         child: Card(
             elevation: 5,
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(15.0),
             ),
             color: Color(0xff7a8186),
             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text('Tier 4', style: TextStyle(color: Colors.white),),
             )),
       ),
       Container(
           height: 230,
           child: builditemlist(size, 3)),
       Padding(
         padding: const EdgeInsets.only(left: 10),
         child: Card(
             elevation: 5,
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(15.0),
             ),
             color: Color(0xff7a8186),
             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text('Tier 5', style: TextStyle(color: Colors.white),),
             )),
       ),
       Container(
           height: 230,
           child: builditemlist(size, 4)),
       Padding(
         padding: const EdgeInsets.only(left: 10),
         child: Card(
             elevation: 5,
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(15.0),
             ),
             color: Color(0xff7a8186),
             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text('Tier 6', style: TextStyle(color: Colors.white),),
             )),
       ),
       Container(
           height: 230,
           child: builditemlist(size, 5)),
       Padding(
         padding: const EdgeInsets.only(left: 10),
         child: Card(
             elevation: 5,
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(15.0),
             ),
             color: Color(0xff7a8186),
             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text('Tier 7', style: TextStyle(color: Colors.white),),
             )),
       ),
       Container(
           height: 230,
           child: builditemlist(size, 6)),
       Padding(
         padding: const EdgeInsets.only(left: 10),
         child: Card(
             elevation: 5,
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(15.0),
             ),
             color: Color(0xff7a8186),
             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text('Tier 8', style: TextStyle(color: Colors.white),),
             )),
       ),
       Container(
           height: 230,
           child: builditemlist(size, 7)),
       Padding(
         padding: const EdgeInsets.only(left: 10),
         child: Card(
             elevation: 5,
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(15.0),
             ),
             color: Color(0xff7a8186),
             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text('Tier 9', style: TextStyle(color: Colors.white),),
             )),
       ),
       Container(
           height: 230,
           child: builditemlist(size, 8)),
       Padding(
         padding: const EdgeInsets.only(left: 10),
         child: Card(
             elevation: 5,
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(15.0),
             ),
             color: Color(0xff7a8186),
             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text('Tier 10', style: TextStyle(color: Colors.white),),
             )),
       ),
       Container(
           height: 230,
           child: builditemlist(size, 9)),
     ],
   ) :  Container(
       height: size.height*.8,
       child: builditempertier());
  }

  Widget builditempertier(){

    return FutureBuilder(
      future: getproducts(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          switch(snapshot.connectionState){
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
              default: return ListView.separated(
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(10),
                itemCount: products[selectedIndex].length,
                separatorBuilder: (context, index){
                  return const SizedBox(width: 10);},
                itemBuilder: (context, index) {
                  final user = FirebaseAuth.instance.currentUser!;
                  // final user = Provider.of<UserFB?>(context);
                  final uid = user!.uid;

                  Size size = MediaQuery.of(context).size;
                  SnackBar snackBar = SnackBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    content: Card(
                        color: Colors.redAccent,
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              Icon(Icons.dangerous_rounded),
                              Text('  You have insufficient balance!', style: TextStyle(
                                fontSize: size.width*.04, fontWeight: FontWeight.w600
                              ),),
                            ],
                          ),
                        )),
                  );
                  SnackBar snackBartier = SnackBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    content: Card(
                        color: Colors.redAccent,
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              Icon(Icons.dangerous_rounded),
                              Text('  Upgrade you tier to get access', style: TextStyle(
                                  fontSize: size.width*.04, fontWeight: FontWeight.w600
                              ),),
                            ],
                          ),
                        )),
                  );
                  List<Widget> list = <Widget>[];
                  for(var i = 0; i < products[selectedIndex].length; i++) {
                    print('${products[selectedIndex][i].name} ---${products[selectedIndex][i].PID}');
                    list.add( InkWell(
                      onTap: double.parse(products[selectedIndex][i].price) > double.parse(userinfo[0]) ?
                          (){ScaffoldMessenger.of(context).showSnackBar(snackBar);} :
                      selectedIndex + 1 > int.parse(userinfo[3]) ?
                          (){ScaffoldMessenger.of(context).showSnackBar(snackBartier);} :
                          () {
                        int initialQty = 0;
                        double total = 0;
                        bal = double.parse(userinfo[0]);

                        showDialog(context: context,
                            builder: (_) =>
                                StatefulBuilder(
                                    builder: (context, setState) =>
                                        AlertDialog(
                                            contentPadding: EdgeInsets.all(10),
                                            scrollable: true,
                                            title: const Text(
                                              'Confirm for purchase',
                                              style: TextStyle(fontSize: 20,
                                                  fontWeight: FontWeight
                                                      .w600),),
                                            content: Column(
                                                children: [
                                                  Container(
                                                    height: 150,
                                                    child:products[selectedIndex][i].image == null ?
                                                    Center(child: Text('sorry, couldn\'t load image information')) : Image.network('${products[selectedIndex][i].image}'),
                                                  ),
                                                  Card(
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius
                                                          .circular(10.0),),
                                                    color: Colors.indigoAccent,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .all(10.0),
                                                      child: Text('Balance: ${bal.toStringAsFixed(2)}',style: TextStyle(color: Colors.white),)
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 200,
                                                    child: Card(
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius
                                                              .circular(10.0),),
                                                        color: Colors.white70,
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment
                                                              .center,
                                                          crossAxisAlignment: CrossAxisAlignment
                                                              .center,
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                  .only(
                                                                  top: 15),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment
                                                                    .center,
                                                                children: [
                                                                  Center(
                                                                      child: Text(
                                                                        'Total amount: \$',
                                                                        style: TextStyle( fontWeight: FontWeight.w500, fontSize: 18),)),
                                                                  Center(
                                                                      child: total == 0 ? Text('${products[selectedIndex][i].price}',
                                                                        style: TextStyle( fontWeight: FontWeight.w500, fontSize: 19),) : Text(
                                                                        '$total',
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight.w500, fontSize: 19),)),
                                                                ],
                                                              ),
                                                            ),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment
                                                                  .center,
                                                              children: [
                                                                const Text('Qty:',
                                                                  style: TextStyle(
                                                                      fontSize: 16,
                                                                      fontWeight: FontWeight
                                                                          .w500),),
                                                                SizedBox(
                                                                  width: 35,
                                                                  child: TextButton(
                                                                      onPressed: initialQty == 0? null : () {
                                                                       if(initialQty > 0){
                                                                         setState(() {
                                                                           bal += double.parse(products[selectedIndex][i].price);
                                                                          initialQty -= 1;
                                                                          total = initialQty * double.parse(products[selectedIndex][i].price);
                                                                        });
                                                                       }
                                                                      },
                                                                      child: const Text(
                                                                        '-',
                                                                        style: TextStyle(
                                                                            fontSize: 25),)),
                                                                ),
                                                                Text(
                                                                    '$initialQty',
                                                                    style: TextStyle(
                                                                        fontSize: 18)),
                                                                SizedBox(
                                                                  width: 35,
                                                                  child: TextButton(
                                                                      onPressed: bal - (double.parse(products[selectedIndex][i].price))< 0 ? null : () {
                                                                          setState(() {
                                                                          bal -= double.parse(products[selectedIndex][i].price);
                                                                          initialQty += 1;
                                                                          total = initialQty * double.parse(products[selectedIndex][i].price);
                                                                        });
                                                                      },
                                                                        // else initialQty = initialQty;
                                                                      // },
                                                                      child: Text(
                                                                        '+',
                                                                        style: TextStyle(
                                                                            fontSize: 25),)),
                                                                )

                                                              ],
                                                            ),
                                                          ],
                                                        )
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                    style: ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                            RoundedRectangleBorder( borderRadius: BorderRadius.circular(10.0),)
                                                        ),
                                                        backgroundColor: MaterialStateColor.resolveWith((states) => Colors.lightGreen)),
                                                    onPressed: () async{
                                                      if (initialQty > 0){
                                                      print("$initialQty, ${(double.parse(products[selectedIndex][i].earnings) * initialQty).toString()} ,${user
                                                          .email!} ,${products[selectedIndex][i].PID}, ${products[selectedIndex][i].name}, 'processing', "
                                                          "${double.parse(products[selectedIndex][i].price) * initialQty}, $uid");
                                                       await DatabaseService(uid: uid)
                                                          .makeorder(initialQty, double.parse(products[selectedIndex][i].earnings) * initialQty ,user.email! ,
                                                          products[selectedIndex][i].PID, products[selectedIndex][i].name, 'processing',
                                                          double.parse(products[selectedIndex][i].price) * initialQty, uid);

                                                      Navigator.pop(context);}
                                                      else {
                                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                        elevation: 0,
                                                        backgroundColor: Colors.transparent,
                                                        content: Card(
                                                            color: Colors.redAccent,
                                                            child: Padding(
                                                              padding: EdgeInsets.all(15.0),
                                                              child: Row(
                                                                children: [
                                                                  Icon(Icons.dangerous_rounded),
                                                                  Text('  Please select a valid quantity', style: TextStyle(
                                                                      fontSize: size.width*.04, fontWeight: FontWeight.w600
                                                                  ),),
                                                                ],
                                                              ),
                                                            )),
                                                      ));
                                                      }},
                                                    child: Text("Confirm",
                                                      style: TextStyle(
                                                          fontSize: 16),),
                                                  ),
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    child: Text("Cancel",
                                                        style: TextStyle(
                                                            fontSize: 16)),
                                                  ),
                                                ]))));
                      },
                      child: products[selectedIndex][i].image == null ?
                      Center(child: Text('sorry, couldn\'t load image information'))
                      : Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Stack(
                          fit: StackFit.loose,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: MediaQuery.of(context).size.width * .5,
                                child: Center(
                                  child: Image.network('${products[selectedIndex][i].image}',
                                      loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;}
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: Colors.transparent,
                                        alignment: Alignment.center,
                                        child: const Text(
                                          'Whoops! couldn\'t load image. check your internet connection',
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                                top: -4,
                                right: -4,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(15),
                                        bottomLeft: Radius.circular(15)),),
                                  color: Colors.deepPurpleAccent,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Column(
                                      children: [
                                        Text('Delivery: ${products[selectedIndex][i].duration}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10)),
                                        Text('Qty: ${products[selectedIndex][i].qty}', style: TextStyle(
                                            color: Colors.white, fontSize: 10)),
                                      ],
                                    ),
                                  ),)),
                            Positioned(
                              bottom: 10,
                              left: 5,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text('${products[selectedIndex][i].name}', style: TextStyle(color: Colors.black54,
                                          fontSize: 20, fontWeight: FontWeight.w400)),
                                      Text(' \$${products[selectedIndex][i].price}', style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700)),
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
                                  Text('Est. earnings', style: TextStyle(
                                      color: Colors.black54, fontSize: 14)),
                                  Text('\$${products[selectedIndex][i].earnings}', style: TextStyle(
                                      color: Colors.black, fontSize: 16)),
                                   ],
                              ),
                            ),
                            Positioned(
                                bottom: 0,
                                left: 0,
                                child: Card(
                                  child: Container(
                                    height: 4,
                                    width: selectedIndex == 0 ? 33 : selectedIndex == 1 || selectedIndex == 2 || selectedIndex == 3 ? 45:
                                    selectedIndex == 4 || selectedIndex == 5 || selectedIndex == 6 || selectedIndex == 7 || selectedIndex == 8 ? 60 : 70,
                                    color: Colors.transparent,),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(15),
                                        bottomLeft: Radius.circular(15)),),
                                  color: Colors.deepPurpleAccent,
                                )),
                          ],
                        ),
                      ),
                    ));
                  }

                  return new Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: list);
            },
          );
      }
      }
    );
 }

  Widget builditemlist(Size size, int tier){
    return FutureBuilder(
        future: getproducts(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          switch(snapshot.connectionState){
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
              default: return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(10),
                  itemCount: products[tier].length,
                  separatorBuilder: (context, index){
                    return const SizedBox(width: 10);},
                  itemBuilder: (context, index) {
                    List<Widget> list = <Widget>[];
                    for(var i = 0; i < products[tier].length; i++) {
                      list.add(buildcard(tier, i));
                    }
                    return new Row(
           // crossAxisAlignment: CrossAxisAlignment.,
                        children: list);
                  }
                  );
          }
        }
        );
 }

  Widget buildcard(int tier, int i) {
    late List product;
    final user = Provider.of<UserFB?>(context);
    Size size = MediaQuery.of(context).size;
    final uid = user!.uid;
    // String image = 'images/img_2.png';
    SnackBar snackBar = SnackBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: Card(
          color: Colors.redAccent,
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(
              children: [
                Icon(Icons.dangerous_rounded),
                Text('  You have insufficient balance!', style: TextStyle(
                    fontSize: size.width*.04, fontWeight: FontWeight.w600
                ),),
              ],
            ),
          )),
    );
    SnackBar snackBartier = SnackBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: Card(
          color: Colors.redAccent,
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(
              children: [
                Icon(Icons.dangerous_rounded),
                Text('  Upgrade you tier to get access', style: TextStyle(
                    fontSize: size.width*.04, fontWeight: FontWeight.w600
                ),),
              ],
            ),
          )),
    );
    return InkWell(
      onTap: double.parse(products[tier][i].price) > double.parse(userinfo[0]) ?
          (){ScaffoldMessenger.of(context).showSnackBar(snackBar);} :
      tier + 1 > int.parse(userinfo[3]) ? (){ScaffoldMessenger.of(context).showSnackBar(snackBartier);} :
          () async {
        int initialQty = 0;
        double total = 0;
        bal = double.parse(userinfo[0]);
        showDialog(context: context,
            builder: (_) =>
                StatefulBuilder(
                    builder: (context, setState) =>
                        AlertDialog(
                          title: SizedBox(height: 10),
                            contentPadding: EdgeInsets.all(10),
                            scrollable: true,
                            content: Column(
                                children: [
                                  Card(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
                                    color: Colors.redAccent,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                          'Balance: ${bal.toStringAsFixed(2)}',style: TextStyle(
                                          color: Colors.white),
                                      )
                                    ),
                                  ),
                                  Container(
                                    height: 150,
                                    child: CachedNetworkImage(
                                      errorWidget:  (context, error, stackTrace) {
                                        return Container(
                                          color: Colors.black12,
                                          alignment: Alignment.center,
                                          child: const Text(
                                            'Whoops! couldn\'t load image. check your connection and try again',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        );
                                      },
                                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                                          CircularProgressIndicator(
                                            value: downloadProgress.totalSize != null ?
                                            downloadProgress.downloaded / downloadProgress.totalSize! : null,
                                          ),
                                      imageUrl: '${products[tier][i].image}',),
                                  ),
                                  Container(
                                    width: 200,
                                    child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius
                                              .circular(10.0),),
                                        color: Colors.white70,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top: 15),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .center,
                                                children: [
                                                  Center(
                                                      child: Text(
                                                        'Total amount: \$',
                                                        style: TextStyle( fontWeight: FontWeight.w500, fontSize: 18),)),
                                                  Center(
                                                      child: total == 0 ? Text('${products[tier][i].price}',
                                                        style: TextStyle( fontWeight: FontWeight.w500, fontSize: 19),) : Text(
                                                        '$total',
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.w500, fontSize: 19),)),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .center,
                                              children: [
                                                const Text('Qty:',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight
                                                          .w500),),
                                                SizedBox(
                                                  width: 35,
                                                  child: TextButton(
                                                      onPressed: initialQty == 0 ? null : () {
                                                        if(initialQty > 0){
                                                          setState(() {
                                                            bal += double.parse(products[tier][i].price);
                                                            initialQty -= 1;
                                                            total = initialQty * double.parse(products[tier][i].price);
                                                          });}
                                                      },
                                                      child: const Text(
                                                        '-',
                                                        style: TextStyle(
                                                            fontSize: 25),)),
                                                ),
                                                Text(
                                                    '$initialQty',
                                                    style: TextStyle(
                                                        fontSize: 18)),
                                                SizedBox(
                                                  width: 35,
                                                  child: TextButton(
                                                      onPressed: bal - (double.parse(products[tier][i].price)) < 0 ? null : () {
                                                        setState(() {
                                                          bal -= double.parse(products[tier][i].price);
                                                          initialQty += 1;
                                                          total = initialQty * double.parse(products[tier][i].price);
                                                        });
                                                      },
                                                      // else initialQty = initialQty;
                                                      // },
                                                      child: Text(
                                                        '+',
                                                        style: TextStyle(
                                                            fontSize: 25),)),
                                                )
                                              ],
                                            ),
                                          ],
                                        )
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty
                                            .all<
                                            RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius
                                                  .circular(
                                                  10.0),)
                                        ),
                                        backgroundColor: MaterialStateColor
                                            .resolveWith((
                                            states) =>
                                        Colors.lightGreen)),
                                    onPressed: () async{
                                      if(initialQty > 0){
                                        final user = FirebaseAuth.instance.currentUser!;
                                        await DatabaseService(uid: uid).makeorder(initialQty, double.parse(products[tier][i].earnings) * initialQty,
                                            user.email!,
                                            products[tier][i].PID,
                                            products[tier][i].name,
                                            'processing',
                                            double.parse(
                                                products[tier][i].price) *
                                                initialQty,
                                            uid);
                                        Navigator.pop(context);
                                      } else {
                                        {
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                            elevation: 0,
                                            backgroundColor: Colors.transparent,
                                            content: Card(
                                                color: Colors.redAccent,
                                                child: Padding(
                                                  padding: EdgeInsets.all(15.0),
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons
                                                          .dangerous_rounded),
                                                      Text(
                                                        '  Please select a valid quantity',
                                                        style: TextStyle(
                                                            fontSize: size
                                                                .width *
                                                                .04,
                                                            fontWeight: FontWeight
                                                                .w600
                                                        ),),
                                                    ],
                                                  ),
                                                )),
                                          ));
                                        }
                                      }
                                    },
                                    child: Text("Confirm",
                                      style: TextStyle(
                                          fontSize: 16),),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context),
                                    child: Text("Cancel",
                                        style: TextStyle(
                                            fontSize: 16)),
                                  ),
                                ]))));
      },
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Stack(
          children: [
            Container(
              height: 180,
              width: 180,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CachedNetworkImage(
                    errorWidget:  (context, error, stackTrace) {
                      return Container(
                        color: Colors.black12,
                        alignment: Alignment.center,
                        child: const Text(
                          'Whoops! couldn\'t load image. check your connection and try again',
                          style: TextStyle(fontSize: 20),
                        ),
                      );
                    },
                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                        CircularProgressIndicator(
                          value: downloadProgress.totalSize != null ?
                          downloadProgress.downloaded / downloadProgress.totalSize! : null,
                        ),
                    imageUrl: '${products[tier][i].image}',),
                ),
              ),
            ),
            Positioned(
                top: -4,
                right: -4,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15)),),
                  color: Colors.deepPurpleAccent,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        Text('Delivery: ${products[tier][i].duration}',
                            style: TextStyle(
                                color: Colors.white, fontSize: 10)),
                        Text('Qty: ${products[tier][i].qty}', style: TextStyle(
                            color: Colors.white, fontSize: 10)),
                      ],
                    ),
                  ),)),
            Positioned(
              bottom: 12,
              left: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${products[tier][i].name}',
                        style: TextStyle(color: Colors.black54, fontSize: 14),),
                      Text(' \$${products[tier][i].price}', style: TextStyle(
                          color: Colors.black87,
                          fontSize: 25,
                          fontWeight: FontWeight.w700)),
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
                      style: TextStyle(color: Colors.black54, fontSize: 11)),
                  Text('\$${products[tier][i].earnings}',
                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600, fontSize: 16)),
                ],
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                child: Card(
                  child: Container(
                    height: 4,
                    width: tier == 0 ? 33 : tier == 1 || tier == 2 || tier == 3 ? 45:
                    tier == 4 || tier == 5 || tier == 6 || tier == 7 || tier == 8 ? 60 : 70,
                    color: Colors.transparent,),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15)),),
                  color: Colors.deepPurpleAccent,
                  )),
          ],
        ),
      ),
    );
  }



 Widget buildCategory() {
   return Center(
     child: Card(
       shape:  RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(20.0),
       ),
       child: Padding(
         padding: const EdgeInsets.only(top: 5, bottom: 3, right: 10, left: 10),
         child: DropdownButton(
           borderRadius: BorderRadius.circular(20),
           menuMaxHeight: MediaQuery.of(context).size.height*.7,
           iconEnabledColor: Colors.deepPurpleAccent,
           dropdownColor: Color(0xeac8cfef),
           underline: SizedBox(),
             // Initial Value
             value: selecteddrop, style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87, fontSize: 17),
             // Down Arrow Icon
             icon: const Icon(Icons.keyboard_arrow_down),
             // Array list of items
             items: categories.map((String items) {
               return DropdownMenuItem(
                 value: items,
                 child: Text(items),
               );
             }).toList(),
             // After selecting the desired option,it will
             // change button value to selected value
             onChanged: (String? newValue) {
               setState(() {
                 selecteddrop = newValue!;
                 selecteddrop == '1' ? selectedIndex = 0 :
                 selecteddrop == '2' ? selectedIndex = 1 :
                 selecteddrop == '3' ? selectedIndex = 2 :
                 selecteddrop == '4' ? selectedIndex = 3 :
                 selecteddrop == '5' ? selectedIndex = 4 :
                 selecteddrop == '6' ? selectedIndex = 5 :
                 selecteddrop == '7' ? selectedIndex = 6 :
                 selecteddrop == '8' ? selectedIndex = 7 :
                 selecteddrop == '9' ? selectedIndex = 8 :
                 selecteddrop == '10' ? selectedIndex = 9 :
                 selectedIndex = 10;
               });
             },
           ),
       ),
     ),
   );
   //   GestureDetector(
   //   onTap: () {
   //     setState(() {
   //       selectedIndex = index;
   //     });
   //   },
   //   child: Padding(
   //     padding:  const EdgeInsets.symmetric(horizontal: 8),
   //     child: Container(
   //       height: 50,
   //       decoration: selectedIndex == index ? BoxDecoration(
   //         gradient: const LinearGradient(
   //             colors: [
   //               Color(0xc09363e1),
   //               Color(0xff5f57e8)]),
   //         borderRadius: BorderRadius.circular(15.0),
   //       ) : null,
   //       child: Card(
   //         color: selectedIndex == index ? Colors.transparent :
   //         Colors.white,
   //         shape: RoundedRectangleBorder(
   //           borderRadius: BorderRadius.circular(10.0),
   //         ),
   //         elevation: 10,
   //         child: Padding(
   //           padding: const EdgeInsets.all(10.0),
   //           child: Column(
   //             mainAxisSize: MainAxisSize.min,
   //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
   //             crossAxisAlignment: CrossAxisAlignment.start,
   //             children: <Widget>[
   //               Text(
   //                 categories[index],
   //                 style: TextStyle(
   //                   fontWeight: FontWeight.bold,
   //                   fontSize: selectedIndex == index ? 17 : 14,
   //                   color: selectedIndex == index ? Colors.white : Colors.grey,
   //                 ),
   //               ),
   //               Container(
   //                 // margin: const EdgeInsets.only(top: 10 ), //top padding 5
   //                 height: 2,
   //                 width: 30,
   //                 color: selectedIndex == index ? Colors.black : Colors.transparent,
   //               )
   //             ],
   //           ),
   //         ),
   //       ),
   //     ),
   //   ),
   // );
 }

}
