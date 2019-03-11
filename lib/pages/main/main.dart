import 'package:flutter/material.dart';
import 'package:flutter_bbs/pages/main/model.dart';
import 'package:flutter_bbs/pages/main/presenter.dart';
import 'package:flutter_bbs/pages/main/view.dart';
import 'package:flutter_bbs/mvp/model.dart';
import 'package:flutter_bbs/mvp/presenter.dart';
import 'package:flutter_bbs/mvp/view.dart';
import 'package:flutter_bbs/pages/user/UserDrawer.dart';
import 'package:flutter_bbs/pages/home/home.dart';
import 'package:flutter_bbs/pages/board/board.dart';
import 'package:flutter_bbs/pages/message/message.dart';
import 'package:flutter_bbs/pages/user/posted/posted.dart';
import 'package:flutter_bbs/test.dart';

/**
 * create by sgh   2019-02-17
 * 登录后的首页面
 */

class MainPageWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _MainPageWidgetState();
  }
}

class _MainPageWidgetState extends State<MainPageWidget>
    with SingleTickerProviderStateMixin {

  IMainPresenter mPresenter;
  IMainView mView;
  IMainModel mModel;

  int _currentItemIndex = 0;

  List<String> homeListContent0 = ['test', 'test']; //'最新回复'对应的数据List

  _MainPageWidgetState() {
    this.mView = MainViewImpl();
    this.mModel = MainModelImpl();
    this.mPresenter = MainPresenterImpl(mView: mView, mModel: mModel);
  }

  final _bottomNavigationBar = <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(Icons.assignment, color: Colors.grey,),
        activeIcon: Icon(Icons.assignment, color: Colors.deepPurple,),
        title: Text('Hmoe')),
    BottomNavigationBarItem(icon: Icon(Icons.grid_on, color: Colors.grey,),
        activeIcon: Icon(Icons.grid_on, color: Colors.deepPurple,),
        title: Text('Board')),
    BottomNavigationBarItem(icon: Icon(Icons.message, color: Colors.grey,),
        activeIcon: Icon(Icons.message, color: Colors.deepPurple,),
        title: Text('Message'))
  ];


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          buttonColor: Colors.lightBlueAccent,
        ),
        home: DefaultTabController(
          length: 4,
          //由于该属性为final修饰的，所以这里不能根据_currentInteIndfex来进行适配，直接赋值为了4
          child: Scaffold(
              appBar: AppBar(
                  leading: Builder(builder: (context) {
                    return IconButton(icon: Icon(
                      Icons.person, color: Colors.white, size: 38.0,),
                      onPressed: () => Scaffold.of(context).openDrawer(),);
                  }),
                  title: Text('清水河畔', style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.white),),
                  centerTitle: true,
                  actions: <Widget>[IconButton(
                    icon: Icon(Icons.search, color: Colors.white, size: 38.0,),
                    onPressed: null,)
                  ],
                  bottom: _getTabBar()
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: _bottomNavigationBar,
                iconSize: 34.0,
                currentIndex: _currentItemIndex,
                fixedColor: Colors.deepPurple,
                type: BottomNavigationBarType.shifting,
                onTap: (index) {
                  setState(() {
                    _currentItemIndex = index;
                  });
                },),
              drawer: Drawer(
                child: UserDrawer.getGrawer(),
              ),
              floatingActionButton: _currentItemIndex != 0
                  ? null
                  : FloatingActionButton(
                child: Icon(Icons.edit, color: Colors.white,),
                onPressed: () {Navigator.of(context).pushNamed('edit/editPage');},
                elevation: 24,
              ),
              body:_getBody()
          ),
        )
    );
  }


  //根据BottomNavigationBar的索引返回不同的页面
  Widget _getBody() {
    return mPresenter.getWidgetByIndex(_currentItemIndex);
  }

  //根据BottomNavigationBar的索引展示不同的TabBar
  Widget _getTabBar () {
    return mPresenter.getTabBarByIndex(_currentItemIndex);
  }
}