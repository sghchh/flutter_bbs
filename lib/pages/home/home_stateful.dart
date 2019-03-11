import 'package:flutter/material.dart';
import 'package:flutter_bbs/mvp/model.dart';
import 'package:flutter_bbs/mvp/presenter.dart';
import 'package:flutter_bbs/mvp/view.dart';
import 'package:flutter_bbs/constant.dart' as ConstUtil;


/**
 * created by sgh    2019-02-28
 * Home中显示List的StatefulWidget
 */
class HomeWidget extends StatefulWidget {

  IBasePresenter _presenter;    //创建——HomeState时传递的Presenter对象
  //表示该HomeWidget显示的List的内容，tap值为"最新回复""最新发表""今日热门"三者之一
  String tap = '最新回复';
  List _data;     //页面展示的数据源
  HomeWidget({this.tap, presenter}){
    this._presenter = presenter;
  }

  @override
  State<StatefulWidget> createState() {
    var state = _HomeState();
    state.setPresenter(this._presenter);
    return state;
  }
}

/**
 * _HomeState为View层的实现类
 */
class _HomeState extends State<HomeWidget> implements IBaseView {

  IBasePresenter _presenter;   //用啦发起网络请求的Presenter

  List data;          //展示的数据源


  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Navigator.of(context, rootNavigator: true).pushNamed('detail/detailPage'),
            child: Container(
              padding: const EdgeInsets.only(top: 6, bottom: 6, left: 10, right: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 2.0, color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
              margin: const EdgeInsets.only(left: 2, right: 2, top: 2, bottom: 2),
              child: Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(right: 10, bottom: 20),
                        child: CircleAvatar(
                          backgroundImage: AssetImage('images/c.jpg'),
                          radius: 30,
                        ),
                      )
                    ],
                  ),
                  Flexible(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text('Username', style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                          Text('BoardId',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                            textAlign: TextAlign.right,),
                        ],
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 2),
                          child: Text('PostTime',
                              style: TextStyle(fontSize: 12, color: Colors.grey))
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 4, bottom: 4),
                          child: Text('Content',
                            style: TextStyle(fontSize: 18, color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            softWrap: true,)
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Icon(Icons.remove_red_eye, size: 18, color: Colors.grey,),
                          Container(
                            margin: const EdgeInsets.only(left: 6, right: 6),
                            child: Text('查看数',
                                style: TextStyle(fontSize: 12, color: Colors.grey)),
                          ),
                          Icon(Icons.chat_bubble_outline, size: 18,
                            color: Colors.grey,),
                          Container(
                            margin: const EdgeInsets.only(left: 6),
                            child: Text('回复数',
                                style: TextStyle(fontSize: 12, color: Colors.grey)),
                          ),
                        ],
                      )
                    ],
                  ),)
                ],
              ),
            ),
          );
        },
        itemCount: 3,
      ),
    );
  }

  Future<Null> onRefresh() async{
    print("=========this is onRefresh==========");
    await Future.delayed(Duration(seconds: 2));
    return null;
  }

  @override
  IBasePresenter<IBaseView, IBaseModel> get mPresenter => _presenter;

  @override
  void setPresenter(presenter) {
    this._presenter = presenter;
  }

  @override
  void showToast(content) {
  }

  @override
  toGetMoreNetData() {

    return null;
  }

  @override
  toGetNetData() {
    _presenter.loadNetData(type: null, query :{ 'apphash' : null, 'accountSecret' : null, 'accountToken' : null});
  }

  @override
  toRefresh() {

    return null;
  }

  @override
  bindData(sourcedata) {
    // TODO: implement bindData
    return null;
  }

}