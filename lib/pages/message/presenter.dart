
import 'package:flutter_bbs/mvp/presenter.dart';
import 'package:flutter_bbs/network/json/message.dart';

/**
 * ceated by sgh     2019-3-12
 * 消息界面中的Presenter的实现类
 */
class MsgPresenterImpl extends IBasePresenter {
  @override
  loadMoreNetData({String type, Map<String, dynamic> query}) {
    return null;
  }

  @override
  Future<MsgRespListPmse> loadNetData({String type, Map<String, dynamic> query}) async{
    MsgRespListPmse result = await mModel.onLoadNetData(type: type, query: query);
    return result;
  }

  @override
  refresh({String type, Map<String, dynamic> query}) {
    return null;
  }

}