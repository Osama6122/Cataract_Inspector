// import 'package:eyecataract/login.dart';
// import 'package:flutter/material.dart';
// import "publicvariables.dart";
// import 'package:firebase_auth/firebase_auth.dart';
//
// class MyAccount extends StatefulWidget {
//
//   const MyAccount({super.key});
//
//   @override
//   State<MyAccount> createState() => _MyAccountState();
// }
//
// class _MyAccountState extends State<MyAccount> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   Future<void> _signout() async {
//     try {
//       await FirebaseAuth.instance.signOut();
//       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>MyLogin()));
//     }catch(e) {
//       print('Error sign out:$e');
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: PreferredSize(
//
//         preferredSize: Size.fromHeight(50), child: AppBar(
//         backgroundColor: Colors.white.withOpacity(1),
//         elevation: 4,
//         title: Text("My Account",style: TextStyle(fontSize: 25,color: Color(0xFF61A6FF),fontWeight: FontWeight.w900),),
//         iconTheme: IconThemeData(
//             color: Colors.black
//         ),
//
//       ),
//       ),
//       body: Container(
//         child: Column(
//           children:[
//             Padding(
//               padding:  EdgeInsets.only(top: 40,left: 0),
//               child: CircleAvatar(
//                 backgroundColor: Colors.black12,
//                 radius: 60,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 0,left: 0,right: 0,),
//               child: SizedBox(
//                 height: 50,
//                 width: 300,
//                 child: TextField(
//                   decoration: InputDecoration(
//
//                     filled: true,
//                     fillColor:Colors.blue.withOpacity(0.07),
//                     enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(14),
//                         borderSide: BorderSide(
//                             width: 4,color: Colors.white
//                         )
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: Colors.white,
//                         )
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 50,
//             ),
//             Row(
//               children: [
//                 Column(
//                   children: [
//                     Text("First name",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700),),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 5),
//                       child: SizedBox(
//                         height: 50,
//                         width: 200,
//                         child: TextField(
//                           decoration: InputDecoration(
//
//                             filled: true,
//                             fillColor:Colors.blue.withOpacity(0.07),
//                             enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(14),
//                                 borderSide: BorderSide(
//                                     width: 4,color: Colors.white
//                                 )
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: Colors.white,
//                                 )
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Text("Gender ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700),),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 0,left: 0,right: 0,),
//                       child: SizedBox(
//                         height: 50,
//                         width: 200,
//                         child: TextField(
//                           decoration: InputDecoration(
//
//                             filled: true,
//                             fillColor:Colors.blue.withOpacity(0.07),
//                             enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(14),
//                                 borderSide: BorderSide(
//                                     width: 4,color: Colors.white
//                                 )
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: Colors.white,
//                                 )
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     Text("Last name",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700),),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 0,left: 0,right: 0,),
//                       child: SizedBox(
//                         height: 50,
//                         width: 200,
//                         child: TextField(
//                           decoration: InputDecoration(
//
//                             filled: true,
//                             fillColor:Colors.blue.withOpacity(0.07),
//                             enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(14),
//                                 borderSide: BorderSide(
//                                     width: 4,color: Colors.white
//                                 )
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: Colors.white,
//                                 )
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Text("Age",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700),),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 0,left: 0,right: 0,),
//                       child: SizedBox(
//                         height: 50,
//                         width: 200,
//                         child: TextField(
//                           decoration: InputDecoration(
//
//                             filled: true,
//                             fillColor:Colors.blue.withOpacity(0.07),
//                             enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(14),
//                                 borderSide: BorderSide(
//                                     width: 4,color: Colors.white
//                                 )
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: Colors.white,
//                                 )
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//
//                   ],
//                 ),
//
//               ],
//             ),
//             SizedBox(
//               height: 30,
//             ),
//             SizedBox(
//               height: 50,
//               width: 200,
//               child: ElevatedButton(onPressed: (){
//                 Navigator.pushNamed(context, "changepassword");
//               },
//                   style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xFF61A6FF).withOpacity(0.55),
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.only(topRight: Radius.circular(10,),bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10))
//                       )
//                   ),
//
//                   child: Text("Change Password",style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic,fontWeight: FontWeight.w800,color: Colors.white),)),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             SizedBox(
//               height: 50,
//               width: 130,
//               child: ElevatedButton(onPressed: (){
//                 _signout();
//               },
//                   style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xFF61A6FF).withOpacity(0.55),
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.only(topRight: Radius.circular(10,),bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10))
//                       )
//                   ),
//
//                   child: Text("Sign out",style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic,fontWeight: FontWeight.w800,color: Colors.white),)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:eyecataract/login.dart';
import 'user_service.dart'; // Import UserService

class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late Future<Map<String, dynamic>?> userDataFuture;

  Future<void> _signout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MyLogin()));
    } catch (e) {
      print('Error sign out: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    userDataFuture = fetchUserData();
  }

  Future<Map<String, dynamic>?> fetchUserData() async {
    var user = _auth.currentUser;
    if (user != null) {
      return UserService().fetchUserData(user.email!);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.white.withOpacity(1),
          elevation: 4,
          title: Text(
            "My Account",
            style: TextStyle(fontSize: 25, color: Color(0xFF61A6FF), fontWeight: FontWeight.w900),
          ),
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: userDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text("No user data available"));
          }
          var userData = snapshot.data!;

          return Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black12,
                  radius: 60,
                  // Assuming 'avatar' is a URL to the user's avatar image
                  backgroundImage: AssetImage('assets/images/${userData['avatar']}'),
                ),
                SizedBox(height: 20),
                userInfoRow("Email", userData['email'] ?? 'N/A'),
                userInfoRow("First Name", userData['first_name'] ?? 'N/A'),
                userInfoRow("Last Name", userData['last_name'] ?? 'N/A'),
                userInfoRow("Gender", userData['gender'] ?? 'N/A'),
                userInfoRow("Age", userData['age']?.toString() ?? 'N/A'),
                // ... other user info fields ...
                SizedBox(height: 30),
                changePasswordButton(),
                SizedBox(height: 20),
                signOutButton(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget userInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

  Widget changePasswordButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, "changepassword");
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF61A6FF).withOpacity(0.55),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        "Change Password",
        style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic, fontWeight: FontWeight.w800, color: Colors.white),
      ),
    );
  }

  Widget signOutButton() {
    return ElevatedButton(
      onPressed: _signout,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF61A6FF).withOpacity(0.55),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        "Sign out",
        style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic, fontWeight: FontWeight.w800, color: Colors.white),
      ),
    );
  }
}
