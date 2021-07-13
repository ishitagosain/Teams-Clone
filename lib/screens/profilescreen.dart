import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:twoconnect/authentication/navigateauthscreen.dart';
import 'package:twoconnect/variables.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = '';
  bool dataisthere = false;
  TextEditingController usernamecontroller = TextEditingController();

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
      dataisthere = true;
    });
  }

  editprofile() async {
    usercollection
        .doc(FirebaseAuth.instance.currentUser.uid)
        .update({'username': usernamecontroller.text});
    setState(() {
      username = usernamecontroller.text;
    });
    Navigator.pop(context);
  }

  openeditprofiledialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: 200,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 30, right: 30),
                    child: TextField(
                      controller: usernamecontroller,
                      style: mystyle(18, Colors.black),
                      decoration: InputDecoration(
                          labelStyle: mystyle(16, Colors.grey),
                          labelText: "Update Username"),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () => editprofile(),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Color(0xFFB40284A),
                      ),
                      child: Center(
                        child: Text(
                          "Update Profile",
                          style: mystyle(17, Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB40284A),
      body: dataisthere == false
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: <Widget>[
                ClipPath(
                  clipper: OvalBottomBorderClipper(),
                  child: Container(
                    child: Image.asset('images/profile2.jpg',
                        height: MediaQuery.of(context).size.height),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2.5,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 2 - 75,
                      top: MediaQuery.of(context).size.height / 3.1),
                  child: CircleAvatar(
                    radius: 75,
                    backgroundImage: NetworkImage(
                        'https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg'),
                    // child: Image.asset('images/Ishita Photo.jpeg'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 1.7,
                      top: MediaQuery.of(context).size.height / 2.3),
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 350,
                      ),
                      Text(
                        username,
                        style: mystyle(40, Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 45),
                      InkWell(
                        onTap: () => openeditprofiledialog(),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 47,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                              ),
                              color: Color(0xFFB40284A),
                              borderRadius: BorderRadius.circular(50)),
                          child: Center(
                            child: Text(
                              "Edit Profile",
                              style: mystyle(20, Colors.orange[700]),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      InkWell(
                        onTap: () {
                          FirebaseAuth.instance.signOut();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 47,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                              ),
                              color: Color(0xFFB40284A),
                              borderRadius: BorderRadius.circular(50)),
                          child: Center(
                            child: Text(
                              "Logout",
                              style: mystyle(20, Colors.orange[700]),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
