import 'package:flutter/material.dart';
import 'package:flutter_bbs/pages/detail/detail_stateful.dart';

/**
 * created by sgh    2019-02-27
 * "帖子详情"的展示界面
 */
class DetailPageWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '清水河畔',
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.white,), onPressed: null),
          title: Text('帖子详情', style: TextStyle(fontSize: 24, color: Colors.white),),
          centerTitle: true,
        ),
        body: DetailWidget(),
      ),
    );
  }
}