
import 'package:flutter_bbs/mvp/model.dart';
import 'package:flutter_bbs/network/clients/client_friend.dart';
import 'package:flutter_bbs/utils/constant.dart' as const_util;

class FriendModelImpl extends IBaseModel {
  @override
  Future onLoadMoreData({String type, Map<String, dynamic> query}) async{
    var result;
    switch (type) {
      case const_util.friend_published:
        result = await FriendClient.getFriendPublished(query);
        break;
    }
    print("this is model end");
    return result;
  }

  @override
  Future onLoadNetData({String type, Map<String, dynamic> query}) async{
    var result;
    switch (type) {
      case const_util.friend_published:
        result = await FriendClient.getFriendPublished(query);
        break;
      case const_util.friend_infor:
        result = await FriendClient.getFriendInfo(query);
        break;
    }
    return result;
  }

  @override
  Future onRefresh({String type, Map<String, dynamic> query}) {

    return null;
  }

}