import 'package:flutter/material.dart';
import 'package:flutter_bbs/dialog.dart';
import 'package:flutter_bbs/mvp/model.dart';
import 'package:flutter_bbs/mvp/presenter.dart';
import 'package:flutter_bbs/mvp/view.dart';
import 'package:flutter_bbs/network/json/bbs_response.dart';
import 'package:flutter_bbs/network/json/publish.dart';
import 'package:flutter_bbs/network/json/user.dart';
import 'package:flutter_bbs/pages/edit/model.dart';
import 'package:flutter_bbs/pages/edit/presenter.dart';
import 'package:flutter_bbs/return_type.dart';
import 'package:flutter_bbs/utils/constant.dart' as const_util;
import 'package:flutter_bbs/utils/user_cacahe_util.dart' as user_cache;

class CommentWidget extends StatefulWidget {
  int topicId;
  int replyId;
  CommentWidget(this.topicId, {this.replyId})
      : this.presenter = EditPresenterImpl(),
        this.model = EditModelImpl();
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

class CommentState extends State<CommentWidget> implements IBaseView {
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
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        buttonColor: Colors.lightBlueAccent,
      ),
      home: Scaffold(
        appBar: PreferredSize(
            child: AppBar(
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                  ),
                  onPressed: () => Navigator.of(context).pop()),
              iconTheme: IconThemeData(color: Colors.white, size: 24),
              title: Text(
                "编辑内容",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.send,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  onPressed: finalComment,
                )
              ],
            ),
            preferredSize:
                Size.fromHeight(MediaQuery.of(context).size.height * 0.08)),
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

  finalComment() {
    var dialog = ShowAwait<ReturnType>(
      _comment(),
    );
    showDialog<ReturnType>(context: context, builder: (c) => dialog)
        .then((onvalue) {
      if (onvalue.type == 1) {
        //Navigator.of(context).pop();
        showToast("发表成功~");
      } else {
        showToast(onvalue.content);
      }
    });
  }

  Future<ReturnType> _comment() async {
    User finalUser = await user_cache.finalUser();
    if (controller.text.trim() == null || controller.text.trim() == "") {
      return ReturnType(0, content: "内容不能为空");
    }
    PublishContent contents = PublishContent(0, controller.text);
    PublishInfo info = PublishInfo(
        replyId: replyId,
        tid: topicId,
        isQuote: topicId == null ? 0 : 1,
        content: contents.toString());
    PublishBody body = PublishBody(info);
    PublishJson json = PublishJson(body);
    var response =
        await (presenter as EditPresenterImpl).comment(<String, dynamic>{
      'apphash': await user_cache.getAppHash(),
      'accessToken': finalUser.token,
      'accessSecret': finalUser.secret,
      'json': json.toString(),
      'act': 'reply'
    });
    return response;
  }

  @override
  IBasePresenter<IBaseView, IBaseModel> get presenter => _presenter;
}
