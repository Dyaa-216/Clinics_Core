import 'package:http/http.dart' as http;
import 'dart:convert';

class Profilef {
  Future getdata(email) async {
    var url = "http://192.168.1.3:6000/pateintProfile ";
    print("hi1");
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "email": email,
        }),
      );
      print(response);
      if (response.statusCode == 200) {
        if (response.body.isEmpty) {
          // Handle empty response
          print('Empty response');
        } else {
          // Parse the JSON response
          var responseData = jsonDecode(response.body);
          print(responseData);
        }
      } else if (response.statusCode == 401) {
        // Unauthorized response, "Log in failed" scenario.
        print("getting feild");
      } else {
        // Handle other status codes as needed.
        print("Unexpected status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
