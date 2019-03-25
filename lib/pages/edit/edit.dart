import 'package:flutter/material.dart';
import 'package:flutter_bbs/pages/edit/edit_stateful.dart';

///Created by sgh   2019-2-22
/// 编辑帖子的界面

class EditPageWidget extends StatelessWidget {

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
                '编辑帖子',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20),
              ),
              centerTitle: true,
            ),
            preferredSize:  Size.fromHeight(MediaQuery.of(context).size.height*0.08)),
        body: EditWidget()
      ),
    );
  }
}