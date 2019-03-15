import 'dart:convert' as convert;

import 'package:flutter_bbs/network/json/user.dart';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';



///created by sgh     2019-3-4
/// 通过使用SharePreference来存储User信息
/// 从而决定是否需要登录

User _mUser;
Future<User> finalUser() async{
  if (_mUser != null)
    return _mUser;
  var sharedPreferences = await SharedPreferences.getInstance();
  var userInfo = sharedPreferences.getString('userinfo');
  sharedPreferences = null;
  User u = User.fromJson(convert.jsonDecode(userInfo));
  _mUser = u;
  return u;
}

///储存User对象
storeUser(user) async {
  var sharedPreferences = await SharedPreferences.getInstance();
  String userString = convert.jsonEncode(user);
  sharedPreferences.setString('userinfo', userString);
  sharedPreferences = null;
  return;
}

///获取User对象
Future<String> getUser() async {
  var sharedPreferences = await SharedPreferences.getInstance();
  var userInfo = sharedPreferences.getString('userinfo');
  sharedPreferences = null;
  return userInfo == null ? "none" : userInfo;
}

///获取AppHash
Future<String> getAppHash () async{
  const _apphash = const MethodChannel('com.bbs.apphash');
  var result = await _apphash.invokeMethod('getAppHash');
  return result;
}


///用于后台解析Json的方法
_bindUser(String soucre) {
  User u = User.fromJson(convert.jsonDecode(soucre));
  return;
}
