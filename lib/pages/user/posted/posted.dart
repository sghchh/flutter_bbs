
import 'package:flutter_bbs/pages/user/posted/posted_stateful.dart';

import 'package:flutter/material.dart';

///created by sgh    2019-2-23
/// User界面“我的发表”的UI

class UserPostPageWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        buttonColor: Colors.lightBlueAccent,
      ),
      home: Scaffold(
        appBar: PreferredSize(
            child: AppBar(
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.pop(context)),
              title: Text(
                '我的发表',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20),
              ),
              centerTitle: true,
            ),
            preferredSize:  Size.fromHeight(MediaQuery.of(context).size.height*0.08)),
        body: PostedWidget(),
      ),
    );
  }

}