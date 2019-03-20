
import 'package:flutter/foundation.dart';
import 'package:flutter_bbs/network/http_client.dart';

import 'package:meta/meta.dart';
import 'package:dio/dio.dart';

///created by sgh    2019-3-2
/// 负责登录请求的Client类
class LoginClient {
  static final url = 'http://bbs.uestc.edu.cn/mobcent/app/web/index.php?r=user/login';    //发起登陆请求的url

  static Dio _dioClient = DioClient.getInstance();
  //实现"登录"或者"注销"请求的方法
  static Future login ({@required type, @required username, @required password}) async {
    var map = {"type" : type, "username" : username, "password" : password};
    //post请求的返回体
    var response;
    try {
      response = await _dioClient.post(url, queryParameters: map);
    } on DioError catch(e) {
      if (e.response != null)
        print(e.response.statusCode);
      response = e.response;
    }
    return response;
  }


}