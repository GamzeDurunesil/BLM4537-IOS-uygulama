import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'signup.dart';


void main() async {
  runApp(new MaterialApp(home: new firstpage()));
}

class firstpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color.fromRGBO(235, 235, 235, 1),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.all(30),
                  height: height * .3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/logo.png"),
                    ),
                  )),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: const SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Log in",
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
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignupPage()));
                },
                child: const SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Sign up",
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
    );
  }
}
