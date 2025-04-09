import 'package:dio/dio.dart';

abstract class ApiProvider{

  Future<Response> post({
    String? baseUrl,
    required String endPoint,
    Map<String,dynamic> data,
    dynamic query,
    String? token,
  //reports the progress of an ongoing operation, such as uploading or downloading data
    ProgressCallback? progressCallback,
    //to cancel operation
    CancelToken? cancelToken,
    int? timeOut,
    bool isMultiPart = false,
});

  Future<Response> get({
    String? baseUrl,
   required String endPoint,
    dynamic data,
    dynamic query,
    String? token,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    int? timeOut,
    bool isMultiPart = false,
    Options? options,
  });

  //update, if don't exist create
  Future<Response> put({
    String? baseUrl,
    required String endPoint,
    dynamic data,
    dynamic query,
    String? token,
    CancelToken? cancelToken,
    int? timeOut,
    bool isMultipart = false,
  });

  Future<Response> patch({
    String? baseUrl,
    required String endPoint,
    dynamic data,
    dynamic query,
    String? token,
    CancelToken? cancelToken,
    int? timeOut,
    bool isMultipart = false,
  });



  Future<Response> delete({
    String? baseUrl,
    required String endPoint,
    dynamic data,
    dynamic query,
    String? token,
    int? timeOut,
    bool isMultiPart = false,
  });

}