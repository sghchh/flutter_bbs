
import 'package:dio/dio.dart';
import 'package:flutter_bbs/mvp/model.dart';
import 'package:flutter_bbs/network/clients/client_board.dart';
import 'package:flutter_bbs/network/json/forum.dart';

class BoardModelImpl extends IBaseModel {

  @override
  Future onLoadMoreData({String type, Map<String, dynamic> query}) {
  }

  @override
  Future<Response> onLoadNetData({String type, Map<String, dynamic> query}) async{
    var response = await BoardClient.getForumList(query: query);
    return response;
  }

  @override
  Future onRefresh({String type, Map<String, dynamic> query}) {
  }

}