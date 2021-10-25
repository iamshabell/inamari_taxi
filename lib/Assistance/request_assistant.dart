import 'dart:convert';

import 'package:http/http.dart' as http;

class RequestAssitant {
  static Future<dynamic> getRequest(String url) async {
    http.Response response = await http.get(Uri.parse(url));

    try {
      if (response.statusCode == 200) {
        String jSONdata = response.body;
        var decodeData = jsonDecode(jSONdata);
        return decodeData;
      } else {
        return "failed";
      }
    } catch (e) {
      return "failed";
    }
  }
}
