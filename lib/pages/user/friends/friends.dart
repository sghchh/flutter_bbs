

import 'package:flutter/material.dart';
import 'package:flutter_bbs/pages/user/friends/friends_stateful.dart';

/// 用户的好友列表的界面
class UserFriendsWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '清水河畔',
      home: Scaffold(
        appBar: AppBar(
          title: Text('我的好友', textAlign: TextAlign.center,),
          centerTitle: true,
        ),
        body: FriendsWidget(),
      ),
    );
  }
}