import 'package:flutter/material.dart';
import 'package:flutter_bbs/mvp/model.dart';
import 'package:flutter_bbs/mvp/presenter.dart';
import 'package:flutter_bbs/network/json/bbs_response.dart';
import 'package:flutter_bbs/network/json/user.dart';
import 'package:flutter_bbs/pages/detail/model.dart';
import 'package:flutter_bbs/pages/detail/presenter.dart';
import 'package:flutter_bbs/mvp/view.dart';
import 'package:flutter_bbs/utils/constant.dart' as const_util;
import 'package:flutter_bbs/utils/user_cacahe_util.dart' as user_cache;

class DetailWidget extends StatefulWidget {

  PostPresenterImpl _presenter;
  PostModelImpl _model;
  PostViewImpl _view;

  int topicId;          // 请求时必须传递的参数

  DetailWidget(topid) {
    _presenter = PostPresenterImpl();
    _model = PostModelImpl();
    this.topicId = topid;
  }

  @override
  State<StatefulWidget> createState() {
    _view = PostViewImpl(this.topicId);
    _presenter.bindModel(_model);
    _presenter.bindView(_view);
    _view.setPresenter(_presenter);
    return _view;
  }
}

class PostViewImpl extends State<DetailWidget> implements IBaseView{

  int page;         //记录当前的页数
  int topicId;      //网络请求的参数
  PostPresenterImpl _presenter;
  PostViewImpl(this.topicId);

  PostDetailResponse sourceData;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: toGetNetData(),
      builder: (context, snaphot) {
        //网络加载中
        if (!snaphot.hasData)
          return Center(child: CircularProgressIndicator(),);
        //网络错误
        if (snaphot.data.runtimeType == String)
          return Text('error');
        sourceData = snaphot.data;
        return Container(
          padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 1),
                child: Text('帖子标题 ${topicId}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),),
              ),
              Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(6),
                    child: CircleAvatar(
                      backgroundImage: AssetImage('images/c.jpg'),
                      radius: 28,
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(bottom: 6),
                        child: Text('Username', style: TextStyle(fontSize: 16, color: Colors.black),),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 6),
                        child: Text('PostTime', style: TextStyle(fontSize: 10, color: Colors.grey),),
                      ),
                    ],
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 4),
                padding: EdgeInsets.only(left: 12, right: 10),
                child: Divider(height: 1, color: Colors.blueGrey,),
              ),
              Container(
                padding: EdgeInsets.only(left: 14, right: 10, top: 6, bottom: 6),
                child: Text("content", style: TextStyle(fontSize: 16,),
                  maxLines: 100,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 12, right: 10),
                child: Divider(height: 1, color: Colors.grey,),
              ),
              Container(
                padding: EdgeInsets.only(left: 14, right: 12),
                child: Text("评论", style: TextStyle(fontSize: 16, color: Colors.grey),
                  maxLines: 100,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 12, right: 10),
                child: Divider(height: 1, color: Colors.blueGrey,),
              ),
              Flexible(child: ListView.builder(itemBuilder: _buildListItem, itemCount: sourceData.list.length,),)
            ],
          ),
        );

      },
    );
  }

  //构建列表项的item
  Widget _buildListItem(context, index) {
    return Container(
      padding: EdgeInsets.only(top: 12, left: 6, right: 6, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            child: CircleAvatar(backgroundImage: AssetImage('images/c.jpg'), radius: 24,),
          ),
          Flexible(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 4, bottom: 2, right: 16),
                      child: Text('Username', style: TextStyle(fontSize: 20,),),
                    ),
                    Text('Layer Number ${index}', style: TextStyle(fontSize: 12, color: Colors.grey),)
                  ],
                ),
                Container(
                    padding: EdgeInsets.only(left: 4, bottom: 2),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Time', style: TextStyle(fontSize: 14, color: Colors.grey)),
                    )
                ),
                Container(
                    decoration: BoxDecoration(border: Border(left: BorderSide(color: Colors.lightBlueAccent, width: 2))),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Reply', style: TextStyle(fontSize: 16, color: Colors.grey), maxLines: 3, softWrap: true, overflow: TextOverflow.ellipsis,),
                    )
                ),
                Container(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Content', style: TextStyle(fontSize: 16, color: Colors.black), maxLines: 20, softWrap: true, overflow: TextOverflow.ellipsis,),
                  ),
                  padding: EdgeInsets.only(bottom: 6, top: 6),
                ),
                Align(
                  child: FlatButton(onPressed: null, child: Text('回复', style: TextStyle(color: Colors.blue),)),
                  alignment: Alignment.centerRight,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  bindData(sourcedata, type) {
    return null;
  }

  @override
  IBasePresenter<IBaseView, IBaseModel> get presenter => _presenter;

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
  toGetNetData() async{
    User finalUser = await user_cache.finalUser();
    return presenter.loadNetData(query: {
      'accessToken' : finalUser.token,
      'accessSecret' : finalUser.secret,
      'apphash' : await user_cache.getAppHash(),
      'topicId' : topicId,
      'page' : page
    });
  }

  @override
  toRefresh() {
    return null;
  }
}