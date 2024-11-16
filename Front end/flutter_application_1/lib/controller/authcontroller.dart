import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginAuth {
  Future login(email, password) async {
    var url = "http://192.168.1.3:6000/logIn/pateint";
    print("kiiiiiiiiiiiiiiiiiiiiasiaaaaaaaaaaaaaa");
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({"email": email, "password": password}),
      );
      print(response.body);

      if (response.statusCode == 200) {
        // Successful response, you can process the response here.
        var responseData = jsonDecode(response.body);
        return responseData;
      } else if (response.statusCode == 401) {
        // Unauthorized response, "Log in failed" scenario.
        print("Log in failed");
      } else {
        // Handle other status codes as needed.
        print("Unexpected status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future signUp_Patinet(
      email, name, nid, password, phonenum, age, weight, gender) async {
    var url = "http://192.168.1.3:6000/signUpPatient";

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "email": email,
          "name": name,
          "Nid": nid,
          "password": password,
          "phone_num": phonenum,
          "age": age,
          "weight": weight,
          "gender": gender
        }),
      );
      print(weight);
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

  Future signUp_Doctor(email, password, name, phone_num, Specialization) async {
    var url = "http://192.168.1.3:6000/signUpDoctor";

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "email": email,
          "name": name,
          "password": password,
          "phone_num": phone_num,
          "Specialization": Specialization,
        }),
      );
      print(Specialization);
      if (response.statusCode == 200) {
        // Successful response, you can process the response here.
        var responseData = jsonDecode(response.body);
        print("sign up successfully");
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

  Future signUp_Clinic(
      password, name, phone_num, address, timerange, spec, email) async {
    var url = "http://192.168.1.3:6000/signUpClinic";

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "email": "",
          "name": name,
          "password": password,
          "phone_num": phone_num,
          "address": address,
          "time_range": timerange,
          "Specialization": spec,
          "deamil": email,
        }),
      );
      print(response);
      if (response.statusCode == 200) {
        // Successful response, you can process the response here.
        var responseData = jsonDecode(response.body);
        print("sign up successfully");
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

  Future saka(email, name) async {
    // Define the server URL
    var url = "http://192.168.1.3:6000/pateintProfile";

    // Try to send a POST request to the server with the email as the body
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

      // Check the status code of the response
      if (response.statusCode == 200) {
        // Successful response, decode the JSON data and return it
        var data = jsonDecode(response.body);
        return data;
      } else {
        // Unsuccessful response, throw an exception or handle it accordingly
        throw Exception("Failed to get patient data");
      }
    } catch (e) {
      // Catch any errors that may occur during the request or decoding
      print("Error: $e");
      return null;
    }
  }
}
