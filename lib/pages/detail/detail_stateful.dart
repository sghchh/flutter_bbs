import 'package:flutter/material.dart';
import 'package:flutter_bbs/mvp/model.dart';
import 'package:flutter_bbs/mvp/presenter.dart';
import 'package:flutter_bbs/network/json/bbs_response.dart';
import 'package:flutter_bbs/network/json/post.dart';
import 'package:flutter_bbs/network/json/reply.dart';
import 'package:flutter_bbs/network/json/user.dart';
import 'package:flutter_bbs/pages/board/board_map.dart';
import 'package:flutter_bbs/pages/detail/model.dart';
import 'package:flutter_bbs/pages/detail/presenter.dart';
import 'package:flutter_bbs/mvp/view.dart';
import 'package:flutter_bbs/utils/constant.dart' as const_util;
import 'package:flutter_bbs/utils/user_cacahe_util.dart' as user_cache;
import 'package:flutter_bbs/utils/regexp_util.dart' as regexp_util;


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

  ScrollController _scrollController;       //用来控制上拉加载
  int page = 1;         //记录当前的页数
  int topicId;      //网络请求的参数
  PostPresenterImpl _presenter;

  PostViewImpl(topicId) {
    this.topicId = topicId;
    _scrollController = ScrollController();
  }

  PostDetail topic;           //楼主的帖子的详情
  List<ReplyDetail> comments;      //评论区 的内容
  bool hasMore = true;       //表示评论区是否还有数据
  bool isLoading = false;        //表示是否正在加载数据


  @override
  void initState() {
    super.initState();
    _scrollController.addListener((){
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (!isLoading && hasMore) {
          toGetMoreNetData();
          setState(() {
            isLoading = true;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (this.topic == null) {
      return FutureBuilder(
        future: toGetNetData(),
        builder: (context, snaphot) {
          //网络加载中
          if (!snaphot.hasData)
            return Center(child: CircularProgressIndicator(),);
          //网络错误
          if (snaphot.data.runtimeType == String)
            return Text('error');

          // 成功获取网络数据
          topic = snaphot.data.topic;
          comments = snaphot.data.list;
          hasMore = snaphot.data.has_next == 0 ? false : true;
          return _buildNew();
        },
      );
    }
    return _buildNew();
  }

  Widget _buildNew () {
    return CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate(_buildTopic, childCount: topic.content.length + 1),
        ),
        SliverPersistentHeader(
          delegate: SliverAppBarDelegate(minHeight: 20, maxHeight: 40,
              child: Card(child: Container(
                padding: EdgeInsets.only(left: 12, top: 1, bottom: 1),
                child: Text("评论", textAlign: TextAlign.center,textScaleFactor: 1.4, style: TextStyle(color: Colors.grey),),
              ),)
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(_buildCommentsItem, childCount: comments.length + 1),
        )
      ],
    );
  }

  // 构建发帖人及其帖子内容的widget
  Widget _buildTopic(context, index) {
    // 构建头像等
    if (index == 0) {
      return Container(
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 1),
              child: Text(topic.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),),
            ),
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(6),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(topic.icon),
                    radius: 24,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(bottom: 6),
                      child: Text(topic.user_nick_name, style: TextStyle(fontSize: 16, color: Colors.blueGrey),),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 6),
                      child: Text(topic.create_date, style: TextStyle(fontSize: 10, color: Colors.grey),),
                    ),
                  ],
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 4),
              //padding: EdgeInsets.only(left: 12, right: 10),
              child: Divider(height: 1, color: Colors.blueGrey,),
            ),
            //ListView.builder(shrinkWrap: true, itemBuilder: _buildHeadContent, itemCount: sourceData.topic.content.length,)
          ],
        ),
      );
    }

    // 构建帖子内容
    if ( topic.content[index - 1].type != 1) {
      return Container(
        padding: EdgeInsets.only(left: 14, right: 10, top: 6, bottom: 6),
        child: Wrap(
          spacing: 2, //主轴上子控件的间距
          runSpacing: 5, //交叉轴上子控件之间的间距
          crossAxisAlignment: WrapCrossAlignment.center,
          children: _buildPostContent(topic.content[index - 1].infor), //要显示的子控件集合
        )
      );
    }
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5),
      child: Align(
        alignment: Alignment.center,
        child: Image.network(topic.content[index - 1].infor, width: 300, height: 160,),
      ),
    );

  }

  //构建回复列表项的item
  Widget _buildCommentsItem(context, index) {
    if (index == comments.length){
      return _buildLoadMore();
    }
    return Card(
      margin: EdgeInsets.only(top: 5, bottom: 5, left: 6, right: 6),
      child: Container(
        padding: EdgeInsets.only(top: 12, left: 6, right: 6, bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8),
              child: CircleAvatar(backgroundImage: NetworkImage(comments[index].icon), radius: 24,),
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
                        child: Text(comments[index].reply_name, style: TextStyle(fontSize: 15, color: Colors.blue),),
                      ),
                      Text('${index} 楼', style: TextStyle(fontSize: 12, color: Colors.grey),)
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 4, bottom: 2),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(comments[index].posts_date, style: TextStyle(fontSize: 12, color: Colors.grey)),
                      )
                  ),

                  // 根据是否是回复来显示内容
                  comments[index].quote_content != "" ? Container(
                    padding: EdgeInsets.only(left: 5),
                    decoration: BoxDecoration(border: Border(left: BorderSide(color: Colors.lightBlueAccent, width: 2))),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(comments[index].quote_content, style: TextStyle(fontSize: 12, color: Colors.grey), maxLines: 3, softWrap: true, overflow: TextOverflow.ellipsis,),
                    ),
                  ) : Container(width: 0, height: 0,),
                  Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Wrap(
                        spacing: 2, //主轴上子控件的间距
                        runSpacing: 5, //交叉轴上子控件之间的间距
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: _buildPostContent(comments[index].reply_content[0].infor), //要显示的子控件集合
                      )
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
      ),
    );
  }

  //构建加载更多的widget
  Widget _buildLoadMore() {
    if (isLoading) {
      return Container(
        padding: EdgeInsets.only(top: 4, bottom: 4),
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 6),
                child:  CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ),
              Text("正在加载数据...", style: TextStyle(color: Colors.lightBlueAccent),)
            ],
          ),
        ),
      );
    }
    if (!hasMore) {
      return Container(
        padding: EdgeInsets.only(top: 4, bottom: 4),
        child: Center(
          child: Text("没有更多了~~", style: TextStyle(color: Colors.blueGrey)),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.only(top: 4, bottom: 4),
      child: Center(
        child: Text("上拉加载更多...", style: TextStyle(color: Colors.blueGrey)),
      ),
    );
  }

  @override
  bindData(sourcedata, type) {
    setState(() {
      if ( type == const_util.loadMore ) {
        page++;
        this.comments.addAll(sourcedata.list);
      } else if ( type == const_util.refresh ) {
        page = 1;
        this.comments = sourcedata.list;
      }
      hasMore = sourcedata.has_next == 0 ? false : true;
      isLoading = false;
    });
  }

  @override
  IBasePresenter<IBaseView, IBaseModel> get presenter => _presenter;

  @override
  void setPresenter(presenter) {
    this._presenter = presenter;
  }

  @override
  void showToast(content) {
    var snackBar = SnackBar(
      content: Text("${content}"),
      duration: Duration(milliseconds: 1500),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  toGetMoreNetData() async{
    User finalUser = await user_cache.finalUser();
    return presenter.loadMoreNetData(query: {
      'accessToken' : finalUser.token,
      'accessSecret' : finalUser.secret,
      'apphash' : await user_cache.getAppHash(),
      'topicId' : topicId,
      'page' : page + 1
    });
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

// 构建回复内容和帖子内容的布局
List<Widget> _buildPostContent (String info) {
  List<regexp_util.RegExpType> source = regexp_util.getContentDetail(info);
  var result = <Widget>[];
  for ( int i = 0 ; i  < source.length; i++) {
    regexp_util.RegExpType type = source[i];
    if (type.type == regexp_util.content_text) {
      var item = Text(type.content, style: TextStyle(fontSize: 14, color: Colors.black), softWrap: true,);
      result.add(item);
    } else {
      var item = Image.network(type.content, width: 50, height: 50,);
      result.add(item);
    }
  }
  return result;
}