import 'package:flutter_bbs/pages/user/collection/collect_stateful.dart';

import 'package:flutter/material.dart';

///created by sgh    2019-2-26
/// 用户信息中“我的收藏”的界面
class UserCollectionWidget extends StatelessWidget {
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
                '我的收藏',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20),
              ),
              centerTitle: true,
            ),
            preferredSize:  Size.fromHeight(MediaQuery.of(context).size.height*0.08)),
        body: CollectionWidget(),
      ),
    );
  }
}
