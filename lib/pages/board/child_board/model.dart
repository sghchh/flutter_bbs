
import 'package:flutter_bbs/mvp/model.dart';
import 'package:flutter_bbs/network/clients/client_board.dart';
import 'package:flutter_bbs/utils/constant.dart' as const_util;

class BoardChildPostModelImpl extends IBaseModel implements IMainModel {

  @override
  Future onLoadMoreData({String type, Map<String, dynamic> query}) async {
    return await BoardClient.getBoardPost(query);
  }

  @override
  Future onLoadNetData({String type, Map<String, dynamic> query}) async {
    return await BoardClient.getBoardPost(query);
  }

  @override
  Future onRefresh({String type, Map<String, dynamic> query}) async {
    return await BoardClient.getBoardPost(query);
  }

}