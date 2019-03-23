
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

class Head {
  String errCode;
  String errInfo;

  Head({this.errCode, this.errInfo});

  Head.fromJson(Map<String, dynamic> json)
      : errInfo = json['errInfo'],
        errCode = json['errCode'];
}

///Home界面“最新发表”“最新回复”“今日热点”
/// 也是各个板块获取发表消息的
/// 返回的Json
class BBSRepListPost {
  int rs;
  String errcode;
  int page;
  int has_next;
  int total_num;
  Head head;
  List<Post> list;
  List<ClassificationType> classificationType_list;
  BBSRepListPost({this.rs, this.errcode, this.page, this.has_next, this.total_num, this.head, this.list});

  BBSRepListPost.fromJson(Map<String, dynamic> json)
      : rs = json['rs'],
        errcode = json['errcode'],
        this.page = json['page'],
        this.has_next = json['has_next'],
        this.total_num = json['total_num'],
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
    if (json['classificationType_list'] != null) {
      var res = <ClassificationType>[];
      for (int i = 0; i < json['classificationType_list'].length; i++) {
        var item = ClassificationType.fromJson(json['classificationType_list'][i]);
        res.add(item);
        this.classificationType_list = res;
      }
    }
  }
}

/// 用户信息界面返回已发帖子的json
class BBSRespListUserPub {
  int rs;
  String errcode;
  int page;
  int has_next;
  int total_num;
  Head head;
  List<UserPublish> list;

  BBSRespListUserPub(this.rs, this.errcode, this.page, this.has_next,
      this.total_num, this.head, this.list);

  BBSRespListUserPub.fromJson(Map<String, dynamic> json)
      : this.rs = json['rs'],
        this.errcode = json['errcode'],
        this.page = json['page'],
        this.has_next = json['has_next'],
        this.total_num = json['total_num'],
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

/// 帖子详情返回的json
class PostDetailResponse {
  int rs;
  String errcode;
  int page;
  int has_next;
  int total_num;
  Head head;
  List<ReplyDetail> list;
  PostDetail topic;           //只有在请求的时候page为1的时候才会有该字段

  PostDetailResponse.fromJson(Map<String, dynamic> json)
      : this.rs = json['rs'],
        this.errcode = json['errcode'],
        this.page = json['page'] != null ? json['page'] : null,
        this.has_next = json['has_next'] != null ? json['has_next'] : null,
        this.total_num = json['total_num'] != null ? json['total_num'] : null,
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

/// 获取某一个板块的子版块的信息的json
/// 例如获取就业创业下的子版块的信息
class ChildBoardInfoResponse {
  int rs;
  String errcode;
  Head head;
  List<Board> list;     //板块信息

  ChildBoardInfoResponse.fromJson(Map<String, dynamic> json)
      : this.rs = json['rs'],
        this.errcode = json['errcode'],
        this.head = Head.fromJson(json['head']) {


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
