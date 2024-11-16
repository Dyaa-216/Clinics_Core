import 'package:http/http.dart' as http;
import 'dart:convert';

class GetUserContrller {
  Future getData() async {
    var url = "http://192.168.1.3:6000/";
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      print(data);
    } else {}
  }
}
