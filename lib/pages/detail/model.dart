import 'package:flutter_bbs/mvp/model.dart';
import 'package:flutter_bbs/network/clients/client_post.dart';

import 'package:dio/dio.dart';

class PostModelImpl extends IBaseModel{
  @override
  Future onLoadMoreData({String type, Map<String, dynamic> query}) {
    return null;
  }

  @override
  Future<Response> onLoadNetData({String type, Map<String, dynamic> query}) async{
    final response = await PostClient.getPostDetail(query);
    return response;
  }

  @override
  Future onRefresh({String type, Map<String, dynamic> query}) {
    return null;
  }

}