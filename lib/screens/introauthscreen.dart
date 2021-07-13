import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:twoconnect/authentication/navigateauthscreen.dart';
import 'package:twoconnect/variables.dart';

class IntroAuthScreen extends StatefulWidget {
  @override
  _IntroAuthScreenState createState() => _IntroAuthScreenState();
}

class _IntroAuthScreenState extends State<IntroAuthScreen> {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: Colors.white,
      pages: [
        PageViewModel(
            title: "Welcome",
            body: "Welcome to twoConnect, the best video conferencing app",
            image: Center(
              child: Image.asset('images/welcome.jpg', height: 500, width: 1000,),
            ),
            decoration: PageDecoration(
                bodyTextStyle: mystyle(20, Colors.black),
                titleTextStyle: mystyle(25, Colors.black))),
        PageViewModel(
            title: "Join or Start Meetings",
            body:
                "Easy to use interface, join or start meetings in a fast time",
            image: Center(
              child: Image.asset('images/conference.png', height: 500, width: 1000,),
            ),
            decoration: PageDecoration(
                bodyTextStyle: mystyle(20, Colors.black),
                titleTextStyle: mystyle(25, Colors.black))),
        PageViewModel(
            title: "Security",
            body:
                "Your security is of utmost importance. Our servers are reliable and secure.",
            image: Center(
              child: Image.asset('images/security.jpg', height: 500, width: 1000,),
            ),
            decoration: PageDecoration(
                bodyTextStyle: mystyle(20, Colors.black),
                titleTextStyle: mystyle(25, Colors.black))),
      ],
      onDone: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => NavigateAuthScreen()));
      },
      onSkip: () {},
      showSkipButton: true,
      skip: const Icon(Icons.skip_next, size: 45, color: Colors.black),
      next: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.black,
      ),
      done: Text(
        "Done",
        style: mystyle(20, Colors.black),
      ),
    );
  }
}
