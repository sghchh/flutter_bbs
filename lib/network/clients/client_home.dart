import 'package:flutter_bbs/network/http_client.dart';

import 'package:dio/dio.dart';

///created by sgh     2019-3-3
///负责Home界面的网络请求的客户端
class HomeClient {
  static final newReply =
      "/app/web/index.php?r=forum/topiclist&pageSize=10"; //"最新回复"网络请求的path
  static final todayHot =
      "/app/web/index.php?r=portal/newslist&moduleId=2"; //"今日热点"网络请求的path
  static final newPublish =
      "/app/web/index.php?r=forum/topiclist&pageSize=10"; //"最新发表"网络请求的path  和最新回复的区别是参数多了一个sortby = new

  static Dio _client = DioClient.getInstance(); //真正的网络请求的客户端

  //获取"最新回复"的数据
  static Future getNewReply(Map query) async {
    var response;
    try {
      response = await _client.post(newReply, queryParameters: query);
    } on DioError catch (e) {
      if (e.response != null) print(e.response.statusCode);
      response = e.response;
    }
    return response;
  }

  //获取"今日热点"的数据
  static Future getTodayHot(Map query) async {
    var response;
    try {
      response = await _client.post(todayHot, queryParameters: query);
    } on DioError catch (e) {
      if (e.response != null) print(e.response.statusCode);
      response = e.response;
    }
    return response;
  }

  //获取"最新发表"的数据
  static Future getNewPublish(Map query) async {
    var newQuery = {
      'accountToken': query['accountToken'],
      'accountSecret': query['accountSecret'],
      'apphash': query['apphash'],
      'sortby': 'new',
      'page': query['page']
    };
    var response;
    try {
      response = await _client.post(newPublish, queryParameters: newQuery);
    } on DioError catch (e) {
      if (e.response != null) print(e.response.statusCode);
      response = e.response;
    }
    return response;
  }
}
