
import 'package:flutter_bbs/pages/edit/comment/comment.dart';
import 'package:flutter_bbs/pages/detail/detail_stateful.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bbs/utils/snapbar_util.dart';

///created by sgh    2019-02-27
/// "帖子详情"的展示界面
class DetailPageWidget extends StatelessWidget {

  int topicId;         //获取帖子详情必须传递的参数

  DetailPageWidget(this.topicId);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '清水河畔',
      home: Scaffold(
        appBar: PreferredSize(preferredSize: Size.fromHeight(MediaQuery.of(context).size.height*0.08),
          child: AppBar(
            leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.white,), onPressed: () => Navigator.pop(context)),
            title: Text('帖子详情', style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),),
            centerTitle: true,
          ),),
        body: Builder(builder: (context) {
          SnapBarUtil.init(context);
          return DetailWidget(this.topicId);
        }),
        floatingActionButton: FloatingActionButton(
          child: Text("评", style: TextStyle(fontSize: 20, color: Colors.white),),
          onPressed: () {Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return CommentWidget(this.topicId);
              }));},
          elevation: 24,
        ),
      ),
    );
  }
}