import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/doctor/home_page_doctor.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../controller/image.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';

class UploadFile {
  final String filePath;

  UploadFile({required this.filePath});

  Future uploadFile() async {
    String url = "http://192.168.1.3:6001/upload";
    var req = http.MultipartRequest("POST", Uri.parse(url));
    req.fields["name"] = "dyaa";
    var file = await http.MultipartFile.fromPath("file", filePath);
    req.files.add(file);
    var res = await req.send();
    print("File upload success");
  }
}

class UploadPrescription extends StatefulWidget {
  const UploadPrescription({super.key});

  @override
  State<UploadPrescription> createState() => _UploadPrescriptionState();
}

class _UploadPrescriptionState extends State<UploadPrescription> {
  final userdata = GetStorage();
  Map<String, dynamic>? profileData;
  final cNid = TextEditingController();
  List<String> _listOfNotification = [];
  List wholeList = [];
  late String? patName = "";
  late String? patEmail = "";
  late String? Nid = "";
  XFile? pickedFile;
  XFile? image;
  final ImagePicker picker = ImagePicker();
  Future pickimage(ImageSource media) async {
    var img = await picker.pickImage(source: media);
    setState(() {
      image = XFile(img!.path);
    });
    Uploadimg(img: image!.path).uploadimage();
  }

  Future addPre(Imagename, patemail, nid, patname, time, docname) async {
    var url = "http://192.168.1.3:6001/bbbb";

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "image_name": Imagename,
          "pat_email": patemail,
          "Nid": nid,
          "pat_name": patname,
          "time": time,
          "doc_name": docname
        }),
      );

      if (response.statusCode == 200) {
        // Successful response, you can process the response here.
        var responseData = jsonDecode(response.body);
        print(responseData);
      } else if (response.statusCode == 401) {
        // Unauthorized response, "Log in failed" scenario.
        print("sinup in failed");
      } else {
        // Handle other status codes as needed.
        print("Unexpected status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        pickedFile = result as XFile?;
      });
      UploadFile(filePath: result.files.single.path!).uploadFile();
    } else {
      // User canceled the picker
      print("No file selected");
    }
  }

  Future fetchNid(nid) async {
    print("h1");
    // the API endpoint
    String url = "http://192.168.1.3:6000/pateintProfile?email=${nid}";
    // make a GET request
    var response = await http.get(Uri.parse(url));
    // check the status code
    print(response.body);
    if (response.statusCode == 200) {
      try {
        var data = json.decode(response.body);
        print(data);
        setState(() {
          cNid.text = data[0]['Nid'];
          Nid = data[0]['Nid'];
        });
      } catch (e) {
        // handle the error
        print("Failed to decode JSON: $e");
      }
    } else {
      // handle the error
      print("Failed to fetch profile data");
    }
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Colors.tealAccent.shade400)),
                    onPressed: () {
                      Navigator.pop(context);
                      pickimage(ImageSource.gallery);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Colors.tealAccent.shade400)),
                    onPressed: () {
                      Navigator.pop(context);
                      pickimage(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Colors.tealAccent.shade400)),
                    onPressed: () {
                      Navigator.pop(context);
                      pickFile();
                    },
                    child: Row(
                      children: [
                        Icon(Icons.file_copy),
                        Text('Upload File'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future fetchP() async {
    print(userdata.read("email"));
    // the API endpoint
    String url =
        "http://192.168.1.3:6000/getNots?email=${userdata.read("email")}";
    // make a GET request
    var response = await http.get(Uri.parse(url));
    // check the status code
    print(response.body);
    if (response.statusCode == 200) {
      try {
        var data = json.decode(response.body);
        print(data);
        setState(() {
          for (var message in data) {
            wholeList.add(
                {'name': message['pat_name'], 'email': message['pat_email']});
            _listOfNotification.add(message['pat_name']);
          }
        });
      } catch (e) {
        // handle the error
        print("Failed to decode JSON: $e");
      }
    } else {
      // handle the error
      print("Failed to fetch profile data");
    }
  }

  @override
  void initState() {
    super.initState();

    fetchP();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.tealAccent.shade400,
          shadowColor: Colors.tealAccent.shade400,
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(50)),
          title: Text("UPLOAD PRESCRIPTION", textScaleFactor: 1.25),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Get.offAll(home_page_doctor());
              },
              icon: const Icon(LineAwesomeIcons.angle_left)),
        ),
        body: Column(children: [
          Container(
            margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.tealAccent.shade400),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration.collapsed(hintText: 'Select Patinet'),
              items: _listOfNotification
                  .map((String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ))
                  .toList(),
              onChanged: (String? value) {
                for (var item in wholeList) {
                  patName = value;
                  if (item['name'] == value) {
                    patEmail = value;
                    fetchNid(item['email']);
                  }
                }
              },
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
            padding: EdgeInsets.all(11.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.tealAccent.shade400),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: TextField(
              controller: cNid,
              readOnly: true,
              decoration: InputDecoration.collapsed(hintText: 'National ID'),
              onChanged: (value) {},
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 42,
                width: 250,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )),
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.tealAccent.shade400),
                  ), //ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.tealAccent.shade400),
                  onPressed: () {
                    myAlert();
                  },
                  child: Text(
                    'Upload Prescription Photo',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),

              //if image not null show the image
              //if image null show text
              image != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          //to show image, you type like this.
                          File(image!.path),
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                        ),
                      ),
                    )
                  : Text(
                      "No Image",
                      style: TextStyle(fontSize: 15),
                    ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
          Container(
            height: 45,
            width: 370,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.tealAccent.shade400),
            child: ElevatedButton(
              onPressed: () {
                DateTime? timestamp;
                timestamp = timestamp ?? DateTime.now();

                print(image?.name);
                addPre(image?.name, patEmail, Nid, patName,
                    timestamp.toString(), userdata.read("name").toString());
              },
              child: Text(
                "Confirm",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.tealAccent.shade400,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  )),
            ),
          ),
        ]));
  }
}
