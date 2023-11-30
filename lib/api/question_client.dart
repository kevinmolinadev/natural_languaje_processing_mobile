import 'dart:convert';

import 'package:http/http.dart' as http;

class QuestionClient {
  String urlBase;
  QuestionClient({
    this.urlBase = "http://10.0.2.2:8000",
  });

  Future<Map<String, dynamic>> sendQuestion(String question) async {
    print(jsonEncode({"question": question}));
    final response = await http.post(Uri.parse("${this.urlBase}/questions"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"question": question}),
        encoding: utf8);
    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      return {"question": question, "result": "Error al realizar la peticion"};
    }
  }
}
