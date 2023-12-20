import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(child: Text('About Us',style: TextStyle(fontSize: 35,color: Color(0xFF61A6FF),fontWeight: FontWeight.w900),)),
            SizedBox(

              height: 50,
            ),
            Container(
              height: 250,
              width: 400,
              decoration: BoxDecoration(
                  color: Color(0xFF61A6FF).withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    width: 6,color:  Color(0xFF61A6FF),
                  )
              ),


              child: FadeInImage(

                placeholder: AssetImage('assets/images/eyes.jpg'),
                image: AssetImage('assets/images/eyes.jpg'),
                fit: BoxFit.cover,

              ),

            ),
            SizedBox(
              height: 20,
            ),
            Container(

              height: 480,
              width: 400,
              decoration: BoxDecoration(
                  color: Color(0xFF61A6FF).withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    width: 6,color:  Color(0xFF61A6FF),
                  )
              ),
              child: Column(


                children: [
                  Text("Introduction",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 30,color:Color(0xFF61A6FF) ),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text( textAlign: TextAlign.justify,"Welcome to Cataract Inspector, where cutting-edge technology meets compassionate healthcare. Our mission is to revolutionize the field of eye care through innovation and accessibility. With a commitment to advancing early detection of cataracts, we have developed a user-friendly app that puts the power of diagnosis right at your fingertips. At Cataract Inspector, we understand the critical importance of timely intervention in preserving vision and enhancing overall eye health. Our app empowers users to take control of their eye wellness by providing a simple yet powerful tool for cataract detection. Through seamless integration of state-of-the-art image recognition technology, users can capture a snapshot of their eyes, click a button, and receive instant, reliable results. Join us on this journey to make eye health a priority and embrace the future of cataract detection with Cataract Inspector. Your vision matters, and so do you."),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(

              height: 650,
              width: 400,
              decoration: BoxDecoration(
                  color: Color(0xFF61A6FF).withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    width: 6,color:  Color(0xFF61A6FF),
                  )
              ),
              child: Column(


                children: [
                  Text("Mission",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 30,color:Color(0xFF61A6FF) ),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text( textAlign: TextAlign.justify, "Our mission at Cataract Inspector is to provide impeccable results in the early stages of cataract detection. Through the seamless integration of state-of-the-art image recognition technology, we strive to offer a user-friendly platform that enables individuals to capture a snapshot of their eyes, click a button, and receive accurate and timely results. We are dedicated to advancing eye care by bridging the gap between technological innovation and compassionate healthcare, ensuring that the journey toward perfect vision begins with early and precise cataract detection. At Cataract Inspector, we envision a future where the mission of preserving and enhancing eyesight becomes a shared commitment, fostering a world where perfect eyes are within everyone's reach."),
                  ),
                  Text("Vision",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 30,color:Color(0xFF61A6FF) ),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text( textAlign: TextAlign.justify, " At Cataract Inspector, our vision is to perfect the art of eye care through cutting-edge technology and unwavering dedication. We aspire to redefine the landscape of cataract detection, setting a new standard for precision and early intervention. Committed to fostering a world where every individual experiences the joy of perfect vision, our vision is to illuminate the path toward proactive eye health and empower users with the tools to detect cataracts in their earliest stages."),
                  ),

                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Color(0xFF61A6FF).withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    width: 6,color:  Color(0xFF61A6FF),
                  )
              ),
              height: 450,
              width: 400,
              child: Column(


                children: [
                  Text("Technology and Innovation",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 30,color:Color(0xFF61A6FF) ),),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text( textAlign: TextAlign.justify,"Welcome to Cataract Inspector, where our dedication to excellence is embodied by a harmonious blend of state-of-the-art technologies and pioneering innovations. Fueled by Flutter, our app provides an intuitive and seamless user experience, placing the power of cataract detection directly in your hands. Behind the scenes, our deep convolutional neural networks (CNN) unravel the intricacies of eye health, ensuring precise and timely results. Firebase facilitates real-time interactions, creating a dynamic bridge between users and our robust backend, while MongoDB serves as the backbone, offering scalability to accommodate the intricate data needs of eye diagnostics. In the realm of Cataract Inspector, this potent synergy of Flutter, deep CNN, Firebase, and MongoDB forms the bedrock of our technological prowess, propelling us to the forefront of innovation in the vital mission of early-stage cataract detection.")
                  )],
              ),
            ),
          ],
        ),
      ),
    );
  }
}