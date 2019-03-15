
///created by sgh      2019-3-2
/// 登录请求的返回数据
class LoginApi {
  final String secret;   //返回的accountSecret
  final String token;    //返回的accountToken
  final String avatar;    //返回的头像的url
  final int uid;
  final String userName;

  LoginApi({this.avatar, this.secret, this.token, this.uid, this.userName});

  LoginApi.fromJson(Map<String, dynamic> json)
    : this.uid = json['uid'],
      this.token = json['token'],
      this.secret = json['secret'],
      this.avatar = json['avatar'],
      this.userName = json['userName'];

  @override
  String toString() {
    return "User{token:${token}, name:${userName}, secret:${secret}";
  }
}