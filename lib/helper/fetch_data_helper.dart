import 'dart:convert';

import 'package:vprice/globals.dart' as globals;
import 'package:http/http.dart' as http;

class FetchDataHelper {
  FetchDataHelper._();
  static final FetchDataHelper instance = FetchDataHelper._();

  Future<dynamic> fetchData({required String endpoint}) async {
    var url = globals.apiHost + endpoint;

    print(url);
    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer ${globals.apiKey}",
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
