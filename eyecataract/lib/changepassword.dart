import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  String currentPassword = '';
  String newPassword = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> changePassword() async{
    if(_formKey.currentState!.validate()){
      try {
        User user = _auth.currentUser!;
        AuthCredential credential = EmailAuthProvider.credential(
            email: user.email!, password: currentPassword);
        await user.reauthenticateWithCredential(credential);
        await user.updatePassword(newPassword);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Password change successfully",
              style: TextStyle(color: Colors.white),))
        );
      } on FirebaseAuthException catch (e){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.message ?? 'An Error Occured',style: TextStyle(color: Colors.white),))
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(

        preferredSize: Size.fromHeight(50), child: AppBar(
        backgroundColor: Colors.white,
        elevation: 4,
        title: Text("Change Password",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color: Color(0xFF61A6FF)),),
        iconTheme: IconThemeData(
            color: Colors.black
        ),

      ),
      ),
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Form(

          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText:'Current password',
                      filled: true,
                      fillColor: Colors.blue.withOpacity(0.07),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(
                          width: 4,color: Colors.white,

                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      )
                  ),
                  obscureText: true,
                  onChanged: (value)=> currentPassword=value,
                  validator: (value)=>value!.isEmpty?'please enter new password':null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(

                  decoration: InputDecoration(
                    labelText: 'New Password',
                    filled: true,
                    fillColor: Colors.blue.withOpacity(0.07),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(
                        width: 4,color: Colors.white,
                      ),
                    ),
                  ),
                  obscureText: true,

                  onChanged: (value) => newPassword = value,
                  validator: (value) => value!.isEmpty ? 'Please enter new password' : null,
                ),
              ),
              ElevatedButton(
                onPressed: changePassword,
                child: Text('Change Password'),
              ),
            ],
          ),


        ),
      ),

    );
  }
}