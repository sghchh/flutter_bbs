
import 'package:flutter/foundation.dart';
import 'package:flutter_bbs/network/http_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bbs/network/json/bbs_response.dart';
import 'package:meta/meta.dart';
import 'dart:convert' as convert;

/**
 * created by sgh     2019-3-3
 * 负责Home界面的网络请求的客户端
 */
class HomeClient {

  static final newReply = "/app/web/index.php?r=forum/topiclist&pageSize=10";    //"最新回复"网络请求的path
  static final todayHot = "/app/web/index.php?r=portal/newslist&moduleId=2";     //"今日热点"网络请求的path
  static final newPublish = "/app/web/index.php?r=forum/topiclist&pageSize=10";  //"最新发表"网络请求的path  和最新回复的区别是参数多了一个sortby = new

  static Dio _client = DioClient.getInstance();    //真正的网络请求的客户端

  //获取"最新回复"的数据
  static Future<BBSRepListPost> getNewReply(Map query) async {
    final response = await _client.post(newReply, queryParameters: query);
    var result;
    if (response.statusCode == 200) {
      result = await compute(decodeResponse, response.data);
      return result;
    }
    return result;
  }

  //获取"今日热点"的数据
  static Future getTodayHot(Map query) async{
    final response = await _client.post(todayHot, queryParameters: query);
    var result;
    if (response.statusCode == 200) {
      result = await compute(decodeResponse, response.data);
      return result;
    }
    return result;
  }

  //获取"最新发表"的数据
  static Future getNewPublish(Map query) async{
    var newQuery = {'accountToken' : query['accountToken'], 'accountSecret' : query['accountSecret'], 'apphash' : query['apphash'], 'sortby' : 'new'};
    //print("this is query-------------${query.toString()}");
    final response = await _client.post(newPublish, queryParameters: newQuery);
    var result;
    if (response.statusCode == 200) {
      result = await compute(decodeResponse, response.data);
      return result;
    }
    return result;
  }


  //后台解析json
  static BBSRepListPost decodeResponse(data) {
    return BBSRepListPost.fromJson(convert.jsonDecode(data));
  }
}