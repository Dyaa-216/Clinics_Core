import 'package:http/http.dart' as http;

class Uploadimg {
  final img;
  Uploadimg({this.img});

  Future uploadimage() async {
    String url = "http://192.168.1.3:6001/upload";
    var req = http.MultipartRequest("POST", Uri.parse(url));
    req.fields["name"] = "dyaa";
    var pic = await http.MultipartFile.fromPath("img", img);
    req.files.add(pic);
    var res = req.send();
    print("Success");
  }
}
