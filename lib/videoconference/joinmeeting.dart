import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:jitsi_meet/feature_flag/feature_flag_enum.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:twoconnect/variables.dart';

class JoinMeeting extends StatefulWidget {
  @override
  _JoinMeetingState createState() => _JoinMeetingState();
}

class _JoinMeetingState extends State<JoinMeeting> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController roomcontroller = TextEditingController();
  bool isVideoOff = true;
  bool isAudioOff = true;
  String username = '';

  @override
  void initState() {
    super.initState();
    getuserdata();
  }

  getuserdata() async {
    DocumentSnapshot userdoc =
        await usercollection.doc(FirebaseAuth.instance.currentUser.uid).get();
    setState(() {
      username = userdoc.data()['username'];
    });
  }

  joinmeeting() async {
    try{
      Map<FeatureFlagEnum, bool> featureflags = {
        FeatureFlagEnum.WELCOME_PAGE_ENABLED: false
      };
      if(Platform.isAndroid){
        featureflags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      }
      else if(Platform.isIOS){
        featureflags[FeatureFlagEnum.PIP_ENABLED] = false;
      }

      var options = JitsiMeetingOptions()
      ..room = roomcontroller.text
      ..userDisplayName = namecontroller.text == '' ? username : namecontroller.text
      ..audioMuted = isAudioOff
      ..videoMuted = isVideoOff
      ..getFeatureFlags();
      await JitsiMeet.joinMeeting(options);
    }
    catch(e){
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 24,
              ),
              Text(
                "Room Code",
                style: mystyle(22),
              ),
              SizedBox(
                height: 20,
              ),
              PinCodeTextField(
                  controller: roomcontroller,
                  length: 6,
                  autoDisposeControllers: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(shape: PinCodeFieldShape.underline),
                  animationDuration: Duration(milliseconds: 300),
                  onChanged: (value) {}),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: namecontroller,
                style: mystyle(20),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter Name (deafult: username)",
                    labelStyle: mystyle(15, Colors.grey)),
              ),
              SizedBox(
                height: 16,
              ),
              CheckboxListTile(
                activeColor: Color(0xFFB40284A),
                checkColor: Colors.white,
                value: isVideoOff,
                onChanged: (value) {
                  setState(() {
                    isVideoOff = value;
                  });
                },
                title: Text(
                  "Video Off",
                  style: mystyle(18, Colors.black),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              CheckboxListTile(
                activeColor: Color(0xFFB40284A),
                checkColor: Colors.white,
                value: isAudioOff,
                onChanged: (value) {
                  setState(() {
                    isAudioOff = value;
                  });
                },
                title: Text(
                  "Audio Off",
                  style: mystyle(18, Colors.black),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "You can change these settings in the meeting too.",
                style: mystyle(15, Colors.grey),
                textAlign: TextAlign.center,
              ),
              Divider(
                height: 48,
                thickness: 2.0,
              ),
              InkWell(
                onTap: () => joinmeeting(),
                child: Container(
                  width: double.maxFinite,
                  height: 64,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Color(0xFFB40284A),
                  ),
                  child: Center(
                    child: Text(
                      "Join Meeting",
                      style: mystyle(20, Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
