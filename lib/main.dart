import 'package:flutter/material.dart';
import 'package:flutter_bbs/pages/login/login.dart';
import 'package:flutter_bbs/pages/main/main.dart' as mainpage;
import 'package:flutter_bbs/pages/edit/edit.dart' as edit;
import 'package:flutter_bbs/pages/user/posted/posted.dart';
import 'package:flutter_bbs/pages/user/collection/collect.dart';
import 'package:flutter_bbs/pages/detail/detail.dart';
import 'package:flutter_bbs/utils/user_cacahe_util.dart' as UserCacheUtil;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        buttonColor: Colors.lightBlueAccent,
      ),
      routes: <String,WidgetBuilder>{
        'main/mainPage': (context) => mainpage.MainPageWidget(),
        'edit/editPage': (context) => edit.EditPageWidget(),
        'user/userPost': (context) => UserPostPageWidget(),
        'user/userCollection' : (context) => UserCollectionWidget(),
        'detail/detailPage' : (context) => DetailPageWidget(),
        'login/loginPage' : (context) => LoginPageWidget(),
      },
      home: FutureBuilder<String>(
          future: UserCacheUtil.getUser(),
          builder: (context, snaphot) {
            if (snaphot.hasData) {
              if (snaphot.data == "none") {
                return LoginPageWidget();
              } else {
                return mainpage.MainPageWidget();
              }
            } else {
              return Image.asset('images/bg_splash.png',
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              );
            }
          }),
    );
  }
}
