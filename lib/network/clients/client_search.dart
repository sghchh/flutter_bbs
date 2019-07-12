import 'package:dio/dio.dart';
import 'package:flutter_bbs/network/http_client.dart';

class SearchClient {
  static final _topicInfo = "/app/web/index.php?r=forum/search";    //搜索帖子的路径
  static final _userInfo = "/app/web/index.php?r=user/searchuser";    // 搜索用户的路径
  static final Dio _dioClient = DioClient.getInstance();

  //搜索帖子的方法
  static Future searchTopic (Map<String, dynamic> query) async {
    var response;
    try {
      response = await _dioClient.post(_topicInfo, queryParameters: query);
    } on DioError catch(e) {
      if (e.response != null)
        print(e.response.statusCode);
      response = e.response;
    }
    print(response.runtimeType);
    return response;
  }

  //搜索用户的方法
  static Future searchUser(Map<String, dynamic> query) async {
    var response;
    try {
      response = await _dioClient.post(_userInfo, queryParameters: query);
    } on DioError catch(e) {
      if (e.response != null)
        print(e.response.statusCode);
      response = e.response;
    }
    return response;
  }
}