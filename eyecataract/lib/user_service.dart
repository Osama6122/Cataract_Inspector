import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  Future<Map<String, dynamic>?> fetchUserData(String email) async {
    try {
      var response = await http.get(Uri.parse('http://192.168.45.152:8000/get_user?email=$email'));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Failed to load user data');
      }
    } catch (e) {
      print('Error: $e');
    }
    return null;
  }
}
