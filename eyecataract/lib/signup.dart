import 'package:eyecataract/name.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
}

class MySignUp extends StatefulWidget {
  const MySignUp({super.key});

  @override
  State<MySignUp> createState() => _MySignUpState();
}

class _MySignUpState extends State<MySignUp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool showpass = false;

  bool _isLoading = false;
  String _errorText = '';

  Future<void> _signUp() async {
    setState(() {
      _isLoading = true;
      _errorText = '';
    });

    try {
      if (_passwordController.text != _confirmPasswordController.text) {
        throw 'Password and Confirm Password do not match.';
      }
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (userCredential.user != null) {
        // Successfully signed up
//----------------------------------------------------------------------------------------//
        Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => Name(
                    email: userCredential.user!.email ??
                        "default_email@example.com"))
//----------------------------------------------------------------------------------------//
            );
      }
    } catch (e) {
      setState(() {
        _errorText = 'Sign up failed. Please check your email and password.';
      });
    } finally {
      setState(() {
        _isLoading = false;
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
                "Sign Up",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 30),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'email address',
                  filled: true,
                  fillColor: Colors.blue.withOpacity(0.07),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 4, color: Colors.white),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.white,
                  )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: _passwordController,
                obscureText: !showpass,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.blue.withOpacity(0.07),
                  labelText: 'password',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 4, color: Colors.white),
                      borderRadius: BorderRadius.circular(20)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.white,
                  )),
                  suffixIcon: IconButton(
                    icon: Icon(
                      showpass ? Icons.visibility : Icons.visibility_off,
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
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: _confirmPasswordController,
                obscureText: !showpass,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.blue.withOpacity(0.07),
                  labelText: 'confirm password',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 4, color: Colors.white),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.white,
                  )),
                  suffixIcon: IconButton(
                    icon: Icon(
                      showpass ? Icons.visibility : Icons.visibility_off,
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
                    backgroundColor: Color(0xFF61A6FF).withOpacity(0.55),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(14),
                            bottomRight: Radius.circular(14),
                            bottomLeft: Radius.circular(14)))),
                onPressed: _isLoading ? null : _signUp,
                child: _isLoading
                    ? CircularProgressIndicator()
                    : Icon(Icons.arrow_forward),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
            ),
            Padding(
              padding: EdgeInsets.only(left: 70),
              child: Row(
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'login');
                      },
                      child: Text(
                        "login here!",
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
