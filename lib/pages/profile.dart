import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/add_recipe.dart';
import 'package:flutter_application_1/pages/favorite.dart';
import 'package:flutter_application_1/firstpage.dart';
import 'package:flutter_application_1/pages/home.dart';

import 'package:flutter_application_1/pages/search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/pages/tariflerim.dart';

void main() {
  runApp(new MaterialApp(home: new profile()));
}

class profile extends StatefulWidget {
  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  final firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color.fromRGBO(235, 235, 235, 10),
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(235, 235, 235, 10),
        title: Row(
          children: [
            Container(
              margin: EdgeInsets.all(95),
              child: Text(
                "Profil",
                style: TextStyle(
                    color: Color.fromRGBO(154, 82, 26, 1), fontSize: 25),
              ),
            ),
            IconButton(
                onPressed: () async {
                  await firebaseAuth.signOut();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => firstpage()));
                },
                icon: const Icon(
                  Icons.logout_outlined,
                  color: Color.fromRGBO(154, 82, 26, 1),
                  size: 35,
                )),
          ],
        ),
        toolbarHeight: 100,
      ), //AppBars
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => tarif()));
                },
                child: const SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Tariflerim",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    primary: Color.fromRGBO(250, 250, 250, 100),
                    onPrimary: Color.fromRGBO(154, 82, 26, 100),
                    padding: const EdgeInsets.symmetric(vertical: 15)),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          height: 60,
          color: const Color.fromRGBO(250, 250, 250, 1.0),
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  icon: const Icon(
                    Icons.home_outlined,
                    color: Colors.black,
                    size: 35,
                  )),
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => search()));
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 35,
                  )),
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => fav()));
                  },
                  icon: const Icon(
                    Icons.favorite_border_outlined,
                    color: Colors.black,
                    size: 35,
                  )),
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => profile()));
                  },
                  icon: const Icon(
                    Icons.account_circle_outlined,
                    color: Colors.black,
                    size: 35,
                  ))
            ],
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(154, 82, 26, 1.0),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => addRecipe()));
        },
        child: const Icon(Icons.add, color: Colors.white, size: 25),
      ), //BottomNavigationBAr
    ); //Scaffold
  }
}
