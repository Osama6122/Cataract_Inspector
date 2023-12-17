import 'package:eyecataract/second.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final _formkey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool showpass = false;
  bool isloading = false;
  String? _errorText;
  Future<void> _login() async {
    setState(() {
      isloading = true;
    });

    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (userCredential.user != null) {
        // Successfully logged in

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Second()),
        );
      }
    } catch (e) {
      setState(() {
        _errorText = 'Login failed. Please check your email and password.';
      });
    } finally {
      setState(() {
        isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 70),
              child: Text(
                "Cataract",
                style: TextStyle(
                    color: Color(0xFF61A6FF),
                    fontWeight: FontWeight.w900,
                    fontSize: 40,
                    fontFamily: 'dhurjati'),
              ),
            ),
            Text(
              "Inspector",
              style: TextStyle(
                  color: Color(0xFF61A6FF),
                  fontWeight: FontWeight.w900,
                  fontSize: 25),
            ),
            Padding(
              padding: EdgeInsets.only(right: 250, top: 60),
              child: Text(
                "Login",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 30),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 10, top: 20),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                      width: 337,
                      child: TextFormField(
                        controller: _emailController,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return ("Email is empty");
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'email address',
                          filled: true,
                          fillColor: Colors.blue.withOpacity(0.07),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 4, color: Colors.white),
                              borderRadius: BorderRadius.circular(20)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.white,
                          )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 50,
                      width: 337,
                      child: TextFormField(
                        controller: _passwordController,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return ("password is empty");
                          }
                          return null;
                        },
                        obscureText: !showpass,
                        decoration: InputDecoration(
                          labelText: 'password',
                          filled: true,
                          fillColor: Colors.blue.withOpacity(0.07),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 4, color: Colors.white),
                              borderRadius: BorderRadius.circular(20)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.white,
                          )),
                          suffixIcon: IconButton(
                            icon: Icon(
                              showpass
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                showpass = !showpass;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    SizedBox(
                      width: 80,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color(0xFF61A6FF).withOpacity(0.55),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(14),
                                      bottomRight: Radius.circular(14),
                                      bottomLeft: Radius.circular(14)))),
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              _login();
                            }
                          },
                          child: isloading
                              ? CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Icon(Icons.arrow_forward)),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 70, top: 20),
              child: Row(
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'signup');
                      },
                      child: Text(
                        "Sign Up Free!",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
