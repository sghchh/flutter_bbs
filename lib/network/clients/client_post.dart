
import 'package:flutter_bbs/network/http_client.dart';

import 'package:dio/dio.dart';


/// 负责“帖子详情”的请求
class PostClient {

  static final String _postDetailPath = "/app/web/index.php?r=forum/postlist&pageSize=25";          //获取帖子详情的路径

  static final Dio _dioClient = DioClient.getInstance();


  static Future getPostDetail(Map query) async {
    var response;
    try {
      response = await _dioClient.post(_postDetailPath, queryParameters: query);
    } on DioError catch(e) {
      if (e.response != null)
        print(e.response.statusCode);
      response = e.response;
    }
    return response;
  }
}