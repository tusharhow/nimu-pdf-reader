import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
          const Center(
            child: CircleAvatar(
              radius: 65,
              backgroundImage: AssetImage('logo/img.jpg'),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          const Text(
            'Tushar Mahmud',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          const Text(
            'Flutter Developer',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          // Social Media Buttons
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            IconButton(
                icon: Icon(
                  Icons.facebook,
                  color: Colors.white,
                ),
                onPressed: () {}),
            Text(
              'Facebook',
              style: TextStyle(color: Colors.white),
            )
          ]),
        ],
      ),
    );
  }
}
