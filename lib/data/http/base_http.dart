import "dart:convert";

import "package:chuck2wiz/data/http/base_response.dart";
import "package:chuck2wiz/data/http/base_server_exception.dart";
import "package:flutter/foundation.dart";
import "package:http/http.dart" as Http;

class BaseHttp {
  static String jwtToken = "";

  Map<String, String> headers = {
    "Authorization" : "Bearer $jwtToken",
    "Content-Type": "application/json",
    "accept": "application/json",
  };

  Future<dynamic> get (String url) async {

    if (kDebugMode) {
      print( 'get url: $url');
      print( 'get headers: $headers');
    }

    Http.Response response = await Http.get(
        Uri.parse(url),
        headers: headers
    );

    final int statusCode = response.statusCode;
    final String result = utf8.decode(response.bodyBytes);
    if (kDebugMode) {
      print( 'get url: $url');
      print('get status: ${response.statusCode}');
      printLongString('get result: $result');
    }

    checkResponse(statusCode, result);

    return result;
  }

  Future<dynamic> post(String url, dynamic data) async {
    final headers = {
      'Content-Type': 'application/json',
    };

    var encodeData = json.encode(data);

    if (kDebugMode) {
      print('post url: $url');
      print('post headers: $headers');
      print('post data: $encodeData');
    }

    Http.Response response = await Http.post(
      Uri.parse(url),
      headers: headers,
      body: encodeData,
    );

    final int statusCode = response.statusCode;
    final String result = utf8.decode(response.bodyBytes);

    if (kDebugMode) {
      print('post url: $url');
      print('post status: ${response.statusCode}');
      printLongString('post result: $result');
    }

    checkResponse(statusCode, result);

    return result;
  }


  Future<dynamic> put(String url, dynamic data) async {

    if (kDebugMode) {
      var encodeData = json.encode(data);
      print( 'put url: $url');
      print( 'put headers: $headers');
      print( 'put data: $encodeData');
    }

    Http.Response response = await Http.put(
        Uri.parse(url),
        headers: headers,
        body: data
    );

    final int statusCode = response.statusCode;
    final String result = utf8.decode(response.bodyBytes);
    if (kDebugMode) {
      print( 'put url: $url');
      print('put status: ${response.statusCode}');
      printLongString('put result: $result');
    }

    checkResponse(statusCode, result);

    return result;
  }

  Future<dynamic> delete(String url) async {

    if (kDebugMode) {
      print( 'delete url: $url');
      print( 'delete headers: $headers');
    }

    Http.Response response = await Http.get(
        Uri.parse(url),
        headers: headers
    );

    final int statusCode = response.statusCode;
    final String result = utf8.decode(response.bodyBytes);
    if (kDebugMode) {
      print('delete status: ${response.statusCode}');
      printLongString('delete result: $result');
    }

    checkResponse(statusCode, result);

    return result;
  }

  void checkResponse(int statusCode, String result) {
    try {
      final resultResponse = baseResponseFromJson(result);

      if(!resultResponse.success) {
        throw BaseServerException(statusCode, resultResponse.message);
      }

    } catch(e) {
      if(e is BaseServerException) {
        rethrow;
      }
      else {
        throw BaseServerException(statusCode, result);
      }
    }
  }

  void printLongString(String text) {
    const int chunkSize = 800; // 한 번에 출력할 문자열 길이
    for (int i = 0; i < text.length; i += chunkSize) {
      print(text.substring(i, i + chunkSize > text.length ? text.length : i + chunkSize));
    }
  }

}