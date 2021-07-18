import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiClient {

  Future<List<dynamic>> requestHttp(String path, Map<String, String> params) async {
    final uri = Uri.https('qiita.com', path, params);
    http.Response response = await http.get(uri);
    String body = response.body;

    List<dynamic> itemMap = jsonDecode(body);

    return itemMap;
  }
}