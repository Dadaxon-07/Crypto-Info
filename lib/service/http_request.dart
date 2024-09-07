import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/Adreess.dart';

class HTTPRequest {
  // Get , Post , Put , Delete

  static String BASE = "jsonplaceholder.typicode.com";
  static Map<String, String> headrs = {
    'Content-Type': 'application/json; charset=UTF-8'
  };

  static String API_List = "/photos";
  static String API_Create = "/photos";
  static String API_Update = "/photos/";
  static String API_Delete = "photos/";

  //HTTP Request

  static Future<String?> GET(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE, api, params);
    var response = await http.get(uri, headers: headrs);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> POST(String api, Map<String, String> params) async {
    print(params.toString());
    var uri = Uri.https(BASE, api);
    var response =
        await http.post(uri, headers: headrs, body: jsonEncode(params));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Future<String?> PUT(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE, api);
    var response =
        await http.post(uri, headers: headrs, body: jsonEncode(params));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Map<String, String> paramsEmpty() {
    Map<String, String> params = Map();
    return params;
  }

  static List<Welcome> parsePostList(String response) {
    dynamic json = jsonDecode(response);
    var data = List<Welcome>.from(json.map((x) => Welcome.fromJson(x)));
    return data;
  }
}
