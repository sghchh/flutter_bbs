
import 'package:flutter_bbs/pages/user/posted/posted_stateful.dart';

import 'package:flutter/material.dart';

///created by sgh    2019-2-23
/// User界面“我的发表”的UI

class UserPostPageWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        buttonColor: Colors.lightBlueAccent,
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.arrow_back,),
              onPressed: () => Navigator.of(context).pop()),
          iconTheme: IconThemeData(color: Colors.white, size: 24),
          title: Text(
            "我的发表", style: TextStyle(fontSize: 24, color: Colors.white),
            textAlign: TextAlign.center,),
        ),
        body: PostedWidget(),
      ),
    );
  }

}