import 'package:flutter/material.dart';
import 'package:flutter_bbs/mvp/model.dart';
import 'package:flutter_bbs/mvp/presenter.dart';
import 'package:flutter_bbs/mvp/view.dart';
import 'package:flutter_bbs/network/json/publish.dart';
import 'package:flutter_bbs/network/json/user.dart';
import 'package:flutter_bbs/pages/edit/model.dart';
import 'package:flutter_bbs/pages/edit/presenter.dart';
import 'package:flutter_bbs/utils/constant.dart' as const_util;
import 'package:flutter_bbs/utils/user_cacahe_util.dart' as user_cache;

class CommentWidget extends StatefulWidget {
  int topicId;
  int replyId;
  CommentWidget(this.topicId, {this.replyId}) : this.presenter = EditPresenterImpl(), this.model = EditModelImpl();
  EditPresenterImpl presenter;
  EditModelImpl model;
  CommentState view;
  @override
  State<StatefulWidget> createState() {
    view = CommentState(this.topicId, replyId: replyId);
    presenter.bindModel(model);
    presenter.bindView(view);
    view.setPresenter(presenter);
    return view;
  }
}

class CommentState extends State<CommentWidget>  implements IBaseView{
  TextEditingController controller = TextEditingController();
  EditPresenterImpl _presenter;
  int topicId;
  int replyId;

  CommentState(topid, {this.replyId}) {
    this.topicId = topid;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        buttonColor: Colors.lightBlueAccent,
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
              ),
              onPressed: () => Navigator.of(context).pop()),
          iconTheme: IconThemeData(color: Colors.white, size: 24),
          title: Text(
            "编辑内容",
            style: TextStyle(fontSize: 24, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[IconButton(
            icon: Icon(Icons.send, color: Colors.white, size: 30.0,),
            onPressed: comment,)
          ],
        ),
        body: Container(
          margin: EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 5),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
                hintText: "内容",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                border: InputBorder.none),
            maxLines: 10,
            cursorWidth: 0,
          ),
        ),
      ),
    );
  }

  @override
  bindData(sourcedata, type) {
    return null;
  }

  @override
  void setPresenter(presenter) {
    this._presenter = presenter;
  }

  @override
  void showToast(content) {
    var snack = SnackBar(
      content: Text("${content}"),
      duration: Duration(milliseconds: 1500),
    );
    Scaffold.of(context).showSnackBar(snack);
  }

  @override
  toGetMoreNetData() {
    return null;
  }

  @override
  toGetNetData() {
    return null;
  }

  @override
  toRefresh() {
    return null;
  }

  comment() async {
    User finalUser = await user_cache.finalUser();
    if (controller.text.trim() == null || controller.text.trim() == ""){
      showToast("内容不能为空");
      return;
    }
    PublishContent contents = PublishContent(0, controller.text);
    PublishInfo info = PublishInfo(
        replyId: replyId,
        tid: topicId,
        isQuote: topicId == null ? 0 : 1,
        content: contents.toString());
    PublishBody body = PublishBody(info);
    PublishJson json = PublishJson(body);
    (presenter as EditPresenterImpl).comment(<String, dynamic>{
      'apphash' : await user_cache.getAppHash(),
      'accessToken' : finalUser.token,
      'accessSecret' : finalUser.secret,
      'json' : json.toString(),
      'act' : 'reply'
    });
    Navigator.of(context).pop();
  }

  @override
  IBasePresenter<IBaseView, IBaseModel> get presenter => _presenter;
}

