import 'package:flutter_bbs/mvp/model.dart';
import 'package:flutter_bbs/mvp/presenter.dart';
import 'package:flutter_bbs/mvp/view.dart';
import 'dart:convert' as convert;
import 'package:flutter_bbs/network/json/post.dart';
import 'package:flutter_bbs/network/json/publish.dart';
import 'package:flutter_bbs/network/json/user.dart';
import 'package:flutter_bbs/pages/edit/edit_menu_item.dart' as menu_item;
import 'package:flutter_bbs/utils/constant.dart' as const_util;
import 'package:flutter_bbs/utils/user_cacahe_util.dart' as user_cache;

import 'package:flutter/material.dart';
import 'package:flutter_bbs/pages/edit/model.dart';
import 'package:flutter_bbs/pages/edit/presenter.dart';

///created by sgh    2019-02-28
/// 编辑帖子的界面的底部选择板块的UI
class EditWidget extends StatefulWidget {
  EditPresenterImpl _presenter;
  EditModelImpl _model;
  _EditViewImpl _view;

  EditWidget()
      : this._presenter = EditPresenterImpl(),
        this._model = EditModelImpl();

  @override
  State<StatefulWidget> createState() {
    _view = _EditViewImpl();
    _presenter.bindModel(_model);
    _presenter.bindView(_view);
    _view.setPresenter(_presenter);
    return _view;
  }
}

class _EditViewImpl extends State<EditWidget> implements IBaseView {
  EditPresenterImpl _presenter;
  var typeValue; //注意该值要为DropdownButton的value属性，所以不能赋初始值
  var boardValue; //注意该值要为DropdownButton的value属性，所以不能赋初始值
  var childBoard; //注意该值要为DropdownButton的value属性，所以不能赋初始值
  List<ClassificationType> classificationTypeList; //某一板块分类的数据

  final TextEditingController controller1 = TextEditingController(); //标题输入框的控制器
  final TextEditingController controller2 = TextEditingController(); //内容输入框的控制器

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 5),
            child: TextField(
              controller: controller1,
              decoration: InputDecoration(
                  hintText: "标题",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 16)),
              maxLines: 3,
              cursorWidth: 0,
            ),
          ),
          //Divider(color: Colors.grey,),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 5),
              child: TextField(
                controller: controller2,
                decoration: InputDecoration(
                    hintText: "内容",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                    border: InputBorder.none),
                maxLines: 10,
                cursorWidth: 0,
              ),
            ),
          ),
          //Divider(color: Colors.grey,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: EdgeInsets.all(4),
                  child: DropdownButton<String>(
                    items: menu_item.typeMenuItem,
                    onChanged: (value) {
                      setState(() {
                        typeValue = value;
                      });
                    },
                    hint: Text('选择分类',
                        style: TextStyle(color: Colors.grey, fontSize: 10)),
                    value: typeValue,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: typeValue == null
                    ? Container(
                        width: 0,
                        height: 0,
                      )
                    : Container(
                        padding: EdgeInsets.all(4),
                        child: DropdownButton<int>(
                          items: menu_item.getMenuItem(typeValue),
                          onChanged: (value) {
                            setState(() {
                              boardValue = value;
                            });
                            toRefresh();
                          },
                          hint: Text('板块分类',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 10)),
                          value: boardValue,
                        ),
                      ),
              ),
              classificationTypeList == null
                  ? Container(
                      width: 0,
                      height: 0,
                    )
                  : Container(
                      padding: EdgeInsets.all(4),
                      child: DropdownButton<int>(
                        items:
                            menu_item.getChildMenuItem(classificationTypeList),
                        onChanged: (value) {
                          setState(() {
                            childBoard = value;
                          });
                        },
                        hint: Text('子板块',
                            style: TextStyle(color: Colors.grey, fontSize: 10)),
                        value: childBoard,
                      ),
                    ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.only(left: 16, right: 5),
                    child: IconButton(
                      icon: Icon(Icons.send, color: Colors.blue),
                      onPressed: publish,
                      iconSize: 36,
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  bindData(sourcedata, type) {
    setState(() {
      this.classificationTypeList = sourcedata.classificationType_list;
      ClassificationType type = ClassificationType("无", -1);
      if (classificationTypeList == null) {
        this.classificationTypeList = <ClassificationType>[];
        this.classificationTypeList.add(type);
        return;
      }
      this.classificationTypeList.add(type);
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
    var snack = SnackBar(
      content: Text("${content}"),
      duration: Duration(milliseconds: 1500),
    );
    Scaffold.of(context).showSnackBar(snack);
  }

  @override
  toGetMoreNetData() async {}

  @override
  toGetNetData() async {
    User finalUser = await user_cache.finalUser();
    return presenter.loadNetData(query: {
      'accessToken': finalUser.token,
      'accessSecret': finalUser.secret,
      'apphash': await user_cache.getAppHash(),
      'sdkVersion': const_util.sdkVersion,
      'boardId': boardValue
    });
  }

  @override
  toRefresh() async {
    User finalUser = await user_cache.finalUser();
    presenter.refresh(query: {
      'accessToken': finalUser.token,
      'accessSecret': finalUser.secret,
      'apphash': await user_cache.getAppHash(),
      'sdkVersion': const_util.sdkVersion,
      'boardId': boardValue
    });
  }

  publish() async{
    User finalUser = await user_cache.finalUser();
    var title = controller1.text.trim();
    var content = controller2.text.trim();
    if (title == "" || title == null || content == "" || content == null) {
      showToast('标题或者内容不能为空');
      return;
    }
    if (typeValue == null || boardValue == null || childBoard == null){
      showToast("请选择板块");
      return;
    }
    PublishContent contents = PublishContent(0, content);
    PublishInfo info = PublishInfo(
        title: title,
        fid: boardValue,
        typeId: (childBoard == -1 || childBoard == null) ? null : childBoard,
        content: contents.toString());
    PublishBody body = PublishBody(info);
    PublishJson json = PublishJson(body);
    (presenter as EditPresenterImpl).publish(<String, dynamic>{
      'apphash' : await user_cache.getAppHash(),
      'accessToken' : finalUser.token,
      'accessSecret' : finalUser.secret,
      'act' : "new",
      'json' : json.toString()
    });
    Navigator.of(context).pop();
  }
}
