import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter/services.dart';

class First extends StatefulWidget {
  const First({super.key});

  @override
  State<First> createState() => _FirstState();
}

class _FirstState extends State<First> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(

        preferredSize: Size.fromHeight(50), child: AppBar(
        backgroundColor: Colors.white,
        elevation: 4,
        title: Center(child: Text("Cataract Inspector",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800,fontStyle: FontStyle.italic,color: Color(0xFF61A6FF)),)),
        iconTheme: IconThemeData(
            color: Colors.black
        ),

      ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:  EdgeInsets.only(top: 100,left: 14),
              child: Container(

                height: 130,
                width: 380,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.4),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50),bottomRight: Radius.circular(50),topLeft: Radius.circular(50)),
                  border: Border.all(
                      color: Colors.blue,
                      width: 4
                  ),

                ),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(top: 25,left: 50),
                          child: Text("Hey there !",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w900,color: Colors.black), ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 30),
                          child: Text("It's me",style: TextStyle(fontSize: 15, color: Colors.black), ),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(left: 45),
                          child: Text("Cataract Inspector",style: TextStyle(fontSize: 15,color: Colors.black), ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 60),
                      child: Image.asset('assets/images/cartoon.png',
                        fit: BoxFit.cover,


                      ),
                    )

                  ],
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(top: 70,right: 160),
              child: Text("Please",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 30),),
            ),
            Padding(
              padding: EdgeInsets.only(right: 125,),
              child: Text("choose to",style: TextStyle(fontSize: 30,color: Colors.black.withOpacity(0.2))),
            ),
            Padding(
              padding:  EdgeInsets.only(right: 105),
              child: Text("get started",style: TextStyle(fontSize: 32,color: Colors.black.withOpacity(0.2)),),
            ),
            SizedBox(
              height: 30,
            ),

            SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF61A6FF).withOpacity(0.55),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(20,),bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20))
                      )

                  ),
                  onPressed: (){
                    Navigator.pushNamed(context, 'login');
                  },

                  child: Text("Login your Account",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),)
              ),
            ),
            SizedBox(
              height: 15,
            ),

            SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF61A6FF).withOpacity(0.55),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(20,),bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20))
                      )

                  ),
                  onPressed: (){
                    Navigator.pushNamed(context, 'signup');
                  },

                  child: Text("Create your Account",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),)
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF61A6FF).withOpacity(0.55),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(20,),bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20))
                      )

                  ),
                  onPressed: (){
                    if(Platform.isAndroid)
                    {
                      SystemNavigator.pop();
                    }
                    else
                    {
                      return;
                    }

                  },

                  child: Text("Exit",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700),)
              ),
            ),

          ],
        ),
      ),
    );
  }
}