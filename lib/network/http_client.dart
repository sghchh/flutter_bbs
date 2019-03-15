

import 'dart:io';

import 'package:dio/dio.dart';

/**
 * 封装了发起Http请求的客户端
 */
class DioClient {
  static Dio _mClient;

  static Dio getInstance () {
    if(_mClient == null) {
      _mClient = Dio();
      _gloableConfigClient();
    }
    return _mClient;
  }

  /**
   * 为Dio对象进行全局的请求配置
   */
  static void _gloableConfigClient () {
    BaseOptions mOptions = BaseOptions();
    mOptions.baseUrl = 'http://bbs.uestc.edu.cn/mobcent';
    mOptions.connectTimeout = 5000;   //设置5s的链接超时
    mOptions.contentType = ContentType.parse("application/x-www-form-urlencoded");
    mOptions.responseType = ResponseType.json;
    _mClient.options = mOptions;
  }
}