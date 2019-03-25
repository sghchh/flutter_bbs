import 'package:flutter/material.dart';

/// 用来显示关于的界面
class AboutPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GestureDetector(
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 10, top: MediaQuery.of(context).size.height*0.25),
                    child: Text("清水河畔", style: TextStyle(fontSize: 24, color: Colors.black, decoration: TextDecoration.none),),
                  ),
                  Image.asset('images/ic_launcher.png', width: 85, height: 85,),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text("Flutter测试版", style: TextStyle(fontSize: 14, color: Colors.grey, decoration: TextDecoration.none),),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Text("官网 : http://bbs.uestc.edu.cn/", style: TextStyle(fontSize: 14, color: Colors.grey, decoration: TextDecoration.none)),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: EdgeInsets.only(top: 30),
                        child: Text("星辰工作室", style: TextStyle(fontSize: 18, color: Colors.grey, decoration: TextDecoration.none),),
                      ),
                    ),
                  )
                ],
              ),
            ),
            onTap: (){
              Navigator.of(context).pop();
            },
          )
      ),
    );
  }

}