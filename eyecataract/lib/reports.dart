import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  List<Map<String, dynamic>> data = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      // Get the email of the current user
      String? userEmail = FirebaseAuth.instance.currentUser?.email;

      // Check if the user is logged in
      if (userEmail == null) {
        print('User is not logged in');
        return;
      }

      var response = await http.get(
        Uri.parse('http://192.168.18.14:8000/get_all_eye_images?email=$userEmail'),
      );

      if (response.statusCode == 200) {
        List<dynamic> fetchedData = json.decode(response.body);
        setState(() {
          data = fetchedData.map<Map<String, dynamic>>((item) {
            return {
              'id': item['index'],
              'eye': item['eye'],
              'result': item['result'],
              'time': item['timestamp'],
            };
          }).toList();
        });
      } else {
        // Handle errors
        print('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Text(
                'Reports',
                style: TextStyle(
                  fontSize: 35,
                  color: Color(0xFF61A6FF),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            DataTable(
              columns: [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Eye')),
                DataColumn(label: Text('Result')),
                DataColumn(label: Text('Time')),
              ],
              rows: data
                  .map(
                    (item) => DataRow(
                  cells: [
                    DataCell(Text(item['id'].toString())),
                    DataCell(Text(item['eye'])),
                    DataCell(Text(item['result'].toString())),
                    DataCell(Text(item['time'])),
                  ],
                ),
              )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
