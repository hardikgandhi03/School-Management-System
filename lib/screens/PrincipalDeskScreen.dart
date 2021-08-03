import 'package:flutter/material.dart';
import 'package:school_management_system/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class PrincipalDeskScreen extends StatelessWidget {
  static final String id = 'PrincipalDeskScreen';
  const PrincipalDeskScreen({Key? key}) : super(key: key);

  void _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryBlue,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryBlue,
        title: Text(
          'Principal Desk',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      body: Container(
        decoration: kContainerDecoration,
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 80.0,
                  backgroundImage:
                      AssetImage('assets/images/principalImage.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Alexa H Jacisal",
                  style: TextStyle(
                    fontSize: 30.0,
                    fontFamily: "Source Sans Pro",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "For any support request regards your orders or deliveries please feel free to speak with us at below.",
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: "Source Sans Pro",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => _launchUrl('tel: +91 9876543210'),
                      child: CircleAvatar(
                          radius: 30.0,
                          backgroundColor: Colors.blue.shade100,
                          child: Icon(
                            Icons.phone,
                            size: 35.0,
                            color: Colors.blue.shade900,
                          )),
                    ),
                    GestureDetector(
                      onTap: () =>
                          _launchUrl('mailto: shahshyamal15@yahoo.com'),
                      child: CircleAvatar(
                          radius: 30.0,
                          backgroundColor: Colors.yellow.shade100,
                          child: Icon(
                            Icons.email_rounded,
                            size: 35.0,
                            color: Colors.yellow.shade900,
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
