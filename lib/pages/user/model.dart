
import 'package:flutter_bbs/network/clients/client_user.dart';
import 'package:flutter_bbs/utils/constant.dart' as const_util;
import 'package:flutter_bbs/mvp/model.dart';

import 'package:dio/dio.dart';

class UserModelImpl extends IBaseModel{
  @override
  Future onLoadMoreData({String type, Map<String, dynamic> query}) {
    return null;
  }

  @override
  Future<Response> onLoadNetData({String type, Map<String, dynamic> query}) async {
    var result;
    switch (type) {
      case const_util.user_publish:
        result = await UserClient.getUserPublished(query);
        break;
      case const_util.user_favourite:
        result = await UserClient.getUserFavorite(query);
        break;
      case const_util.user_friends:
        result = await UserClient.getUserFriends(query);
        break;
    }
    return result;
  }

  @override
  Future onRefresh({String type, Map<String, dynamic> query}) {
    return null;
  }

}