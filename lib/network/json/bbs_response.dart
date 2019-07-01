
import 'package:flutter_bbs/network/json/board.dart';
import 'package:flutter_bbs/network/json/post.dart';
import 'package:flutter_bbs/network/json/reply.dart';
import 'package:flutter_bbs/network/json/user.dart';

class BBSResponse<T> {
  int rs;
  String errcode;
  int page;
  int has_next;
  int total_num;
  Head head;
  T list;

  BBSResponse({this.rs, this.errcode, this.page, this.has_next, this.total_num, this.head, this.list});

  BBSResponse.fromJson(Map<String, dynamic> json)
      : this.rs = json['rs'],
        this.errcode = json['errcode'],
        this.page = json['page'],
        this.has_next = json['hasNext'],
        this.total_num = json['total_num'],
        this.head = Head.fromJson(json['head']);
}

/// 获取帖子列表的返回 JSON中处于第一级中的head参数的类型
class Head {
  String errCode;     // 本次请求的状态码
  String errInfo;     // 本次请求结果的中文描述

  Head({this.errCode, this.errInfo});

  Head.fromJson(Map<String, dynamic> json)
      : errInfo = json['errInfo'],
        errCode = json['errCode'];
}

///Home界面“最新发表”“最新回复”“今日热点”
/// 也是各个板块获取发表消息的
/// 返回的Json
class BBSRepListPost {
  int has_next;      // 是否含有下一页，0代表没有，1代表有
  Head head;        // 封装了状态码、错误信息
  List<Post> list;    // 每一个item代表了已发的帖子
  BBSRepListPost({this.has_next, this.head, this.list});

  BBSRepListPost.fromJson(Map<String, dynamic> json)
      : this.has_next = json['has_next'],
        head = Head.fromJson(json['head']){

    if (json['list'] == null) {
      list = null;
    } else {
      var result = <Post>[];
      for (int i = 0; i < json['list'].length; i++) {
        var item = Post.fromJson(json['list'][i]);
        result.add(item);
      }
      this.list = result;
    }
  }
}

/// 用户信息界面返回 已发帖子 的最终json
class BBSRespListUserPub {
  int page;
  int has_next;
  Head head;
  List<UserPublish> list;

  BBSRespListUserPub(this.page, this.has_next, this.head, this.list);

  BBSRespListUserPub.fromJson(Map<String, dynamic> json)
      : this.page = json['page'],
        this.has_next = json['has_next'],
        this.head = Head.fromJson(json['head']) {


    if (json['list'] != null) {
      var result = <UserPublish>[];
      for (int i = 0; i < json['list'].length; i++) {
        var item = UserPublish.fromJson(json['list'][i]);
        result.add(item);
      }
      this.list = result;
    }
    }

}

/// 帖子详情 返回的json
class PostDetailResponse {
  int page;         // 当前的页数
  int has_next;     // 是否含有下一页，0为无，1为有
  Head head;      // 封装了状态码、错误信息
  List<ReplyDetail> list;     // 代表评论区所有的评论
  PostDetail topic;           // 代表楼主的帖子详情

  PostDetailResponse.fromJson(Map<String, dynamic> json)
      : this.page = json['page'] != null ? json['page'] : null,
        this.has_next = json['has_next'] != null ? json['has_next'] : null,
        this.head = Head.fromJson(json['head']),
        this.topic = json['page'] == 1 ? PostDetail.fromJson(json['topic']) : null {


    if (json['list'] != null) {
      var result = <ReplyDetail>[];
      for (int i = 0; i < json['list'].length; i++) {
        var item = ReplyDetail.fromJson(json['list'][i]);
        result.add(item);
      }
      this.list = result;
    }

  }
}

/// 获取某一个板块的主题的信息的json
/// 例如获取就业创业下的主题的信息
class ChildBoardInfoResponse {
  Head head;      // 封装了状态码和错误信息
  List<Board> list;     // 每一个item代表一个主题的信息

  ChildBoardInfoResponse.fromJson(Map<String, dynamic> json)
      : this.head = Head.fromJson(json['head']) {


    if (json['list'] != null) {
      var result = <Board>[];
      for (int i = 0; i < json['list'].length; i++) {
        var item = Board.fromJson(json['list'][i]);
        result.add(item);
      }
      this.list = result;
    }
    }
}
