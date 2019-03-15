import 'package:flutter/material.dart';

///create by sgh    2019-20-17
/// 用户信息的界面
class UserDrawer {

  //返回侧拉抽屉的drawer布局
  static Widget getGrawer() {
    return _UserPageWidget();
  }

  /*
 *  注销登录  的点击事件
 */
  static void _logout() {

  }
}

class _UserPageWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _UserPageWidgetState();
  }
}

class _UserPageWidgetState extends State<_UserPageWidget> {

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        //_drawHeader()
        DrawerHeader(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(color: Colors.blue),
          child: _drawMyHeader(),
        ),
        ListTile(leading: Icon(Icons.favorite, color: Colors.grey,size: 24,),title: Text('我的收藏',style: TextStyle(fontSize: 18),),onTap: () => Navigator.of(context, rootNavigator: true).pushNamed('user/userCollection')),
        ListTile(leading: Icon(Icons.content_paste, color: Colors.grey,size: 24,),title: Text('我的发表',style: TextStyle(fontSize: 18),),onTap: () => Navigator.of(context, rootNavigator: true).pushNamed('user/userPost')),
        ListTile(leading: Icon(Icons.business_center, color: Colors.grey,size: 24,),title: Text('河畔商城',style: TextStyle(fontSize: 18),),onTap: () => Navigator.pop(context)),
        ExpansionTile(
          leading: Icon(Icons.people, color: Colors.grey,size: 24,),title: Text('我的好友',style: TextStyle(fontSize: 18),),
          children: _getFriends(),
          onExpansionChanged: null,
        ),
        ListTile(leading: Icon(Icons.help, color: Colors.grey,size: 24,),title: Text('关于',style: TextStyle(fontSize: 18),),onTap: () => Navigator.pop(context)),
        Container(padding: EdgeInsets.only(left: 12, right: 12),
          child: Row(children: <Widget>[
            Expanded(child: RaisedButton(
                child: Text('注销'),
                color: Colors.redAccent,
                textColor: Colors.white,
                onPressed: UserDrawer._logout)
            )
          ],)
        )
      ],
    );
  }

  //绘制Drawer的DrawHeader部分
  Widget _drawMyHeader() {
    return Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(right: 20),
          child: CircleAvatar(
            backgroundImage: AssetImage('images/c.jpg'),
            radius: 48,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(padding: EdgeInsets.only(bottom: 6),child: Text('Name',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.white),),),
            Container(padding: EdgeInsets.only(left:3,bottom: 4),child: Text('等级',style: TextStyle(fontSize: 14,color: Colors.white),),),
            Container(padding: EdgeInsets.only(left:3,bottom: 4),child: Text('水滴',style: TextStyle(fontSize: 14,color: Colors.white),),),
            Container(padding: EdgeInsets.only(left:3,bottom: 4),child: Text('积分',style: TextStyle(fontSize: 14,color: Colors.white),),),
          ],
        )
      ],
    );
  }

  //构建展开后的好友列表的方法
  List<Widget> _getFriends() {
    return <Widget>[
      ListTile(
        leading: CircleAvatar(backgroundImage: AssetImage('images/c.jpg'), radius: 16,),
        title: Text('好友姓名',style: TextStyle(fontSize: 18),)
      ),
      ListTile(
        leading: CircleAvatar(backgroundImage: AssetImage('images/c.jpg'), radius: 16,),
          title: Text('好友姓名',style: TextStyle(fontSize: 18),)
      ),
    ];
  }

}



