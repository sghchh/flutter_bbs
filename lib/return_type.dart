// 专门为登陆、登出、评论、发帖、回复这几个功能联动Dialog实现
class ReturnType {
  int type;        //0代表错误,1代表成功
  String content;   //错误时代表需要展示的错误信息

  ReturnType(this.type, {this.content});
}