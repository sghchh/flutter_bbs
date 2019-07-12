
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as provider;

/// 用来显示帖子内容中图片的界面
class ImagePage extends StatelessWidget {
  String url;
  var dio = Dio();
  ImagePage({this.url});

  @override
  Widget build(BuildContext context) {
    var path = provider.getExternalStorageDirectory();
    String storage;
    path.then((value){
      storage = value.path;
      print(value.path);
    });
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      child: GestureDetector(
        child: ConstrainedBox(constraints: BoxConstraints.expand(),
        child: Image.network(url,
          fit: BoxFit.contain,),),
        onTap: (){
          Navigator.of(context).pop();
        },
        onLongPress: () {
          showDialog(context: context, builder: (context) {
            return AlertDialog(
              title: Text("下载图片功能暂未开放", style: TextStyle(color: Colors.black),),
              titleTextStyle: TextStyle(),
              actions: <Widget>[
                FlatButton(
                  child: Text("否", style: TextStyle(color: Colors.redAccent)),
                  onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
                ),
                FlatButton(
                  child: Text("是", style: TextStyle(color: Colors.blueAccent)),
                  onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
                )
              ],
            );
          });
        },
      )
    );
  }

}