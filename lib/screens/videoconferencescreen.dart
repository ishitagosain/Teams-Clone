import 'package:flutter/material.dart';
import 'package:twoconnect/variables.dart';
import 'package:twoconnect/videoconference/createmeeting.dart';
import 'package:twoconnect/videoconference/joinmeeting.dart';

class VideoConferenceScreen extends StatefulWidget {
  @override
  _VideoConferenceScreenState createState() => _VideoConferenceScreenState();
}

class _VideoConferenceScreenState extends State<VideoConferenceScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  buildtab(String name) {
    return Container(
      width: 150,
      height: 50,
      child: Card(
        child: Center(
          child: Text(name, style: mystyle(15, Colors.black, FontWeight.w700)),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFFB40284A),
        title: Text(
          "twoConnect",
          style: mystyle(22, Colors.white, FontWeight.w700),
        ),
        bottom: TabBar(
          indicatorColor: Color(0xFFB40284A),
          controller: tabController,
          tabs: <Widget>[buildtab("Join Meeting"), buildtab("Create Meeting")],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[JoinMeeting(), CreateMeeting()],
      ),
    );
  }
}
