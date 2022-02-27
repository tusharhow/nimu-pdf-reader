import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<bool> _launchURL(String url) async {
      try {
        await launch(
          url,
          enableJavaScript: true,
        );
        return true;
      } catch (e) {
        log(e.toString());
        return false;
      }
    }

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
              letterSpacing: 2,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          const Text(
            'Software Developer',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.10),
          // Social Media Buttons
          GestureDetector(
            onTap: () {
              _launchURL('https://www.facebook.com/tusharhow/');
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                const Icon(
                  Icons.facebook,
                  color: Colors.white,
                  size: 30,
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                const Text(
                  'Facebook',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )
              ]),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
              onTap: () {
                _launchURL('https://www.linkedin.com/in/tusharhow/');
              },
              child: Row(
                children: [
                  const Image(
                    image: AssetImage('logo/lin.png'),
                    height: 30,
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                  const Text(
                    'LinkedIn',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
              onTap: () {
                _launchURL('https://twitter.com/tusharhow');
              },
              child: Row(
                children: [
                  const Image(
                    image: AssetImage('logo/twitter.png'),
                    height: 30,
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                  const Text(
                    'Twitter',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
