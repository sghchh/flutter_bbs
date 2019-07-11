
/// 在获取帖子详情的时候的一部分
/// 作为帖子评论区 每个评论 的封装
class ReplyDetail {
  List<_ReplyContent> reply_content;    // 代表该条评论的内容，其和楼主的Content一个意思
  String reply_name;     // 评论者的用户名
  int reply_posts_id;    // 标志某一条评论，在回复某一个评论的时候需要传递该参数
  String posts_date;     // 该评论的发表时间的时间戳
  String icon;     // 该评论作者的头像URL
  String quote_content;  // 如果该条是一个回复的话，代表被回复的内容
  int reply_id;       // 其值实际上代表着用户的id，即user_id

  ReplyDetail.fromJson(Map<String, dynamic> json)
      : this.reply_name = json['reply_name'],
        this.reply_posts_id = json['reply_posts_id'],
        this.posts_date = json['posts_date'],
        this.icon = json['icon'],
        this.reply_id = json['reply_id'],
        this.quote_content = json['quote_content']{

    var result = <_ReplyContent>[];
    for (int i = 0; i < json['reply_content'].length; i++) {
      var item = _ReplyContent.fromJson(json['reply_content'][i]);
      result.add(item);
    }
    this.reply_content = result;
  }
}

class _ReplyContent {
  String infor;
  int type;
  String url;

  _ReplyContent.fromJson(Map<String, dynamic> json)
      : this.infor = json['infor'],
        this.type = json['type'],
        this.url = json['url'];
}