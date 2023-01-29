import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Widget/bottomnavtab.dart';

class contactUs extends StatelessWidget {
  const contactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 1,
        title: Text('Contact us', style: TextStyle(color: Colors.black54),),
      ),
      bottomNavigationBar: bottomtabwidget(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(text: TextSpan(
              children: [
                TextSpan(
                    text: 'Facebook\n', style: TextStyle(color: Colors.black54, fontSize: 25)
                ),
                TextSpan(
                  text: 'https://facebook.com/primebasketapp\n\n',
                  style: new TextStyle(color: Colors.blue),
                  recognizer: new TapGestureRecognizer()
                    ..onTap = () async{
                      AndroidIntent intent = AndroidIntent(
                          action: 'action_view',
                          data: Uri.encodeFull('https://facebook.com/primebasketapp'),
                          package: 'com.facebook.katana'// replace com.example.app with your applicationId
                      );
                      await intent.launch();

                    }
                    // launchUrl(Uri.parse('https://facebook.com/primebasketapp'));
                    // },
                ),
                TextSpan(
                  text: '\n', style: TextStyle(fontSize: 20)
                ),
                TextSpan(
                    text: 'Email\n', style: TextStyle(color: Colors.black54, fontSize: 25)
                ),
                TextSpan(
                  text: 'primebasketapp@gmail.com\n\n',
                  style: new TextStyle(color: Colors.blue),
                  recognizer: new TapGestureRecognizer()
                    ..onTap = () {
                      String? encodeQueryParameters(Map<String, String> params) {
                        return params.entries
                            .map((MapEntry<String, String> e) =>
                        '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                            .join('&');
                      }
                      _sendMail() async {
                        // Android and iOS
                        // final url = 'mailto:primebasketapp@gmail.com?subject=Greetings&body=Dear%20primebasket%20team';
                        final Uri emailLaunchUri = Uri(
                          scheme: 'mailto',
                          path: 'primebasketapp@gmail.com',
                          query: encodeQueryParameters(<String, String>{
                            'subject': 'Greetings Primebasket team',
                          }),
                        );

                        if (await canLaunchUrl(emailLaunchUri)) {
                          await launchUrl(emailLaunchUri);
                        } else {
                          throw 'Could not launch $emailLaunchUri';
                        }
                      }
                      _sendMail();
                    // launchUrl(Uri.parse('primebasketapp@gmail.com'));
                    },
                ),
                TextSpan(
                    text: '\n', style: TextStyle(fontSize: 20)
                ),
                TextSpan(
                  text: 'Telegram\n', style: TextStyle(color: Colors.black54, fontSize: 25)
                ),
                TextSpan(
                  text: 'https://t.me/primebasketapp\n\n',
                  style: new TextStyle(color: Colors.blue),
                  recognizer: new TapGestureRecognizer()
                    ..onTap = () async{
                      final AndroidIntent intent = AndroidIntent(
                          action: 'action_view',
                          data: Uri.encodeFull('https://t.me/primebasketapp'),
                          package: 'org.telegram.messenger'// replace com.example.app with your applicationId
                      );
                      await intent.launch();

                    // launchUrl(
                    //     mode: LaunchMode.externalNonBrowserApplication,
                    //     Uri.parse('https://www.t.me/primebasketapp'));
                    },
                ),
                TextSpan(
                    text: '\n', style: TextStyle(fontSize: 20)
                ),
                TextSpan(
                    text: 'Twitter\n', style: TextStyle(color: Colors.black54, fontSize: 25)
                ),
                TextSpan(
                  text: 'https://twitter.com/PrimeBasketEarn\n',
                  style: new TextStyle(color: Colors.blue),
                  recognizer: new TapGestureRecognizer()
                    ..onTap = () async{
                      final AndroidIntent intent = AndroidIntent(
                          action: 'action_view',
                          data: Uri.encodeFull('https://twitter.com/PrimeBasketEarn'),
                          package: 'com.twitter.android'// replace com.example.app with your applicationId
                      );
                      await intent.launch();

                    // launchUrl(
                    //     mode: LaunchMode.platformDefault,
                    //     Uri.parse('https://twitter.com/PrimeBasketEarn'));
                    },
                ),
              ]

            ))
          ],
        ),
      ),
    );
  }
}
