///created by sgh     2019-3-11
///获取发帖的返回json
/// 目前“今日热点”“最新发表”“最新回复”都会用到该json
/// 不过该json是封装在BBSResponse中的
class Post {
  int board_id;
  String board_name;
  int topic_id;         //该字段在除今日热点的返回数据中出现
  int source_id;      //该字段只在今日热点的返回数据中出现，其值和topic_id相同
  String type;
  String title;
  int user_id;
  String user_nick_name;
  String userAvatar;
  String last_reply_date;
  int vote;
  int hits;
  int replies;

  Post(
      {this.type,
      this.board_id,
      this.board_name,
      this.hits,
      this.last_reply_date,
      this.replies,
      this.source_id,
      this.title,
      this.topic_id,
      this.user_id,
      this.user_nick_name,
      this.userAvatar,
      this.vote});

  Post.fromJson(Map<String, dynamic> jsonSource)
      : this.type = jsonSource['type'],
        this.userAvatar = jsonSource['userAvatar'],
        this.board_id = jsonSource['board_id'],
        this.board_name = jsonSource['board_name'],
        this.hits = jsonSource['hits'],
        this.last_reply_date = jsonSource['last_reply_date'],
        this.replies = jsonSource['replies'],
        this.source_id = jsonSource['source_id'],
        this.title = jsonSource['title'],
        this.topic_id = jsonSource['topic_id'],
        this.user_id = jsonSource['user_id'],
        this.user_nick_name = jsonSource['user_nick_name'],
        this.vote = jsonSource['vote'];
}

/// 获取某一个板块所有发表帖子时
/// 该板块下面的分类标签
class ClassificationType {
  int classificationType_id;
  String classificationType_name;

  ClassificationType(this.classificationType_name, this.classificationType_id);
  ClassificationType.fromJson(Map<String, dynamic> json)
      : this.classificationType_id = json['classificationType_id'],
        this.classificationType_name = json['classificationType_name'];
}

/// 帖子详情的一部分
/// 代表楼主的帖子信息
/// 封装在PostDetailResponse中
class PostDetail {
  int topic_id;
  String title;
  int user_id;
  String user_nick_name;
  int replies;
  int vote;
  int is_favor;
  String create_date;
  String icon;
  List<_Content> content;

  PostDetail(
      {this.topic_id,
      this.title,
      this.user_id,
      this.user_nick_name,
      this.replies,
      this.vote,
      this.is_favor,
      this.create_date,
      this.icon,
      this.content});

  PostDetail.fromJson(Map<String, dynamic> json)
      : this.topic_id = json['topic_id'],
        this.title = json['title'],
        this.user_id = json['user_id'],
        this.user_nick_name = json['user_nick_name'],
        this.replies = json['replies'],
        this.vote = json['vote'],
        this.is_favor = json['is_favor'],
        this.create_date = json['create_date'],
        this.icon = json['icon'] {

    var result = <_Content>[];
    for (int i = 0; i < json['content'].length; i ++) {
      var item = _Content.fromJson(json['content'][i]);
      result.add(item);
    }
    this.content = result;
  }
}

/// 代表楼主发的帖子的内容
class _Content {
  String infor;
  int type;             //0代表文字,1代表图片url，4代表网址url
  String url;
  String desc;
  String originalInfo;
  _Content({this.infor, this.type, this.url, this.desc, this.originalInfo});

  _Content.fromJson(Map<String, dynamic> json)
      : this.infor = json['infor'],
        this.type = json['type'],
        this.url = json['url'],
        this.desc = json['desc'],
        this.originalInfo = json['originalInfo'];
}

class PostMessage {
  String board_name;
  int board_id;
  int topic_id;
  String topic_subject;
  String topic_content;
  String topic_url;
  String reply_content;
  String reply_remind_id;
  String reply_url;
  String content;
  String user_name;
  int user_id;
  String icon;
  String type;
  String replied_date;
  int is_read;
  String mod;

  PostMessage(
      {this.board_name,
      this.board_id,
      this.topic_id,
      this.topic_subject,
      this.topic_content,
      this.topic_url,
      this.replied_date,
      this.reply_content,
      this.reply_remind_id,
      this.content,
      this.user_name,
      this.user_id,
      this.icon,
      this.type,
      this.is_read,
      this.mod,
      this.reply_url});

  PostMessage.fromJson(Map<String, dynamic> json)
      : this.board_name = json['board_name'],
        this.board_id = json['board_id'],
        this.topic_id = json['topic_id'],
        this.topic_subject = json['topic_subject'],
        this.topic_content = json['topic_content'],
        this.topic_url = json['topic_url'],
        this.reply_url = json['reply_url'],
        this.reply_remind_id = json['reply_remind_id'],
        this.reply_content = json['reply_content'],
        this.content = json['content'],
        this.user_name = json['user_name'],
        this.user_id = json['user_id'],
        this.icon = json['icon'],
        this.type = json['type'],
        this.replied_date = json['replied_date'];

}

