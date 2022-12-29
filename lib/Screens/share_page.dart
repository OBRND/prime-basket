import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:primebasket/Widget/animated_text.dart';

class SharePage extends StatelessWidget {
  const SharePage({Key? key}) : super(key: key);
  Future<void> share() async {
    await FlutterShare.share(
        title: 'Prime basket app',
        text: "Hi, let\'s start earning BIG together. Register to Prime Basket using my code to get a bonus  ' 4y9r3uWdmZgahwguu5cjjl3fodk2 '",
        linkUrl: 'https://play.google.com/store/apps/details?id=com.primebasket.app&pli=1',
        chooserTitle: 'Share prime basket'
    );
  }


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(child: Scaffold(
      body: ListView(
        children: [
          TextButton(
            child: Text('Share text and link'),
            onPressed: share,
          ),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: size.width*0.02),
          //   child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Image.asset('images/logo.png', width: size.width*0.15,),
          //       Image.asset('images/Logotext.png', width: size.width*0.6,)
          //       ,IconButton(onPressed: (){}, icon: Icon(Icons.doorbell, color:Colors.red,size: size.width*0.1,))
          //     ],
          //   ),
          // ),
          // const BuildAnimatedText(),

          Center(child: Text("Share", style: TextStyle(fontSize: size.width*0.06, fontWeight: FontWeight.w700),),),
          Padding(
            padding: EdgeInsets.symmetric(vertical: size.height*0.02),
            child: SizedBox(
              height: size.height*0.03,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  AmberSelector(size: size),
                  AmberSelector(size: size),
                  AmberSelector(size: size),
                  AmberSelector(size: size),
                  AmberSelector(size: size),
                  AmberSelector(size: size),
                  AmberSelector(size: size),
                  AmberSelector(size: size),
                  AmberSelector(size: size),
                  AmberSelector(size: size),
                  AmberSelector(size: size),
                  AmberSelector(size: size),
                  AmberSelector(size: size),
                  AmberSelector(size: size),
                  AmberSelector(size: size)
                ],
              ),
            ),
          ),
          Padding(
            padding:EdgeInsets.symmetric(horizontal:size.width*0.02,vertical: size.height*0.01),
            child: MaterialButton(onPressed: (){},
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            ),
              color: Colors.purpleAccent.withOpacity(0.7),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: size.height*0.02),
                child: Text("Share on Facebook", style: TextStyle(fontSize: size.width*0.055,color: Colors.white),),
              ),
            ),
          ),
          Center(child: Text("OR", style: TextStyle(fontSize: size.width*0.07,color: Colors.black,fontWeight: FontWeight.bold),)),

          Padding(
            padding:EdgeInsets.symmetric(horizontal:size.width*0.02,vertical: size.height*0.01),
            child: MaterialButton(onPressed: share,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              color: Colors.purpleAccent.withOpacity(0.7), child: Padding(
                padding: EdgeInsets.symmetric(vertical: size.height*0.02),
                child: Text("Share as message", style: TextStyle(fontSize: size.width*0.055,color: Colors.white),),
              ),
            ),
          )

        ],
      ),
    ));
  }
}

class AmberSelector extends StatelessWidget {
  const AmberSelector({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.amber, width: 3)
        ),
        child: const Text('sri',style: TextStyle(color:Colors.transparent)),
      ),
    );
  }
}
