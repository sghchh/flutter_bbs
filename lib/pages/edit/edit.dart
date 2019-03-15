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
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 5),
                child: TextField(decoration: InputDecoration(
                    hintText: "标题",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 16)
                ),
                  maxLines: 3,
                  cursorWidth: 0,
                ),
              ),
              //Divider(color: Colors.grey,),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 5),
                  child: TextField(decoration: InputDecoration(
                      hintText: "内容",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                      border: InputBorder.none
                  ),
                    maxLines: 10,
                    cursorWidth: 0,
                  ),
                ),
              ),
              //Divider(color: Colors.grey,),
              EditWidget()
            ],
          ),
        ),
      ),
    );
  }
}