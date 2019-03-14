import 'package:flutter_bbs/mvp/model.dart';
import 'package:flutter_bbs/network/clients/client_message.dart';
import 'package:flutter_bbs/utils/constant.dart' as ConstUtil;

///created by sgh     2019-3-12
/// 消息界面中model的实现类
class MsgModelImpl extends IBaseModel {
  @override
  Future onLoadMoreData({String type, Map<String, dynamic> query}) {
    return null;
  }

  @override
  Future onLoadNetData({String type, Map<String, dynamic> query}) async{
    var result;
    switch (type) {
      case ConstUtil.MESSAGE_PMSE:
        result = MsgClient.getPostMsg(query);
        break;
      case ConstUtil.MESSAGE_REPLY:
        break;
      case ConstUtil.MESSAGE_ATME:
        break;
      default:
        break;
    }
    return result;
  }

  @override
  Future onRefresh({String type, Map<String, dynamic> query}) {
    return null;
  }

}