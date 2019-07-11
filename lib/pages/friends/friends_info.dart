import 'package:flutter/material.dart';
import 'package:flutter_bbs/pages/friends/friends_info_stateful.dart';
class FriendInfoWidget extends StatelessWidget {
  int uid;
  FriendInfoWidget({@required this.uid});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '清水河畔',
      home: Scaffold(
        appBar: PreferredSize(
            child: AppBar(
              backgroundColor: Colors.blueAccent,
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: (){
                    Navigator.pop(context);
                    print("this is test");
                  }),
              title: Text(
                '个人信息',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20),
              ),
              centerTitle: true,
            ),
            preferredSize:  Size.fromHeight(MediaQuery.of(context).size.height * 0.06)),
        body: FriendInfoStateful(uid: this.uid,),
      ),
    );
  }
}