import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import '../screens/about_us.dart';

class DrawerComponent extends StatelessWidget {
  const DrawerComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
    
      child: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          SizedBox(
            height: 200,
            child: Image.asset(
              'logo/logo.png',
              height: 180,
              width: 180,
            ),
          ),
          const Divider(
            height: 1,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
              size: 23,
            ),
            title: const Text('Home',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.share,
              size: 23,
            ),
            title: const Text('Share App',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            onTap: () {
              Share.share(
                  'https://play.google.com/store/apps/details?id=com.nimu.pdfreader');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.info,
              size: 23,
            ),
            title: const Text('About Us',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            onTap: () {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => const AboutUs()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.exit_to_app,
              size: 23,
            ),
            title: const Text('Exit App',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            onTap: () {
              exit(0);
            },
          ),
        ],
      ),
    );
  }
}
