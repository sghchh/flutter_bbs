

import 'package:flutter/material.dart';
import 'package:flutter_bbs/pages/user/friends/friends_stateful.dart';

/// 用户的好友列表的界面
class UserFriendsWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '清水河畔',
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
                '我的好友',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20),
              ),
              centerTitle: true,
            ),
            preferredSize:  Size.fromHeight(MediaQuery.of(context).size.height*0.08)),
        body: FriendsWidget(),
      ),
    );
  }
}