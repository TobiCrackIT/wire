import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:moovy/core/utils/exceptions.dart';

class HttpService {

  Future<dynamic> get(String route,
      {Map<String, String>? headers, bool returnTypeIsFile = false}) async {

      try {
        final url = Uri.parse(route);
        final response = await http.get(url, headers: headers);
        return  _processResponse(response);
      } on SocketException {
        throw FetchDataException('No internet connection 😑');
      } on FormatException {
        throw FetchDataException('Bad response format 👎');
      } on TimeoutException {
        throw FetchDataException('Timeout exceeded');
      }

  }

  Future<dynamic> post(String route, dynamic body, dynamic headers) async {

      try {
        final url = Uri.parse(route);
        final response =
        await http.post(url, body: body, headers: headers);
        return _processResponse(response);
      } on SocketException {
        throw FetchDataException('No internet connection 😑');
      } on FormatException {
        throw FetchDataException('Bad response format 👎');
      } on TimeoutException {
        throw FetchDataException('Timeout exceeded');
      }

  }

  dynamic _processResponse(http.Response response) {
    final jsonBody = response.body.isEmpty ? {} : jsonDecode(response.body);

    switch (response.statusCode) {
      case 200:
      case 201:
      case 204:
        return jsonBody;

      case 206:
        throw ApiException(jsonBody['message'].toString());
      case 400:
        throw ApiException(jsonBody['message'].toString());
      case 401:
      case 403:
        throw ApiException(jsonBody['message'].toString());
      case 404:
        throw ApiException(jsonBody['message'].toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communicating with Server with StatusCode: ${response.statusCode}');
    }
  }

}
