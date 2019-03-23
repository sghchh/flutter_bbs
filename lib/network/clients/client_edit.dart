
import 'package:flutter_bbs/network/http_client.dart';

import 'package:dio/dio.dart';

class EditClient {
  static final _boardPostPath = "/app/web/index.php?r=forum/topiclist";     //需要传入boardid来获取
  static final _publishPath = "/app/web/index.php?r=forum/topicadmin";          //发帖时的path
  static final _dioClient = DioClient.getInstance();        //进行网络请求的真实的客户端

  //获取某一个板块下的发帖分类
  static Future getClassificationTypeList(Map query) async {
    var response;
    try {
      response = await _dioClient.post(_boardPostPath, queryParameters: query);
    } on DioError catch(e) {
      if (e.response != null)
        print(e.response.statusCode);
      response = e.response;
    }
    return response;
  }

  // 发帖
  static Future publish(Map query) async {
    Response response;
    try {
      response = await _dioClient.post(_publishPath, data: query);
    } on DioError catch(e) {
      if (e.response != null)
        print(e.response.statusCode);
      response = e.response;
    }
    return response;
  }

}