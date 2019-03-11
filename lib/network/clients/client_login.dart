
import 'package:flutter/foundation.dart';
import 'package:flutter_bbs/network/json/user.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bbs/network/json/login.dart';
import 'dart:convert' as convert;

/**
 * created by sgh    2019-3-2
 * 负责登录请求的Client类
 */
class LoginClient {
  static final url = 'http://bbs.uestc.edu.cn/mobcent/app/web/index.php?r=user/login';    //发起登陆请求的url

  //实现"登录"或者"注销"请求的方法
  static Future<Response> login ({@required type, @required username, @required password}) async {
    print("this is client_login.dart login method---------------------------");
    //post请求的返回体
    final response = await http.post(url, body : <String, String>{'type':type, 'username': username, 'password' : password});
    return response;
  }


}