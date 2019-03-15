import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bbs/network/clients/client_login.dart';
import 'package:flutter_bbs/network/json/user.dart';
import 'package:flutter_bbs/utils/user_cacahe_util.dart' as UserCacheUtil;
import 'dart:convert' as convert;

/**
 * create by sgh    2019-2-16
 * 登录界面的UI
 */

class LoginPageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageWidgetState();
  }
}

class LoginPageWidgetState extends State<LoginPageWidget> {
  var mContext;    //负责弹出SnackBar的BuildContext对象
  var user;

  final TextEditingController nameController =
      TextEditingController(); //username输入框的控制器
  final TextEditingController passController =
      TextEditingController(); //password输入框的控制器

  @override
  void initState() {
    super.initState();
    user = UserCacheUtil.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (BuildContext context) {
        mContext = context;
        return Container(
            padding: EdgeInsets.only(left: 40, right: 60, top: 80, bottom: 65),
            child: Container(
                child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: 120.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(bottom: 8),
                      child: Text(
                        '清水河畔',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 34,
                            color: Colors.blue),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 8),
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                            labelText: '用户名', icon: Icon(Icons.person)),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 18),
                      child: TextField(
                        controller: passController,
                        decoration: InputDecoration(
                            labelText: '密码', icon: Icon(Icons.lock)),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                  child: RaisedButton(
                                onPressed: _onLoginPressed,
                                child: Text('登录'),
                                color: Theme.of(context).buttonColor,
                                textColor: Colors.white,
                              ))
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                  child: RaisedButton(
                                onPressed: _onRegasitorPressed,
                                child: Text('注册'),
                                textColor: Colors.white,
                              ))
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )));
      }),
    );
  }

  //发起登陆的事件
  void _onLoginPressed() async {
    var name = nameController.text.trim();
    var pass = passController.text.trim();
    if (name == "" || name == null || pass == "" || pass == null) {
      Scaffold.of(mContext).showSnackBar(showToast('姓名或者密码不能为空'));
      return;
    }

    final response =
        await LoginClient.login(type: 'login', username: name, password: pass);
    if (response.statusCode == 200) {
      User mUser = await compute(_getBody, response.data);
      Navigator.of(mContext).pushNamed('main/mainPage');
      UserCacheUtil.storeUser(mUser);
    } else {
      Scaffold.of(mContext)
          .showSnackBar(showToast(response.statusCode.toString()));
    }
  }

  void _onRegasitorPressed() async {
    var hash = await UserCacheUtil.getAppHash();
  }

  //根据传入的内容返回一个SnackBar
  SnackBar showToast(content) {
    return SnackBar(
      content: Text("${content}"),
      duration: Duration(milliseconds: 1500),
    );
  }
}

//通过compute内部调用该方法实现后台解析Json
User _getBody(body) {
  print("this is Login.dart _getBody method---------------------------");
  return User.fromJson(convert.jsonDecode(body));
}
