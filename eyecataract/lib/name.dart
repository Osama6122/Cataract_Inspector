import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Name extends StatefulWidget {
  final String email;

  const Name({super.key, required this.email});

  @override
  State<Name> createState() => _NameState();
}

class _NameState extends State<Name> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  String selectedGender = "";
  String selectedAvatar = "human.png";
  List<String> avatars = [
    'gamer.png',
    'girl.png',
    'human.png',
    'woman.png',
    'man.png',
  ];

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // App Title, etc.

            // Avatar Selection
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/$selectedAvatar'),
              radius: 60,
            ),
            Text("Select an Avatar", style: TextStyle(fontSize: 15)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: avatars.map((avatar) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedAvatar = avatar; // Update selected avatar
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/$avatar'),
                      radius: 30,
                      backgroundColor: avatar == selectedAvatar
                          ? Colors.blue // Highlight the selected avatar
                          : Colors.transparent,
                    ),
                  ),
                );
              }).toList(),
            ),

            // First Name TextField
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  hintText: "First name",
                  filled: true,
                  fillColor: Colors.blue.withOpacity(0.07),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(width: 4, color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.white,
                  )),
                ),
              ),
            ),

            // Last Name TextField
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  hintText: "Last name",
                  filled: true,
                  fillColor: Colors.blue.withOpacity(0.07),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(width: 4, color: Colors.white)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.white,
                  )),
                ),
              ),
            ),

            // Age TextField
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: _ageController,
                decoration: InputDecoration(
                  hintText: "Age",
                  filled: true,
                  fillColor: Colors.blue.withOpacity(0.07),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(width: 4, color: Colors.white)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.white,
                  )),
                ),
              ),
            ),

            // Gender Selection
            Row(
              children: [
                Radio<String>(
                  value: "Male",
                  groupValue: selectedGender,
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value!;
                    });
                  },
                ),
                Text("Male",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        fontStyle: FontStyle.italic)),
                Radio<String>(
                  value: "Female",
                  groupValue: selectedGender,
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value!;
                    });
                  },
                ),
                Text("Female",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        fontStyle: FontStyle.italic)),
              ],
            ),

            // Done Button
            SizedBox(
              height: 50,
              width: 130,
              child: ElevatedButton(
                onPressed: () async {
                  var url = Uri.parse('http://10.128.71.4:8000/add_user');
                  try {
                    var response = await http.post(url, body: {
                      'first_name': _firstNameController.text,
                      'last_name': _lastNameController.text,
                      'age': _ageController.text,
                      'gender': selectedGender,
                      'email': widget.email,
                      'selected_avatar': selectedAvatar,
                    });

                    if (response.statusCode == 200) {
                      // Success handling
                      Navigator.pushNamed(context, "second");
                    } else {
                      // Error handling
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Failed to save data")),
                      );
                    }
                  } catch (e) {
                    // Exception handling
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Error: $e")),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF61A6FF).withOpacity(0.55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                ),
                child: Text(
                  "Done",
                  style: TextStyle(
                    fontSize: 30,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
