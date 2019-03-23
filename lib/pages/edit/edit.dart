import 'package:flutter/material.dart';
import 'package:flutter_bbs/pages/edit/edit_stateful.dart';

///Created by sgh   2019-2-22
/// 编辑帖子的界面

class EditPageWidget extends StatelessWidget {

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
            "编辑帖子", style: TextStyle(fontSize: 24, color: Colors.white),
            textAlign: TextAlign.center,),
        ),
        body: EditWidget()
      ),
    );
  }
}