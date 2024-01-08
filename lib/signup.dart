import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'firstpage.dart';

void main() {
  runApp(new MaterialApp(home: new SignupPage()));
}

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late String email, password;
  final formkey = GlobalKey<FormState>();
  final firebaseAuth = FirebaseAuth.instance;

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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      TextFormField(
                        // ignore: body_might_complete_normally_nullable
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Bilgileri eksiksiz girin";
                          } else {}
                        },
                        onSaved: (value) {
                          email = value!;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.mail,
                            color: Colors.black,
                          ),
                          hintText: "e-mail",
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      TextFormField(
                        // ignore: body_might_complete_normally_nullable
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Bilgileri eksiksiz girin";
                          } else {}
                        },
                        onSaved: (value) {
                          password = value!;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.vpn_key,
                            color: Colors.black,
                          ),
                          suffixIcon: Icon(
                            Icons.visibility,
                            color: Colors.black,
                          ),
                          hintText: "Password",
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.vpn_key,
                            color: Colors.black,
                          ),
                          suffixIcon: Icon(
                            Icons.visibility,
                            color: Colors.black,
                          ),
                          hintText: "Confirm Password",
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (formkey.currentState!.validate()) {
                    formkey.currentState!.save();
                    try {
                      var userResult =
                          await firebaseAuth.createUserWithEmailAndPassword(
                              email: email, password: password);
                      print(userResult.user!.uid);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    } catch (e) {
                      print(e.toString());
                    }
                  } else {}
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
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => firstpage()));
                },
                child: const SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Anasayfa",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 25,
                        color: Color.fromRGBO(154, 82, 26, 100),
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
