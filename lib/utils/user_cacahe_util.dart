import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bbs/network/json/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import 'package:crypto/crypto.dart';

/**
 * created by sgh     2019-3-4
 * 通过使用SharePreference来存储User信息
 * 从而决定是否需要登录
 */

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

/**
 * 储存User对象
 */
storeUser(user) async {
  var sharedPreferences = await SharedPreferences.getInstance();
  String userString = convert.jsonEncode(user);
  sharedPreferences.setString('userinfo', userString);
  print("-----------this is cache store,store successed finalUser is---------------${finalUser}");
  sharedPreferences = null;
  return;
}

//获取User对象
Future<String> getUser() async {
  print("this is getUser in cacheutil----------");
  var sharedPreferences = await SharedPreferences.getInstance();
  var userInfo = sharedPreferences.getString('userinfo');
  print("this is getUser in usercache and user 是-------------${userInfo.toString()}");
  sharedPreferences = null;
  //await compute(_bindUser, user);
  return userInfo == null ? "none" : userInfo;
}

//获取AppHash
Future<String> getAppHash () async{
  const _apphash = const MethodChannel('com.bbs.apphash');
  var result = await _apphash.invokeMethod('getAppHash');
  return result;
}


//用于后台解析Json的方法
_bindUser(String soucre) {
  print("this is bindUser----------------------");
  User u = User.fromJson(convert.jsonDecode(soucre));
  print("this is binduser 解析出来的user的值是：${u.toString()}");
  return;
}
