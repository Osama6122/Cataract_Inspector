import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Second extends StatefulWidget {
  const Second({super.key});

  @override
  State<Second> createState() => _SecondState();
}

class _SecondState extends State<Second> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  get googleSignIn => null;
  Future<void> _handleSignOut() async {
    await googleSignIn.signOut();
    await _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.only(left: 30),
            child: Text(
              "CATARACT INSPECTOR",
              style: TextStyle(
                  color: Color(0xFF61A6FF), fontWeight: FontWeight.w900),
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assets/images/eye.jpg'),
                    fit: BoxFit.cover,
                  )),
                  child: Text("")),
              ListTile(
                leading: Icon(
                  Icons.home,
                  size: 28,
                  color: Colors.blue,
                ),
                title: Padding(
                  padding: EdgeInsets.only(left: 0, right: 100),
                  child: Text(
                    "Home",
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "account");
                },
                child: ListTile(
                  leading: Icon(
                    Icons.account_circle,
                    size: 28,
                    color: Colors.blue,
                  ),
                  title: Padding(
                    padding: EdgeInsets.only(left: 0, right: 100),
                    child: Text(
                      "My Account",
                      style: TextStyle(color: Colors.blue, fontSize: 20),
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.share,
                  size: 28,
                  color: Colors.blue,
                ),
                title: Padding(
                  padding: EdgeInsets.only(left: 0, right: 100),
                  child: Text(
                    "Share ",
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.grade_outlined,
                  size: 28,
                  color: Colors.blue,
                ),
                title: Padding(
                  padding: EdgeInsets.only(left: 0, right: 100),
                  child: Text(
                    "About Us",
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _handleSignOut();
                },
                child: ListTile(
                  leading: Icon(
                    Icons.exit_to_app,
                    size: 28,
                    color: Colors.blue,
                  ),
                  title: Padding(
                    padding: EdgeInsets.only(left: 0, right: 100),
                    child: Text(
                      "Exit",
                      style: TextStyle(color: Colors.blue, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 60),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Visualize your",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                      fontSize: 30),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 25),
                  child: Text(
                    "eye on your \n finger tips",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 30),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 70),
                  child: Center(
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 7,
                                color: Colors.blue,
                              ),
                              borderRadius: BorderRadius.circular(97)),
                          child: CircleAvatar(
                            backgroundImage: AssetImage("assets/images/e.jpg"),
                            radius: 90,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 140),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 7,
                                  color: Colors.blue,
                                ),
                                borderRadius: BorderRadius.circular(97)),
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/images/d.jpg"),
                              radius: 90,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 70),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 7,
                                  color: Colors.blue,
                                ),
                                borderRadius: BorderRadius.circular(97)),
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/images/f.jpg"),
                              radius: 90,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
                SizedBox(
                  height: 50,
                  width: 200,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "home");
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF61A6FF).withOpacity(0.55),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(
                                    10,
                                  ),
                                  bottomRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10)))),
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w800,
                            color: Colors.white),
                      )),
                ),
              ],
            ),
          ),
        ));
  }
}
