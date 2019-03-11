import 'dart:convert';

import 'package:flutter_bbs/network/json/post.dart';

class BBSResponse<T> {
  int rs;
  String errcode;
  int page;
  int hasNext;
  int totalNum;
  _Head head;
  T list;

  BBSResponse({this.rs, this.errcode, this.page, this.hasNext, this.totalNum, this.head, this.list});
}

class _Head {
  String errCode;
  String errInfo;

  _Head({this.errCode, this.errInfo});

  _Head.fromJson(Map<String, dynamic> json)
      : errInfo = json['errInfo'],
        errCode = json['errCode'];
}

/**
 * Home界面“最新发表”“最新回复”“今日热点”
 * 返回的Json
 */
class BBSRepListPost {
  int rs;
  String errcode;
  int page;
  int hasNext;
  int totalNum;
  _Head head;
  List<Post> list;
  BBSRepListPost({this.rs, this.errcode, this.page, this.hasNext, this.totalNum, this.head, this.list});

  BBSRepListPost.fromJson(Map<String, dynamic> json)
      : rs = json['rs'],
        errcode = json['errcode'],
        page = json['page'],
        hasNext = json['hasNext'],
        totalNum = json['totalNum'],
        head = _Head.fromJson(json['head']),
        list = json['list'].map((value) => Post.fromJson(value));

}
