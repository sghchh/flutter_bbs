import 'dart:async';
import 'package:flutter/material.dart';

class ShowAwait<T> extends StatefulWidget {
  String loadingText = "正在登陆...";
  ShowAwait(this.requestCallback, {this.loadingText});
  final Future<T> requestCallback;

  @override
  _ShowAwaitState createState() => new _ShowAwaitState(this.loadingText);
}

class _ShowAwaitState extends State<ShowAwait> {
  String loadingText = "正在登陆";
  _ShowAwaitState(this.loadingText);

  @override
  initState() {
    super.initState();
    widget.requestCallback.then((onValue) {
      Navigator.of(context).pop(onValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: new Center(
        child: new SizedBox(
          width: 120.0,
          height: 120.0,
          child: new Container(
            decoration: ShapeDecoration(
              color: Color(0xffffffff),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
            ),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new CircularProgressIndicator(),
                new Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                  ),
                  child: new Text(
                    'waiting...',
                    style: new TextStyle(fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

