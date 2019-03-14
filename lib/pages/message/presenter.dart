import 'dart:convert' as convert;
import 'package:flutter_bbs/utils/constant.dart' as ConstUtil;
import 'package:dio/dio.dart';
import 'package:flutter_bbs/mvp/presenter.dart';
import 'package:flutter_bbs/network/json/message.dart';

///ceated by sgh     2019-3-12
/// * 消息界面中的Presenter的实现类
class MsgPresenterImpl extends IBasePresenter {
  @override
  loadMoreNetData({String type, Map<String, dynamic> query}) {
    return null;
  }

  @override
  Future loadNetData({String type, Map<String, dynamic> query}) async{
    Response response = await mModel.onLoadNetData(type: type, query: query);
    if (response.statusCode == 200) {
      switch (type) {
        case ConstUtil.MESSAGE_PMSE:
          MsgRespListPmse result = _decodeResponse(response.data);
          return result;
        case ConstUtil.MESSAGE_ATME:
          break;
        case ConstUtil.MESSAGE_REPLY:
          break;
        case ConstUtil.MESSAGE_SYSTEM:
          break;
      }
    }
    mView.showToast(response.statusCode);
    return 'error';
  }

  @override
  refresh({String type, Map<String, dynamic> query}) {
    return null;
  }

}

MsgRespListPmse _decodeResponse(response) {
return MsgRespListPmse.fromJson(convert.jsonDecode(response));
}